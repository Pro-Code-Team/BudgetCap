class Category {
  final String id;
  final String userId;
  final String name;
  final String type;
  final String icon; // New field for the category icon

  Category({
    required this.id,
    required this.userId,
    required this.name,
    required this.type,
    required this.icon, // Include the new field in the constructor
  });

  Category copyWith({
    String? id,
    String? userId,
    String? name,
    String? type,
    String? icon, // Include the new field in the copyWith method
  }) {
    return Category(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      type: type ?? this.type,
      icon: icon ?? this.icon, // Include the new field in the copyWith method
    );
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      userId: map['user_id'],
      name: map['name'],
      type: map['type'],
      icon: map['icon'], // Include the new field in the fromMap factory
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'type': type,
      'icon': icon, // Include the new field in the toMap method
    };
  }
}
