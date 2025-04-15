import 'package:budgetcap/domain/entities/account.dart';

abstract class AccountDatasource {
  Future<List<Account>> getAllAccounts();
  Future<int> addAccount(Account account);
}
