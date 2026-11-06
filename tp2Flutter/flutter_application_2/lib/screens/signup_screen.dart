
import 'package:flutter/material.dart';

/// Écran d'inscription.
/// StatefulWidget permet de gérer les changements d'état.
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

/// Classe privée qui gère l'interface et la logique d'inscription.
class _SignUpScreenState extends State<SignUpScreen> {

  // Contrôleurs des cinq champs du formulaire.
  final TextEditingController _firstNameController =
      TextEditingController();

  final TextEditingController _lastNameController =
      TextEditingController();

  final TextEditingController _emailController =
      TextEditingController();

  final TextEditingController _passwordController =
      TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // État du chargement.
  bool _isLoading = false;

  // Gestion de la visibilité des mots de passe.
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  /// Vérifie les informations saisies dans le formulaire.
  void _handleSignUp() {
    String firstName = _firstNameController.text.trim();
    String lastName = _lastNameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    // Vérifier que tous les champs sont remplis.
    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showErrorDialog('Veuillez remplir tous les champs');
      return;
    }

    // Vérification simple de l'adresse email.
    if (!email.contains('@')) {
      _showErrorDialog('Veuillez entrer un email valide');
      return;
    }

    // Vérifier la longueur du mot de passe.
    if (password.length < 6) {
      _showErrorDialog(
        'Le mot de passe doit contenir au moins 6 caractères',
      );
      return;
    }

    // Vérifier la confirmation du mot de passe.
    if (password != confirmPassword) {
      _showErrorDialog(
        'Les mots de passe ne correspondent pas',
      );
      return;
    }

    // Activer l'indicateur de chargement.
    setState(() {
      _isLoading = true;
    });

    // Simuler une inscription pendant deux secondes.
    Future.delayed(const Duration(seconds: 2), () {
      // Vérifier que le widget est toujours présent.
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      _showSuccessDialog();
    });
  }

  /// Afficher une boîte de dialogue en cas d'erreur.
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text("Erreur d'inscription"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  /// Afficher une confirmation après la simulation.
  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Inscription réussie !'),
          content: Text(
            'Bienvenue ${_firstNameController.text} ! '
            'Votre inscription a été simulée avec succès.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _navigateToLogin();
              },
              child: const Text('Se connecter'),
            ),
          ],
        );
      },
    );
  }

  /// Retourner à la page de connexion.
  void _navigateToLogin() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  /// Construire l'interface du formulaire.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      // Barre supérieure.
      appBar: AppBar(
        title: const Text('Créer un compte'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),

          // Les champs sont placés verticalement.
          child: Column(
            children: [
              const SizedBox(height: 20),

              const Icon(
                Icons.person_add,
                size: 60,
                color: Colors.blue,
              ),

              const SizedBox(height: 20),

              const Text(
                'Inscription',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),

              const SizedBox(height: 30),

              // Champ prénom.
              TextField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  labelText: 'Prénom',
                  hintText: 'Votre prénom',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),

              const SizedBox(height: 15),

              // Champ nom.
              TextField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Nom',
                  hintText: 'Votre nom',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),

              const SizedBox(height: 15),

              // Champ email.
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'votre@email.com',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),

              const SizedBox(height: 15),

              // Champ mot de passe.
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  hintText: 'Au moins 6 caractères',
                  prefixIcon: const Icon(Icons.lock),

                  // Bouton pour masquer ou afficher.
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),

                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),

              const SizedBox(height: 15),

              // Champ confirmation du mot de passe.
              TextField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                decoration: InputDecoration(
                  labelText: 'Confirmer le mot de passe',
                  hintText: 'Retapez votre mot de passe',
                  prefixIcon: const Icon(Icons.lock_outline),

                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword =
                            !_obscureConfirmPassword;
                      });
                    },
                  ),

                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),

              const SizedBox(height: 30),

              // Afficher le chargement ou le bouton d'inscription.
              _isLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _handleSignUp,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 15,
                          ),
                          child: Text(
                            "S'inscrire",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),

              const SizedBox(height: 20),

              // Retour vers l'écran de connexion.
              TextButton(
                onPressed: _navigateToLogin,
                child: const Text(
                  'Déjà un compte ? Se connecter',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Libérer les contrôleurs lorsque l'écran est détruit.
  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }
}
