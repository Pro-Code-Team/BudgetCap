import 'package:budgetcap/domain/datasource/account_datasource.dart';
import 'package:budgetcap/domain/entities/account.dart';
import 'package:budgetcap/infrastructure/mappers/account_mapper.dart';
import 'package:budgetcap/infrastructure/models/account_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AccountDatasourceImpl extends AccountDatasource {
  final SupabaseClient _supabase;
  static const String _tableName = 'accounts';

  AccountDatasourceImpl({required SupabaseClient supabase})
      : _supabase = supabase;
  @override
  Future<List<Account>> getAllAccounts() async {
    List<Account> response = [];
    try {
      final List<Map<String, dynamic>> accounts =
          await _supabase.from(_tableName).select();

      response = accounts
          .map((accountDB) =>
              AccountMapper.toEntity(AccountModel.fromMap(accountDB)))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }

  @override
  Future<String> addAccount(Account account) async {
    //
    try {
      final accountSupabase = AccountMapper.toModel(account).toMap();
      final data =
          await _supabase.from(_tableName).upsert(accountSupabase).select();

      return data.first['id'].toString();
    } catch (e) {
      throw Exception(e);
    }
  }
}
