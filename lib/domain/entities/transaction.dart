class Transaction {
  final String id;
  final String userId;
  final String accountId;
  final String categoryId;
  final String? budgetId;
  final double amount;
  final String transactionType;
  final DateTime date;
  final String description;

  Transaction({
    required this.id,
    required this.userId,
    required this.accountId,
    required this.categoryId,
    this.budgetId,
    required this.amount,
    required this.transactionType,
    required this.date,
    required this.description,
  });

  Transaction copyWith({
    String? id,
    String? userId,
    String? accountId,
    String? categoryId,
    String? budgetId,
    double? amount,
    String? transactionType,
    DateTime? date,
    String? description,
  }) {
    return Transaction(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      accountId: accountId ?? this.accountId,
      categoryId: categoryId ?? this.categoryId,
      budgetId: budgetId ?? this.budgetId,
      amount: amount ?? this.amount,
      transactionType: transactionType ?? this.transactionType,
      date: date ?? this.date,
      description: description ?? this.description,
    );
  }
}
