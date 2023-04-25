import 'dart:convert';

class Test {
  Test({
    this.a,
    this.b,
  });
  factory Test.fromJson(String source) => Test.fromMap(json.decode(source));

  factory Test.fromMap(Map<String, dynamic> map) {
    return Test(
      a: map['a'],
      b: map['b']?.toInt(),
    );
  }
  final String? a;
  final int? b;

  Test copyWith({
    String? a,
    int? b,
  }) {
    return Test(
      a: a ?? this.a,
      b: b ?? this.b,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'a': a,
      'b': b,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'Test(a: $a, b: $b)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Test && other.a == a && other.b == b;
  }

  @override
  int get hashCode => a.hashCode ^ b.hashCode;
}
