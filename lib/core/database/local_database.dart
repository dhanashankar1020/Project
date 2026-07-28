import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path/path.dart' as p;

import 'dao/cached_places_dao.dart';
import 'dao/sync_metadata_dao.dart';
import 'migrations/migration_v1.dart';
import '../../features/safe_places/models/safe_place_model.dart';

/// Thread-safe singleton that owns the app's local SQLite database.
///
/// ## Initialisation
/// Call [ensureInitialized] once during app startup (e.g. in `main.dart`
/// or in a splash screen).  Subsequent calls are no-ops.
///
/// ## Access
/// ```dart
/// final db = await LocalDatabase.instance.ensureInitialized();
/// db.cachedPlacesDao.getNearbyPlaces(lat: 28.6, lng: 77.2);
/// ```
class LocalDatabase {
  LocalDatabase._();

  static final LocalDatabase instance = LocalDatabase._();

  // ── Internal state ────────────────────────────────────────────────────────
  sqflite.Database? _database;
  bool _isInitialized = false;

  // ── Public DAOs (set after init) ──────────────────────────────────────────
  late final CachedPlacesDao cachedPlacesDao;
  late final SyncMetadataDao syncMetadataDao;

  /// Whether the database has been opened at least once.
  bool get isInitialized => _isInitialized;

  /// Returns the raw database handle, or throws if not initialised.
  sqflite.Database get db {
    assert(_database != null, 'LocalDatabase must be initialised first');
    return _database!;
  }

  // ── Initialisation ────────────────────────────────────────────────────────

  /// Opens (or creates) the database and runs pending migrations.
  ///
  /// Safe to call multiple times — subsequent calls return immediately.
  ///
  /// Provide [seedPlaces] to populate the `cached_places` table on first
  /// launch (when the table is empty).  This is how the app's built-in
  /// static data gets into the database.
  Future<LocalDatabase> ensureInitialized({
    String? dbPathOverride,
    List<SafePlaceModel>? seedPlaces,
  }) async {
    if (_isInitialized) return this;

    if (kIsWeb) {
      cachedPlacesDao = CachedPlacesDao(null);
      syncMetadataDao = SyncMetadataDao(null);
      _isInitialized = true;
      debugPrint('[LocalDatabase] Web mode enabled — using no-op storage');
      return this;
    }

    final dbPath = dbPathOverride ??
        p.join(await sqflite.getDatabasesPath(), 'disaster_helper.db');

    _database = await sqflite.openDatabase(
      dbPath,
      version: MigrationV1.version,
      onCreate: (db, version) async {
        debugPrint('[LocalDatabase] Creating schema v$version');
        final batch = db.batch();
        await MigrationV1.up(batch);
        await batch.commit(noResult: true);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        debugPrint('[LocalDatabase] Upgrading v$oldVersion → v$newVersion');
        // Future migrations will be dispatched here by version.
      },
    );

    // Enable WAL mode for better concurrent read performance.
    await _database!.rawQuery('PRAGMA journal_mode=WAL');

    // Instantiate DAOs.
    cachedPlacesDao = CachedPlacesDao(_database!);
    syncMetadataDao = SyncMetadataDao(_database!);

    // Seed static data on first launch.
    if (seedPlaces != null && seedPlaces.isNotEmpty) {
      await _seedIfEmpty(seedPlaces);
    }

    _isInitialized = true;
    debugPrint('[LocalDatabase] Ready — ${await cachedPlacesDao.count()} places cached');
    return this;
  }

  /// Seeds the database only when the `cached_places` table is empty.
  Future<void> _seedIfEmpty(List<SafePlaceModel> places) async {
    final count = await cachedPlacesDao.count();
    if (count > 0) return;

    debugPrint('[LocalDatabase] Seeding ${places.length} static safe places…');
    // Seed data is permanent — source: 'seed' with TTL 0 (never expires).
    await cachedPlacesDao.upsertPlaces(
      places,
      source: 'seed',
      ttlSeconds: 0,
    );

    await syncMetadataDao.recordSync('seed', itemsCount: places.length);
  }

  // ── Cleanup ───────────────────────────────────────────────────────────────

  /// Closes the database connection.  After calling this, you must call
  /// [ensureInitialized] again before using any DAO.
  Future<void> close() async {
    await _database?.close();
    _database = null;
    _isInitialized = false;
  }
}
