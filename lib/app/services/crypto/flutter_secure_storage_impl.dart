import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'crypto_service.dart';

class FlutterSecureStorageImpl implements CryptoService {
  final service = const FlutterSecureStorage();

  @override
  Future<String?> get(String key) {
    return service.read(key: key);
  }

  @override
  Future<void> set(String key, String value) {
    return service.write(key: key, value: value);
  }

  @override
  Future<void> delete(String key) {
    return service.delete(key: key);
  }

  @override
  Future<void> clear() {
    return service.deleteAll();
  }
}
