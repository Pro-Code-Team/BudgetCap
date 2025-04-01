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

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      currency: map['currency'],
      icon: map['icon'],
      balance: map['balance'],
      color: map['color'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'currency': currency,
      'icon': icon,
      'balance': balance,
      'color': color,
    };
  }
}
