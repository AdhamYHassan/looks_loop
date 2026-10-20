import 'package:hive/hive.dart';

/// Contract for local caching of home data (e.g., announcements).
abstract interface class HomeLocalDataSource {
  Future<List<String>?> getCachedAnnouncements();
  Future<void> cacheAnnouncements(List<String> announcements);
  Future<void> clearCache();
}

/// Hive implementation for caching home data without code generation.
class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  static const String boxName = 'home_cache_box';
  static const String _announcementsKey = 'cached_announcements';

  final Box<dynamic> _box;

  const HomeLocalDataSourceImpl(this._box);

  @override
  Future<List<String>?> getCachedAnnouncements() async {
    final rawData = _box.get(_announcementsKey);
    if (rawData == null || rawData is! List) return null;
    return rawData.map((e) => e.toString()).toList();
  }

  @override
  Future<void> cacheAnnouncements(List<String> announcements) async {
    await _box.put(_announcementsKey, announcements);
  }

  @override
  Future<void> clearCache() async {
    await _box.delete(_announcementsKey);
  }
}
