import 'package:budgetcap/domain/datasource/transaction_datasource.dart';
import 'package:budgetcap/domain/entities/transaction.dart';
import 'package:budgetcap/domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl extends TransactionRepository {
  final TransactionDatasource _transactionDatasource;

  TransactionRepositoryImpl(
      {required TransactionDatasource transactionDatasource})
      : _transactionDatasource = transactionDatasource;

  @override
  Future<bool> deleteTransaction(String transactionId) async {
    return await _transactionDatasource.deleteTransaction(transactionId);
  }

  @override
  Future<List<Transaction>> getAllTransactions() async {
    return await _transactionDatasource.getAllTransactions();
  }

  @override
  Future<List<Transaction>> getTransactionsByAccount(String accountId) async {
    return await _transactionDatasource.getTransactionsByAccount(accountId);
  }

  @override
  Future<List<Transaction>> getTransactionsByCategory(String categoryId) async {
    return await _transactionDatasource.getTransactionsByCategory(categoryId);
  }

  @override
  Future<List<Transaction>> getTransactionsById(String userId) async {
    return await _transactionDatasource.getTransactionsById(userId);
  }

  @override
  Future<String> recordTransaction(Transaction transaction) async {
    return await _transactionDatasource.recordTransaction(transaction);
  }

  @override
  Future<bool> updateTransaction(Transaction updatedTransaction) async {
    return await _transactionDatasource.updateTransaction(updatedTransaction);
  }
}
