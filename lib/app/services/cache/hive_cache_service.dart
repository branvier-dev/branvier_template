import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'cache_service.dart';

class HiveCacheService implements CacheService {
  const HiveCacheService(this.box);
  final Box<String> box;

  static Future<HiveCacheService> init() async {
    String? path;

    if (!kIsWeb) {
      final directory = await getApplicationSupportDirectory();
      path = directory.path;
    }

    // Hive must only be initialized once. Others must use `Hive.init(null)`
    Hive.init(path);

    final box = await Hive.openBox<String>('cache');

    return HiveCacheService(box);
  }

  @override
  String? get(String key) => box.get(key);

  @override
  Future<void> set(String key, String value) {
    return box.put(key, value);
  }

  @override
  Future<void> remove(String key) {
    return box.delete(key);
  }

  @override
  Future<void> clear() {
    return box.clear();
  }
}
