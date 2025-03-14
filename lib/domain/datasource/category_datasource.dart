import 'package:budgetcap/domain/entities/category.dart';

abstract class CategoryDatasource {
  Future<List<Category>> getAllCategories();
}
