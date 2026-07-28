import 'package:sqflite/sqflite.dart';

/// Migration v1: Initial schema for the local database.
///
/// Creates three tables:
/// - [cached_places] — stores safe places from both static data and API
/// - [cached_ai_responses] — stores Gemini/offline AI responses for offline replay
/// - [sync_metadata] — tracks per-source sync status and TTL scheduling
class MigrationV1 {
  static const int version = 1;

  static Future<void> up(Batch batch) async {
    // ── Cached Places ────────────────────────────────────────────────────────
    batch.execute('''
      CREATE TABLE cached_places (
        id            TEXT PRIMARY KEY,
        name          TEXT NOT NULL,
        category      TEXT NOT NULL,
        description   TEXT NOT NULL DEFAULT '',
        address       TEXT NOT NULL DEFAULT '',
        contact       TEXT NOT NULL DEFAULT '',
        is_24h        INTEGER NOT NULL DEFAULT 0,
        is_govt       INTEGER NOT NULL DEFAULT 0,
        image_path    TEXT NOT NULL DEFAULT '',
        latitude      REAL NOT NULL,
        longitude     REAL NOT NULL,
        source        TEXT NOT NULL DEFAULT 'local',
        freshness     TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%S','now')),
        ttl_seconds   INTEGER NOT NULL DEFAULT 604800
      )
    ''');

    batch.execute('CREATE INDEX idx_places_category ON cached_places(category)');
    batch.execute('CREATE INDEX idx_places_coords ON cached_places(latitude, longitude)');
    batch.execute('CREATE INDEX idx_places_source ON cached_places(source)');
    batch.execute('CREATE INDEX idx_places_freshness ON cached_places(freshness)');

    // ── Cached AI Responses ─────────────────────────────────────────────────
    batch.execute('''
      CREATE TABLE cached_ai_responses (
        query_hash    TEXT PRIMARY KEY,
        query_text    TEXT NOT NULL,
        response_text TEXT NOT NULL,
        intent_type   TEXT,
        created_at    TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%S','now')),
        expires_at    TEXT NOT NULL
      )
    ''');

    batch.execute('CREATE INDEX idx_ai_expires ON cached_ai_responses(expires_at)');

    // ── Sync Metadata ────────────────────────────────────────────────────────
    batch.execute('''
      CREATE TABLE sync_metadata (
        source        TEXT PRIMARY KEY,
        last_sync_at  TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%S','now')),
        next_sync_at  TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%S','now')),
        sync_status   TEXT NOT NULL DEFAULT 'idle',
        error_message TEXT,
        items_count   INTEGER NOT NULL DEFAULT 0
      )
    ''');
  }
}
