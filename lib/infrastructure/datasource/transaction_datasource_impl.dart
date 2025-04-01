import 'package:budgetcap/domain/datasource/transaction_datasource.dart';
import 'package:budgetcap/domain/entities/transaction.dart';
import 'package:budgetcap/infrastructure/mappers/transaction_mapper.dart';
import 'package:budgetcap/infrastructure/models/transaction_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TransactionDatasourceImpl extends TransactionDatasource {
  final SupabaseClient _supabase;
  static const String _tableName = 'transactions';

  TransactionDatasourceImpl({required SupabaseClient supabase})
      : _supabase = supabase;

  @override
  Future<bool> deleteTransaction(int transactionId) async {
    try {
      await _supabase.from(_tableName).delete().eq('id', transactionId);
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Transaction>> getAllTransactions() async {
    try {
      final transactions = await _supabase.from(_tableName).select("*");
      return transactions
          .map(
            (Map<String, dynamic> transaction) => TransactionMapper.toEntity(
              TransactionModel.fromMap(transaction),
            ),
          )
          .toList();
    } catch (e) {
      throw Exception(e);
    }
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
  Future<int> recordTransaction(Transaction transaction) async {
    try {
      final transactionSupabase =
          TransactionMapper.toModel(transaction).toMap();
      final response =
          await _supabase.from(_tableName).insert(transactionSupabase).select();
      return response.first['id'];
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> updateTransaction(Transaction updatedTransaction) async {
    try {
      final transactionSupabase =
          TransactionMapper.toModel(updatedTransaction).toMap();

      await _supabase
          .from(_tableName)
          .update(transactionSupabase)
          .eq('id', transactionSupabase['id']);
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }
}
