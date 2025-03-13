import 'package:budgetcap/domain/datasource/transaction_datasource.dart';
import 'package:budgetcap/domain/entities/transaction.dart';
import 'package:budgetcap/infrastructure/mappers/transaction_mapper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TransactionDatasourceImpl extends TransactionDatasource {
  final SupabaseClient _supabase;

  TransactionDatasourceImpl({required SupabaseClient supabase})
      : _supabase = supabase;

  @override
  Future<bool> deleteTransaction(String transactionId) async {
    // TODO: implement deleteTransaction
    throw UnimplementedError();
  }

  @override
  Future<List<Transaction>> getAllTransactions() async {
    // TODO: implement getAllTransactions
    throw UnimplementedError();
  }

  @override
  Future<List<Transaction>> getTransactionsByAccount(String accountId) async {
    // TODO: implement getTransactionsByAccount
    throw UnimplementedError();
  }

  @override
  Future<List<Transaction>> getTransactionsByCategory(String categoryId) async {
    // TODO: implement getTransactionsByCategory
    throw UnimplementedError();
  }

  @override
  Future<List<Transaction>> getTransactionsById(String userId) async {
    // TODO: implement getTransactionsById
    throw UnimplementedError();
  }

  @override
  Future<String> recordTransaction(Transaction transaction) async {
    try {
      final transactionSupabase =
          TransactionMapper.toModel(transaction).toMap();
      final data = await _supabase
          .from('transactions')
          .upsert(transactionSupabase)
          .select();
      print(data);
      return data.first['id'].toString();
    } catch (e) {
      print(e);
      return '';
    }
  }

  @override
  Future<bool> updateTransaction(Transaction updatedTransaction) async {
    // TODO: implement updateTransaction
    throw UnimplementedError();
  }
}
