import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'storage_service.dart';

class HiveImpl implements StorageService {
  const HiveImpl(this.service);
  final Box<String> service;

  static Future<HiveImpl> init() async {
    String? path;

    if (!kIsWeb) {
      final directory = await getApplicationSupportDirectory();
      path = directory.path;
    }

    // Hive must only be initialized once. Others must use `Hive.init(null)`
    Hive.init(path);

    final box = await Hive.openBox<String>('storage');

    return HiveImpl(box);
  }

  @override
  String? get(String key) => service.get(key);

  @override
  Future<void> set(String key, String value) {
    return service.put(key, value);
  }

  @override
  Future<void> remove(String key) {
    return service.delete(key);
  }

  @override
  Future<void> clear() {
    return service.clear();
  }
}
