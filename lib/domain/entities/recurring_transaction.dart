class RecurringTransaction {
  final String id;
  final String userId;
  final String accountId;
  final String categoryId;
  final double amount;
  final String frequency;
  final DateTime nextOccurrenceDate;
  final DateTime? endDate;
  final String status;

  RecurringTransaction({
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

  RecurringTransaction copyWith({
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
    return RecurringTransaction(
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
}
