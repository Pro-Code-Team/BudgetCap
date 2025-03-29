import 'package:budgetcap/config/constants/constants.dart';

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
    try {
      // Validar y asignar valores
      final int? id = map['id'];
      final int accountId =
          map['account_id'] ?? (throw Exception('account_id is required'));
      final int categoryId =
          map['category_id'] ?? (throw Exception('category_id is required'));
      final double amount = (map['amount'] is int)
          ? (map['amount'] as int).toDouble()
          : (map['amount'] is double)
              ? map['amount']
              : (throw Exception('amount must be a number'));
      final Operations type = OperationsExtension.fromName(map['type']);
      final DateTime date =
          map['date'] != null ? DateTime.parse(map['date']) : DateTime.now();
      final String description =
          map['description'] ?? (throw Exception('description is required'));

      // Crear y devolver la instancia
      return TransactionModel(
        id: id,
        accountId: accountId,
        categoryId: categoryId,
        amount: amount,
        type: type.name,
        date: date,
        description: description,
      );
    } catch (e) {
      throw Exception('Error parsing TransactionModel: $e');
    }
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
