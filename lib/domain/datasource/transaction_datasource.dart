import 'package:budgetcap/domain/entities/transaction.dart';

abstract class TransactionDatasource {
  Future<List<Transaction>> getAllTransactions();
  Future<String> recordTransaction(Transaction transaction);
  Future<List<Transaction>> getTransactionsById(String userId);
  Future<List<Transaction>> getTransactionsByCategory(String categoryId);
  Future<List<Transaction>> getTransactionsByAccount(String accountId);
  Future<bool> updateTransaction(Transaction updatedTransaction);
  Future<bool> deleteTransaction(int transactionId);
}
