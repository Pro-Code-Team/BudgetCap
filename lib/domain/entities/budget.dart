class Budget {
  final String id;
  final String userId;
  final String name;
  final double totalAmount;
  final DateTime startDate;
  final DateTime endDate;
  final String status;

  Budget({
    required this.id,
    required this.userId,
    required this.name,
    required this.totalAmount,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  Budget copyWith({
    String? id,
    String? userId,
    String? name,
    double? totalAmount,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
  }) {
    return Budget(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      totalAmount: totalAmount ?? this.totalAmount,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
    );
  }
}
