// import 'dart:convert';

// // Name: Dart Safe Data Class Generator
// // VS Marketplace Link: https://marketplace.visualstudio.com/items?itemName=ArthurMiranda.dart-safe-data-class
// class CartItem {
//   CartItem({
//     required this.id,
//   });

//   factory CartItem.fromJson(String source) =>
//       CartItem.fromMap(json.decode(source));

//   factory CartItem.fromMap(Map<String, dynamic> map) {
//     T isA<T>(k) => map[k] is T ? map[k] : throw ArgumentError.value(map[k], k);
//     return CartItem(
//       id: isA<String>('id'),
//     );
//   }

//   final String id;

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is CartItem && other.id == id;
//   }

//   @override
//   int get hashCode => id.hashCode;

//   @override
//   String toString() => 'Cart(id: $id)';

//   CartItem copyWith({
//     String? id,
//   }) {
//     return CartItem(
//       id: id ?? this.id,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//     };
//   }

//   String toJson() => json.encode(toMap());
// }
