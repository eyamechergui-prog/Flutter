
import 'package:flutter/material.dart';

// Écran de connexion
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// Classe privée qui gère l'état de connexion
class _LoginScreenState extends State<LoginScreen> {

  // Contrôleurs des champs
  final TextEditingController _emailController =
      TextEditingController();

  final TextEditingController _passwordController =
      TextEditingController();

  // Variables d'état
  bool _isLoading = false;
  bool _obscurePassword = true;

  // Vérification du formulaire
  void _handleLogin() {
    String email = _emailController.text.trim();
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showErrorDialog('Veuillez remplir tous les champs');
      return;
    }

    if (!email.contains('@')) {
      _showErrorDialog('Veuillez entrer un email valide');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulation d'une connexion de 2 secondes
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      _showSuccessDialog();
    });
  }

  // Affichage d'un message d'erreur
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Erreur'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.of(dialogContext).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Affichage du message de réussite
  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Succès'),
          content: Text(
            'Connexion réussie ! Bienvenue ${_emailController.text}',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();

                _emailController.clear();
                _passwordController.clear();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Navigation vers la page d'inscription
  void _navigateToSignUp() {
    Navigator.pushNamed(context, '/signup');
  }

  // Construction de l'interface
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              // Icône de connexion
              const Icon(
                Icons.account_circle,
                size: 80,
                color: Colors.blue,
              ),

              const SizedBox(height: 20),

              // Titre
              const Text(
                'Connexion',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),

              const SizedBox(height: 40),

              // Champ Email
              TextField(
                controller: _emailController,

                keyboardType: TextInputType.emailAddress,

                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'entrez@votre.email',

                  prefixIcon: Icon(Icons.email),

                  border: OutlineInputBorder(),

                  filled: true,
                  fillColor: Colors.white,
                ),
              ),

              const SizedBox(height: 20),

              // Champ Mot de passe
              TextField(
                controller: _passwordController,

                obscureText: _obscurePassword,

                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  hintText: 'Entrez votre mot de passe',

                  prefixIcon: const Icon(Icons.lock),

                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),

                    onPressed: () {
                      setState(() {
                        _obscurePassword =
                            !_obscurePassword;
                      });
                    },
                  ),

                  border: const OutlineInputBorder(),

                  filled: true,
                  fillColor: Colors.white,
                ),
              ),

              const SizedBox(height: 30),

              // Bouton de connexion ou chargement
              _isLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      width: double.infinity,

                      child: ElevatedButton(
                        onPressed: _handleLogin,

                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 15,
                          ),

                          child: Text(
                            'Se connecter',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),

              const SizedBox(height: 20),

              // Séparateur
              const Row(
                children: [
                  Expanded(child: Divider()),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Text('Ou'),
                  ),

                  Expanded(child: Divider()),
                ],
              ),

              const SizedBox(height: 20),

              // Bouton de création de compte
              SizedBox(
                width: double.infinity,

                child: OutlinedButton(
                  onPressed: _navigateToSignUp,

                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 15,
                    ),

                    child: Text(
                      'Créer un compte',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Libération des contrôleurs
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
