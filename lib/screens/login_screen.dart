import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_app/screens/profile_screen.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.title});
  final String title;
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Map<String, Map<String, dynamic>> _users = {
    'user@example.com': {
      'password': 'userpass',
      'firstName': 'Jane',
      'lastName': 'Doe',
      'role': 'User'
    },
    'admin@example.com': {
      'password': 'adminpass',
      'firstName': 'Admin',
      'lastName': 'User',
      'role': 'Admin'
    }
  };

  final _formKey = GlobalKey<FormState>(); // Clé pour le formulaire
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Assignation de la clé au formulaire
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
// Champ Email
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.mail),
                ),
//keyboardType: TextInputType.visiblePassword,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
// Validation de l'email
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre email';
                  }
// Regex simple pour valider l'email
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Veuillez entrer un email valide';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
// Champ Mot de Passe
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Mot de passe',
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.lock),
                ),
                obscureText: true, // Masquer le texte
                validator: (value) {
// Validation du mot de passe
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre mot de passe';
                  }
                  if (value.length < 6) {
                    return 'Le mot de passe doit contenir au moins 6 caractères';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24.0),
// Bouton de Connexion
              ElevatedButton(
                onPressed: _login,
                child: const Text('Se connecter'),
              ),
              ElevatedButton(
                  onPressed: _resetForm,
                  child: const Text('Effacer le formulaire')
              )
            ],
          ),
        ),
      ),
    );
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;

      var user = await _authService.login(email, password);

      if (user != null) {
// Connexion réussie avec informations supplémentaires
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ProfileScreen(
                  email: email,
                  firstName: _users[email]!['firstName'],
                  lastName: _users[email]!['lastName'],
                  role: _users[email]!['role'],
                ),
          ),
        );
      } else {
// Connexion échouée
        showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                title: Text('Erreur'),
                content: Text('Email ou mot de passe incorrect'),actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
              ),
        );
      }
    }
  }

  void _resetForm() {
    _formKey.currentState!.reset();
  }
}