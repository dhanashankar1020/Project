import 'dart:math' as math;

import 'package:sqflite/sqflite.dart';

import '../../../features/safe_places/models/safe_place_model.dart';
import '../tables/cached_places_table.dart';

/// Data-access object for the `cached_places` table.
///
/// Provides CRUD operations, nearest-place geo-queries (via Haversine
/// in Dart after an efficient bounding-box filter), and a bulk-upsert
/// designed for Overpass API responses.
class CachedPlacesDao {
  CachedPlacesDao(this._db);

  final Database? _db;

  // ── Read ─────────────────────────────────────────────────────────────────

  /// Returns all places whose cached data is still fresh (within TTL).
  Future<List<SafePlaceModel>> getAllFresh() async {
    if (_db == null) return [];

    final rows = await _db.query(
      CachedPlacesTable.tableName,
      where:
          "freshness > strftime('%Y-%m-%dT%H:%M:%S','now', '-' || ttl_seconds || ' seconds')",
      orderBy: 'name ASC',
    );
    return rows.map(_toPlaceModel).toList();
  }

  /// Returns places filtered by [category], limited to fresh entries only.
  Future<List<SafePlaceModel>> getByCategory(String category) async {
    if (_db == null) return [];

    final rows = await _db.query(
      CachedPlacesTable.tableName,
      where:
          "category = ? AND freshness > strftime('%Y-%m-%dT%H:%M:%S','now', '-' || ttl_seconds || ' seconds')",
      whereArgs: [category],
      orderBy: 'name ASC',
    );
    return rows.map(_toPlaceModel).toList();
  }

  /// Returns fresh places near a given coordinate, sorted by distance.
  ///
  /// If [category] is null or 'All', returns all categories.
  ///
  /// Internally does an efficient bounding-box pre-filter in SQL, then
  /// computes exact great-circle distance in Dart using the Haversine
  /// formula (avoids dependency on SQLite math extensions).
  Future<List<SafePlaceModel>> getNearbyPlaces({
    required double lat,
    required double lng,
    String? category,
    int limit = 30,
    double radiusKm = 10.0,
  }) async {
    // Bounding box (roughly 1° ≈ 111 km).
    final double degDelta = radiusKm / 111.0;      final List<String> whereClauses = [
        "latitude BETWEEN ? AND ?",
        "longitude BETWEEN ? AND ?",
        "freshness > strftime('%Y-%m-%dT%H:%M:%S','now', '-' || ttl_seconds || ' seconds')",
      ];
    final List<dynamic> whereArgs = [
      lat - degDelta,
      lat + degDelta,
      lng - degDelta,
      lng + degDelta,
    ];

    if (category != null && category != 'All') {
      whereClauses.add('category = ?');
      whereArgs.add(category);
    }

    if (_db == null) return [];

    final rows = await _db.query(
      CachedPlacesTable.tableName,
      where: whereClauses.join(' AND '),
      whereArgs: whereArgs,
      limit: limit * 2, // fetch extra since bounding-box may include far points
    );

    // Compute exact distance and sort.
    final List<_PlaceWithDistance> scored = [];
    for (final row in rows) {
      final place = _toPlaceModel(row);
      final distKm = _haversine(lat, lng, place.latitude, place.longitude);
      if (distKm <= radiusKm) {
        scored.add(_PlaceWithDistance(place: place, distanceKm: distKm));
      }
    }

    scored.sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
    return scored.take(limit).map((s) => s.place).toList();
  }

