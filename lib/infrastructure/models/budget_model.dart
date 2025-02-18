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

  factory Budget.fromMap(Map<String, dynamic> map) {
    return Budget(
      id: map['id'],
      userId: map['user_id'],
      name: map['name'],
      totalAmount: (map['total_amount'] as num).toDouble(),
      startDate: DateTime.parse(map['start_date']),
      endDate: DateTime.parse(map['end_date']),
      status: map['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'total_amount': totalAmount,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'status': status,
    };
  }
}
