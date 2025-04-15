import 'package:budgetcap/domain/datasource/account_datasource.dart';
import 'package:budgetcap/domain/entities/account.dart';
import 'package:budgetcap/domain/repositories/account_repository.dart';

class AccountRepositoryImpl extends AccountRepository {
  final AccountDatasource _datasource;

  AccountRepositoryImpl({required AccountDatasource datasource})
      : _datasource = datasource;

  @override
  Future<List<Account>> getAllAccounts() async {
    return await _datasource.getAllAccounts();
  }

  @override
  Future<int> addAccount(Account account) async {
    return await _datasource.addAccount(account);
  }
}
