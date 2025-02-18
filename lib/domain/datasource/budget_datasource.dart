import 'package:budgetcap/domain/entities/budget.dart';

abstract class BudgetDatasource {
  // Get all budgets for a user
  Future<List<Budget>> getAllBudgets(String userId);

  // Record a new budget
  Future<String> recordBudget(Budget budget);

  // Get budgets by user ID
  Future<List<Budget>> getBudgetsByUser(String userId);

  // Update an existing budget
  Future<bool> updateBudget(Budget updatedBudget);

  // Delete a budget by ID
  Future<bool> deleteBudget(String budgetId);
}
