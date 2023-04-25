// import 'package:branvier/branvier.dart';
// import 'package:get_storage/get_storage.dart';

// ///User preferences.
// class GetBox implements IOpenBox {
//   ///The storage driver api.
//   final _storage = GetStorage();

//   //Init [GetStorage].
//   static Future<void> init() => GetStorage.init();

//   @override
//   T? read<T>(key, {or}) => _storage.read(key) ?? or;

//   @override
//   Future<void> write(key, value) => _storage.write(key, value);

//   @override
//   Future<void> delete(key) => _storage.remove(key);

//   @override
//   Future<void> deleteAll() async => _storage.erase();

//   @override
//   Map<String, dynamic> readAll() {
//     final keys = List.from(_storage.getKeys());
//     return Map.fromEntries(
//       keys.map((key) => MapEntry(key, _storage.read(key))),
//     );
//   }
// }