  /// Returns a single place by its [id], or `null`.
  Future<SafePlaceModel?> getById(String id) async {
    if (_db == null) return null;

    final rows = await _db.query(
      CachedPlacesTable.tableName,
      where: '${CachedPlacesTable.columnId} = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return _toPlaceModel(rows.first);
  }

  // ── Write ─────────────────────────────────────────────────────────────────

  /// Inserts or replaces a single place.
  Future<void> upsertPlace(SafePlaceModel place) async {
    if (_db == null) return;

    await _db.insert(
      CachedPlacesTable.tableName,
      _fromPlaceModel(place),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Bulk upsert — inserts a list of places inside a single transaction.
  ///
  /// This is the primary write path for Overpass API responses.
  /// Pass [source] and [ttlSeconds] to override the defaults (e.g.
  /// `source: 'seed', ttlSeconds: 0` for permanent baseline data).
  Future<void> upsertPlaces(
    List<SafePlaceModel> places, {
    String source = 'local',
    int ttlSeconds = 604800,
  }) async {
    if (_db == null) return;

    await _db.transaction((txn) async {
      final batch = txn.batch();
      for (final place in places) {
        batch.insert(
          CachedPlacesTable.tableName,
          _fromPlaceModel(place, source: source, ttlSeconds: ttlSeconds),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      await batch.commit(noResult: true);
    });
  }

  /// Deletes stale entries (where freshness + ttl < now).
  Future<int> deleteStale() async {
    if (_db == null) return 0;

    return await _db.delete(
      CachedPlacesTable.tableName,
      where: "freshness <= datetime('now', '-' || ttl_seconds || ' seconds')",
    );
  }

  /// Deletes every row — useful during a full re-seed.
  Future<void> deleteAll() async {
    if (_db == null) return;

    await _db.delete(CachedPlacesTable.tableName);
  }

  /// Returns the count of fresh entries.
  Future<int> count() async {
    if (_db == null) return 0;

    final result = await _db.rawQuery(
      "SELECT COUNT(*) AS cnt FROM ${CachedPlacesTable.tableName} "
      "WHERE freshness > datetime('now', '-' || ttl_seconds || ' seconds')",
    );
    return result.first['cnt'] as int;
  }

  // ── Mapping helpers ───────────────────────────────────────────────────────

  /// Converts a [SafePlaceModel] to a database row map.
  ///
  /// [source] and [ttlSeconds] are explicit so callers can distinguish
  /// seed data (source: 'seed', ttlSeconds: 0) from API-fetched data
  /// (source: 'overpass', ttlSeconds: 604800).
  Map<String, dynamic> _fromPlaceModel(
    SafePlaceModel p, {
    String source = 'local',
    int ttlSeconds = 604800,
  }) =>
      {
        CachedPlacesTable.columnId: p.id,
        CachedPlacesTable.columnName: p.name,
        CachedPlacesTable.columnCategory: p.category,
        CachedPlacesTable.columnDescription: p.description,
        CachedPlacesTable.columnAddress: p.address,
        CachedPlacesTable.columnContact: p.contactNumber,
        CachedPlacesTable.columnIs24h: p.isOpen24Hours ? 1 : 0,
        CachedPlacesTable.columnIsGovt: p.isGovernment ? 1 : 0,
        CachedPlacesTable.columnImagePath: p.image,
        CachedPlacesTable.columnLatitude: p.latitude,
        CachedPlacesTable.columnLongitude: p.longitude,
        CachedPlacesTable.columnSource: source,
        CachedPlacesTable.columnFreshness:
            DateTime.now().toUtc().toIso8601String().split('.').first,
        CachedPlacesTable.columnTtlSeconds: ttlSeconds,
      };

  SafePlaceModel _toPlaceModel(Map<String, dynamic> row) => SafePlaceModel(
        id: row[CachedPlacesTable.columnId] as String,
        name: row[CachedPlacesTable.columnName] as String,
        category: row[CachedPlacesTable.columnCategory] as String,
        description: row[CachedPlacesTable.columnDescription] as String,
        address: row[CachedPlacesTable.columnAddress] as String,
        contactNumber: row[CachedPlacesTable.columnContact] as String,
        isOpen24Hours: (row[CachedPlacesTable.columnIs24h] as int) == 1,
        isGovernment: (row[CachedPlacesTable.columnIsGovt] as int) == 1,
        image: row[CachedPlacesTable.columnImagePath] as String,
        latitude: (row[CachedPlacesTable.columnLatitude] as num).toDouble(),
        longitude: (row[CachedPlacesTable.columnLongitude] as num).toDouble(),
      );

  // ── Haversine (great-circle distance) ─────────────────────────────────────

  static double _haversine(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const double earthRadiusKm = 6371;
    final double dLat = _toRadians(lat2 - lat1);
    final double dLon = _toRadians(lon2 - lon1);
    final double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_toRadians(lat1)) *
            math.cos(_toRadians(lat2)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);
    final double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadiusKm * c;
  }

  static double _toRadians(double deg) => deg * math.pi / 180;
}

/// Internal helper to pair a place with its computed distance.
class _PlaceWithDistance {
  final SafePlaceModel place;
  final double distanceKm;
  const _PlaceWithDistance({required this.place, required this.distanceKm});
}
