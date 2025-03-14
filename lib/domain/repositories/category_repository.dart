import 'package:budgetcap/domain/entities/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> getAllCategories();
}
