import 'package:budgetcap/domain/entities/category.dart';

abstract class CategoryDatasource {
  // Get all categories for a user
  Future<List<Category>> getAllCategories(String userId);

  // Record a new category
  Future<String> recordCategory(Category category);

  // Get categories by user ID
  Future<List<Category>> getCategoriesByUser(String userId);

  // Update an existing category
  Future<bool> updateCategory(Category updatedCategory);

  // Delete a category by ID
  Future<bool> deleteCategory(String categoryId);
}
