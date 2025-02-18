class Category {
  final String id;
  final String userId;
  final String name;
  final String type;

  Category({
    required this.id,
    required this.userId,
    required this.name,
    required this.type,
  });

  Category copyWith({
    String? id,
    String? userId,
    String? name,
    String? type,
  }) {
    return Category(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      userId: map['user_id'],
      name: map['name'],
      type: map['type'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'type': type,
    };
  }
}
