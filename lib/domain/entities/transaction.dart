class Transaction {
  final int id;
  final int accountId;
  final int categoryId;
  final double amount;
  final String type;
  final DateTime date;
  final String description;

  Transaction({
    required this.id,
    required this.accountId,
    required this.categoryId,
    required this.amount,
    required this.type,
    required this.date,
    required this.description,
  });

  Transaction copyWith({
    int? id,
    int? accountId,
    int? categoryId,
    double? amount,
    String? type,
    DateTime? date,
    String? description,
  }) {
    return Transaction(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      categoryId: categoryId ?? this.categoryId,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      date: date ?? this.date,
      description: description ?? this.description,
    );
  }
}
