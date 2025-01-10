import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String apiUrl = 'http://localhost'; // Assurez-vous que c'est le bon port

  Future<Map<String, dynamic>?> login(String email, String password) async {
    try {
      String hashedPassword = hashPassword(password);

      final Map<String, String> body = {
        'email': email,
        'password': hashedPassword,
      };

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == 200) {
          return {
            'firstName': data['firstName'],
            'lastName': data['lastName'],
            'role': data['role'],
            'email': data['email'],
          };
        } else {
          return {
            'status': data['status'],
            'message': data['message'],
          };
        }
      } else {
        final Map<String, dynamic> data = json.decode(response.body);
        return {
          'status': data['status'],
          'message': data['message'],
        };
      }
    } catch (e) {
      // On tombe ici en cas de problème non-lié à l'API directement (comme un problème de connexion)
      return {
        'status': 0,
        'message': 'Erreur lors de la requête: $e',
      };
    }
  }

  static String hashPassword(String password) {
    final saltedPassword = 'secretSalt${password}';
    final bytes = utf8.encode(saltedPassword);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
