/// Schema constants for the `cached_places` table.
///
/// Stores safe places (hospitals, shelters, police stations, etc.)
/// that have been either seeded from static data or fetched from the
/// Overpass API. Each row tracks its own freshness so stale entries
/// can be purged or refreshed.
class CachedPlacesTable {
  CachedPlacesTable._();

  static const String tableName = 'cached_places';

  // ── Columns ───────────────────────────────────────────────────────────────
  static const String columnId = 'id';
  static const String columnName = 'name';
  static const String columnCategory = 'category';
  static const String columnDescription = 'description';
  static const String columnAddress = 'address';
  static const String columnContact = 'contact';
  static const String columnIs24h = 'is_24h';
  static const String columnIsGovt = 'is_govt';
  static const String columnImagePath = 'image_path';
  static const String columnLatitude = 'latitude';
  static const String columnLongitude = 'longitude';
  static const String columnSource = 'source';
  static const String columnFreshness = 'freshness';
  static const String columnTtlSeconds = 'ttl_seconds';

  /// All column names in a list (useful for query helpers).
  static const List<String> allColumns = [
    columnId,
    columnName,
    columnCategory,
    columnDescription,
    columnAddress,
    columnContact,
    columnIs24h,
    columnIsGovt,
    columnImagePath,
    columnLatitude,
    columnLongitude,
    columnSource,
    columnFreshness,
    columnTtlSeconds,
  ];
}
