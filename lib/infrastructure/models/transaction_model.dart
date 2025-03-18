class TransactionModel {
  final int? id;
  final int accountId;
  final int categoryId;
  final double amount;
  final String type;
  final DateTime date;
  final String description;

  TransactionModel({
    this.id,
    required this.accountId,
    required this.categoryId,
    required this.amount,
    required this.type,
    required this.date,
    required this.description,
  });

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      accountId: map['account_id'],
      categoryId: map['category_id'],
      amount: map['amount'],
      type: map['type'],
      date: DateTime.parse(map['date']),
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {
      'account_id': accountId,
      'category_id': categoryId,
      'amount': amount,
      'type': type,
      'date': date.toIso8601String(),
      'description': description,
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }
}
