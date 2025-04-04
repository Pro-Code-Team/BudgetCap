class Category {
  final int? id;
  final String name;
  final String icon;
  final String description;

  Category({
    this.id,
    required this.name,
    required this.icon,
    required this.description,
  });

  Category copyWith({
    int? id,
    String? name,
    String? icon,
    String? description,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      description: description ?? this.description,
    );
  }
}
