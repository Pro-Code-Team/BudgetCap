class AccountModel {
  final int? id;
  final String name;
  final String description;
  final String currency;
  final String icon;
  final String color;

  AccountModel({
    this.id,
    required this.name,
    required this.description,
    required this.currency,
    required this.icon,
    required this.color,
  });

  factory AccountModel.fromMap(Map<String, dynamic> map) {
    return AccountModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      currency: map['currency'],
      icon: map['icon'],
      color: map['color'],
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {
      'name': name,
      'description': description,
      'currency': currency,
      'icon': icon,
      'color': color,
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }
}
