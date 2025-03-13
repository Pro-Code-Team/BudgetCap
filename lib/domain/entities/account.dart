class Account {
  final String id;
  final String name;
  final String description;

  Account({
    required this.id,
    required this.name,
    required this.description,
  });

  Account copyWith({
    String? id,
    String? name,
    String? description,
  }) {
    return Account(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }
}
