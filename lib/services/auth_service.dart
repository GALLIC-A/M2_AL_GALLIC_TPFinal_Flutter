import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:login_app/config.dart';

class AuthService {
  final String apiUrl = LoginAppConfig().apiUrl; // Assurez-vous que c'est le bon port

  Future<Map<String, dynamic>> login(String email, String password) async {
    int fails = 0;
    final int maxRetries = 3;

    while (fails < maxRetries) {
      try {
        String hashedPassword = hashPassword(password);
        final Map<String, String> body = {
          'email': email,
          'password': hashedPassword,
        };

        final response = await http
            .post(
          Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode(body),
        )
            .timeout(
          Duration(seconds: 10),
          onTimeout: () {
            return http.Response(
              json.encode({
                'status': 0,
                'message': 'La requête a expiré. Veuillez réessayer.',
              }),
              408,
            );
          },
        );

        final Map<String, dynamic> data = json.decode(response.body);

        if (response.statusCode == 200 && data['status'] == 200) {
          return {
            'success': true,
            'firstName': data['firstName'],
            'lastName': data['lastName'],
            'role': data['role'],
            'email': data['email'],
          };
        } else {
          return {
            'success': false,
            'status': data['status'],
            'message': data['message'] ?? 'Erreur inconnue',
          };
        }
      } catch (e) {
        fails++;
        if (fails >= maxRetries) {
          return {
            'success': false,
            'status': 0,
            'message': 'Échec après $maxRetries tentatives. Erreur: $e',
          };
        } else {
          await Future.delayed(Duration(seconds: 2));
        }
      }
    }

    return {
      'success': false,
      'status': 0,
      'message': 'Échec de la requête après plusieurs tentatives',
    };
  }

  static String hashPassword(String password) {
    final saltedPassword = 'secretSalt${password}';
    final bytes = utf8.encode(saltedPassword);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
