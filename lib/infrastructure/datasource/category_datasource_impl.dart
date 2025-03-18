import 'package:budgetcap/domain/datasource/category_datasource.dart';
import 'package:budgetcap/domain/entities/category.dart';
import 'package:budgetcap/infrastructure/mappers/category_mapper.dart';
import 'package:budgetcap/infrastructure/models/category_model.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class CategoryDatasourceImpl extends CategoryDatasource {
  final SupabaseClient _supabase;
  static const String _tableName = 'categories';

  CategoryDatasourceImpl({required SupabaseClient supabase})
      : _supabase = supabase;

  @override
  Future<List<Category>> getAllCategories() async {
    List<Category> response = [];
    try {
      final List<Map<String, dynamic>> categories =
          await _supabase.from(_tableName).select();

      response = categories
          .map((categoryDB) =>
              CategoryMapper.toEntity(CategoryModel.fromMap(categoryDB)))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }
}
