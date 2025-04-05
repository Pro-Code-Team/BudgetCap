class Account {
  final int? id;
  final String name;
  final String description;
  final String currency;
  final double balance;
  final String icon;
  final String color;

  Account({
    this.id,
    required this.name,
    required this.description,
    required this.currency,
    required this.icon,
    required this.balance,
    required this.color,
  });

  Account copyWith({
    int? id,
    String? name,
    String? description,
    String? currency,
    double? balance,
    String? icon,
    String? color,
  }) {
    return Account(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      currency: currency ?? this.currency,
      balance: balance ?? this.balance,
      icon: icon ?? this.icon,
      color: color ?? this.color,
    );
  }
}
