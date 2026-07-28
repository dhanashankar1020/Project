/// Schema constants for the `sync_metadata` table.
///
/// Tracks per-source synchronisation state so the app knows when a
/// source was last refreshed and when it should be refreshed next.
class SyncMetadataTable {
  SyncMetadataTable._();

  static const String tableName = 'sync_metadata';

  // ── Columns ───────────────────────────────────────────────────────────────
  static const String columnSource = 'source';
  static const String columnLastSyncAt = 'last_sync_at';
  static const String columnNextSyncAt = 'next_sync_at';
  static const String columnSyncStatus = 'sync_status';
  static const String columnErrorMessage = 'error_message';
  static const String columnItemsCount = 'items_count';

  /// Pre-defined source identifiers.
  static const String sourceOverpass = 'overpass';
  static const String sourceGemini = 'gemini';
  static const String sourceSeed = 'seed';

  /// Sync status values.
  static const String statusIdle = 'idle';
  static const String statusSyncing = 'syncing';
  static const String statusFailed = 'failed';

  static const List<String> allColumns = [
    columnSource,
    columnLastSyncAt,
    columnNextSyncAt,
    columnSyncStatus,
    columnErrorMessage,
    columnItemsCount,
  ];
}
