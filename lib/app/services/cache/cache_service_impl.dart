import 'package:shared_preferences/shared_preferences.dart';

import 'cache_service.dart';

class CacheServiceImpl extends CacheService {
  CacheServiceImpl(this.prefs);
  final SharedPreferences prefs;

  static Future<CacheServiceImpl> init() async {
    return CacheServiceImpl(await SharedPreferences.getInstance());
  }

  @override
  String? get(String key) => prefs.getString(key);

  @override
  Future<void> set(String key, String value) async {
    await prefs.setString(key, value);
    refresh();
  }

  @override
  Future<void> clear() async {
    await prefs.clear();
    refresh();
  }

  @override
  Future<void> remove(String key) async {
    await prefs.remove(key);
    refresh();
  }
}
