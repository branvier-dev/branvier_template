import 'package:shared_preferences/shared_preferences.dart';

import 'cache_service.dart';

class SharedCacheService extends CacheService {
  SharedCacheService(this.prefs);
  final SharedPreferences prefs;

  static Future<SharedCacheService> init() async {
    return SharedCacheService(await SharedPreferences.getInstance());
  }

  @override
  Future<void> clear() => prefs.clear();

  @override
  String? get(String key) => prefs.getString(key);

  @override
  Future<void> remove(String key) => prefs.remove(key);

  @override
  Future<void> set(String key, String value) => prefs.setString(key, value);
}
