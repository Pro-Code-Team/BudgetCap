import 'package:budgetcap/domain/entities/account.dart';
import 'package:budgetcap/infrastructure/models/account_model.dart';

class AccountMapper {
  static AccountModel toModel(Account entity) {
    return AccountModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
    );
  }

  static Account toEntity(AccountModel model) {
    return Account(
      id: model.id,
      name: model.name,
      description: model.description,
    );
  }
}
