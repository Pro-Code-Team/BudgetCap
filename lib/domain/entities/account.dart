class Account {
  final String id;
  final String userId;
  final String name;
  final double balance;
  final String accountType;
  final DateTime createdAt;
  final DateTime updatedAt;

  Account({
    required this.id,
    required this.userId,
    required this.name,
    required this.balance,
    required this.accountType,
    required this.createdAt,
    required this.updatedAt,
  });

  Account copyWith({
    String? id,
    String? userId,
    String? name,
    double? balance,
    String? accountType,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Account(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      balance: balance ?? this.balance,
      accountType: accountType ?? this.accountType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
