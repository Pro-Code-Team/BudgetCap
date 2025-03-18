class CategoryModel {
  final int? id;
  final String name;
  final String icon;
  final String description;

  CategoryModel({
    this.id,
    required this.name,
    required this.icon,
    required this.description,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      name: map['name'],
      icon: map['icon'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'description': description,
    };
  }
}
