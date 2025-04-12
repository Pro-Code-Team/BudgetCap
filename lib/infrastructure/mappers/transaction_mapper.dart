import 'package:budgetcap/domain/entities/transaction.dart';
import 'package:budgetcap/infrastructure/models/transaction_model.dart';

class TransactionMapper {
  static TransactionModel toModel(Transaction entity) {
    return TransactionModel(
      id: entity.id,
      accountId: entity.accountId,
      categoryId: entity.categoryId,
      amount: entity.amount,
      type: entity.type,
      date: entity.date,
      description: entity.description,
    );
  }

  static Transaction toEntity(TransactionModel model) {
    return Transaction(
      id: model.id,
      accountId: model.accountId,
      categoryId: model.categoryId,
      amount: model.amount,
      type: model.type,
      date: model.date,
      description: model.description,
    );
  }
}
