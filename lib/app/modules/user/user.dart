import 'dart:convert';

class User {
  final String id;
  final String email;
  User({
    required this.id,
    required this.email,
  });

  User copyWith({
    String? id,
    String? email,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    T isA<T>(k) => map[k] is T ? map[k] : throw ArgumentError.value(map[k], k);
    return User(
      id: isA<String>('id'),
      email: isA<String>('email'),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() => 'User(id: $id, email: $email)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User && other.id == id && other.email == email;
  }

  @override
  int get hashCode => id.hashCode ^ email.hashCode;
}
