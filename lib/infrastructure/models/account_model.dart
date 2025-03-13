class AccountModel {
  final String id;
  final String name;
  final String description;

  AccountModel({
    required this.id,
    required this.name,
    required this.description,
  });

  factory AccountModel.fromMap(Map<String, dynamic> map) {
    return AccountModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}
