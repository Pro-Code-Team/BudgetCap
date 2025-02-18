import 'package:budgetcap/domain/entities/user.dart';

abstract class UserDatasource {
  // Get a user by their ID
  Future<User?> getUserById(String userId);

  // Get a user by their email (useful for login/authentication)
  Future<User?> getUserByEmail(String email);

  // Create a new user account
  Future<String> createUser(User user);

  // Update an existing user's details
  Future<bool> updateUser(User updatedUser);

  // Delete a user account by ID
  Future<bool> deleteUser(String userId);

  // Authenticate a user by email and password hash
  Future<bool> authenticateUser(String email, String passwordHash);

  // Update a user's password hash
  Future<bool> updatePassword(String userId, String newPasswordHash);

  // Update a user's currency preference
  Future<bool> updateCurrencyPreference(
      String userId, String newCurrencyPreference);
}
