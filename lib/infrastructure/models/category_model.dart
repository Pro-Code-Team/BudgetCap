class CategoryModel {
  final String id;
  final String userId;
  final String name;
  final String type;
  final String icon; // New field for the category icon

  CategoryModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.type,
    required this.icon, // Include the new field in the constructor
  });

  CategoryModel copyWith({
    String? id,
    String? userId,
    String? name,
    String? type,
    String? icon, // Include the new field in the copyWith method
  }) {
    return CategoryModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      type: type ?? this.type,
      icon: icon ?? this.icon, // Include the new field in the copyWith method
    );
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
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
