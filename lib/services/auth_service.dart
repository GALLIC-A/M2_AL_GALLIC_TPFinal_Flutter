import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class AuthService {
  // Simuler un stockage local d'utilisateurs (peut être remplacé par une API)
  final Map<String, Map<String, dynamic>> _users = {
    'user@example.com': {
      'password': hashPassword('userpass'),
      'firstName': 'Jane',
      'lastName': 'Doe',
      'role': 'User',
    },
    'admin@example.com': {
      'password': hashPassword('adminpass'),
      'firstName': 'Admin',
      'lastName': 'User',
      'role': 'Admin',
    },
  };

  Future<Map<String, dynamic>?> login(String email, String password) async {

    // Simuler un délai réseau
    await Future.delayed(const Duration(milliseconds: 500));

    if(_users.containsKey(email)) {
      String hashedPassword = hashPassword(password);
      if(_users[email]!['password'] == hashedPassword) {
        return _users[email];
      }
    }

    return null;
  }

  static String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
