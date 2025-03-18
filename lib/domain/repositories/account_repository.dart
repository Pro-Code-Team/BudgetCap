import 'package:budgetcap/domain/entities/account.dart';

abstract class AccountRepository {
  Future<List<Account>> getAllAccounts();
}
