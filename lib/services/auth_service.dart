import 'dart:async';
import 'dart:convert';

class AuthService {
  // Simuler un stockage local d'utilisateurs (peut être remplacé par une API)
  final Map<String, Map<String, dynamic>> _users = {
    'user@example.com': {
      'password': 'userpass',
      'firstName': 'Jane',
      'lastName': 'Doe',
      'role': 'User',
    },
    'admin@example.com': {
      'password': 'adminpass',
      'firstName': 'Admin',
      'lastName': 'User',
      'role': 'Admin',
    },
  };

  Future<Map<String, dynamic>?> login(String email, String password) async {

    // Simuler un délai réseau
    await Future.delayed(const Duration(milliseconds: 500));

    if(_users.containsKey(email) && _users[email]!['password'] == password) {
      return _users[email];
    }

    return null;
  }
}
