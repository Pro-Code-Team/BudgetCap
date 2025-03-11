class RecurringTransactionModel {
  final String id;
  final String userId;
  final String accountId;
  final String categoryId;
  final double amount;
  final String frequency;
  final DateTime nextOccurrenceDate;
  final DateTime? endDate;
  final String status;

  RecurringTransactionModel({
    required this.id,
    required this.userId,
    required this.accountId,
    required this.categoryId,
    required this.amount,
    required this.frequency,
    required this.nextOccurrenceDate,
    this.endDate,
    required this.status,
  });

  RecurringTransactionModel copyWith({
    String? id,
    String? userId,
    String? accountId,
    String? categoryId,
    double? amount,
    String? frequency,
    DateTime? nextOccurrenceDate,
    DateTime? endDate,
    String? status,
  }) {
    return RecurringTransactionModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      accountId: accountId ?? this.accountId,
      categoryId: categoryId ?? this.categoryId,
      amount: amount ?? this.amount,
      frequency: frequency ?? this.frequency,
      nextOccurrenceDate: nextOccurrenceDate ?? this.nextOccurrenceDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
    );
  }

  factory RecurringTransactionModel.fromMap(Map<String, dynamic> map) {
    return RecurringTransactionModel(
      id: map['id'],
      userId: map['user_id'],
      accountId: map['account_id'],
      categoryId: map['category_id'],
      amount: (map['amount'] as num).toDouble(),
      frequency: map['frequency'],
      nextOccurrenceDate: DateTime.parse(map['next_occurrence_date']),
      endDate: map['end_date'] != null ? DateTime.parse(map['end_date']) : null,
      status: map['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'account_id': accountId,
      'category_id': categoryId,
      'amount': amount,
      'frequency': frequency,
      'next_occurrence_date': nextOccurrenceDate.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'status': status,
    };
  }
}
