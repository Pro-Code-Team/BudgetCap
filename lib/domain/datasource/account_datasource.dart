import 'package:budgetcap/domain/entities/account.dart';

abstract class AccountDatasource {
  // Get all accounts for a user
  Future<List<Account>> getAllAccounts(String userId);

  // Record a new account
  Future<String> recordAccount(Account account);

  // Get accounts by user ID
  Future<List<Account>> getAccountsByUser(String userId);

  // Update an existing account
  Future<bool> updateAccount(Account updatedAccount);

  // Delete an account by ID
  Future<bool> deleteAccount(String accountId);
}
