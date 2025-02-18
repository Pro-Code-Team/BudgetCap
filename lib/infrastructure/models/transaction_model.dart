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

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      userId: map['user_id'],
      accountId: map['account_id'],
      categoryId: map['category_id'],
      budgetId: map['budget_id'],
      amount: (map['amount'] as num).toDouble(),
      transactionType: map['transaction_type'],
      date: DateTime.parse(map['date']),
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'account_id': accountId,
      'category_id': categoryId,
      'budget_id': budgetId,
      'amount': amount,
      'transaction_type': transactionType,
      'date': date.toIso8601String(),
      'description': description,
    };
  }
}
