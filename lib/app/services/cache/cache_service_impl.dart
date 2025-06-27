import 'package:shared_preferences/shared_preferences.dart';

import '../../app_analytics.dart';
import 'cache_service.dart';

class CacheServiceImpl extends CacheService {
  CacheServiceImpl(this.prefs);
  final SharedPreferences prefs;
  final source = 'CacheService';

  static Future<CacheServiceImpl> async() async {
    return CacheServiceImpl(await SharedPreferences.getInstance());
  }

  @override
  String? get(String key) => prefs.getString(key);

  @override
  Future<void> set(String key, String value) async {
    await prefs.setString(key, value);
    logarte.database(target: key, value: value, source: source);
    refresh();
  }

  @override
  Future<void> clear() async {
    await prefs.clear();
    logarte.database(target: source, value: null, source: source);
    refresh();
  }

  @override
  Future<void> remove(String key) async {
    await prefs.remove(key);
    logarte.database(target: key, value: null, source: source);
    refresh();
  }
}
