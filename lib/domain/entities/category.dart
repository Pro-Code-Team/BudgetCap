class Category {
  final String id;
  final String userId;
  final String icon;
  final String name;
  final String type;

  Category({
    required this.id,
    required this.userId,
    required this.name,
    required this.icon,
    required this.type,
  });

  Category copyWith({
    String? id,
    String? userId,
    String? name,
    String? icon,
    String? type,
  }) {
    return Category(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      type: type ?? this.type,
    );
  }
}
