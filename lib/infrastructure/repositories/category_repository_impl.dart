import 'package:budgetcap/domain/datasource/category_datasource.dart';
import 'package:budgetcap/domain/entities/category.dart';
import 'package:budgetcap/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final CategoryDatasource _categoryDatasource;

  CategoryRepositoryImpl({required CategoryDatasource categoryDatasource})
      : _categoryDatasource = categoryDatasource;

  @override
  Future<List<Category>> getAllCategories() async {
    return await _categoryDatasource.getAllCategories();
  }
}
