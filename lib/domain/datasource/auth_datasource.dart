abstract class AuthDatasource {
  // Register a new user with email and password
  Future<String> registerUser(String email, String password);

  // Log in a user with email and password
  Future<String> loginUser(String email, String password);

  // Log out the currently authenticated user
  Future<bool> logoutUser();

  // Send a password reset email to the user
  Future<bool> sendPasswordResetEmail(String email);

  // Check if the current session is valid (e.g., verify token)
  Future<bool> isAuthenticated();
}
