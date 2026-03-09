// lib/core/services/auth_service.dart

class AuthService {
  // Dummy users database
  static final List<Map<String, String>> _users = [
    {'username': 'demo', 'email': 'demo@lingupet.com', 'password': '123456'},
  ];

  // REGISTER
  static String? register(String username, String email, String password) {
    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      return 'All fields are required';
    }
    if (!email.contains('@')) return 'Invalid email format';
    if (password.length < 6) return 'Password min 6 characters';
    final exists = _users.any((u) => u['email'] == email);
    if (exists) return 'Email already registered';

    _users.add({'username': username, 'email': email, 'password': password});
    return null; // null = success
  }

  // LOGIN
  static String? login(String email, String password) {
    if (email.isEmpty || password.isEmpty) return 'All fields are required';
    final user = _users.firstWhere(
      (u) => u['email'] == email && u['password'] == password,
      orElse: () => {},
    );
    if (user.isEmpty) return 'Invalid email or password';
    return null; // null = success
  }
}
