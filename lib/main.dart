import 'package:flutter/material.dart';

/// Point d'entrée principal de l'application Flutter.
///
/// La fonction main() est exécutée au démarrage.
/// runApp() lance l'application en affichant le widget MyApp.
void main() {
  runApp(const MyApp());
}

/// ============================================================
/// 1. CLASSE PRINCIPALE : MyApp
/// ============================================================
///
/// MyApp représente le widget principal de l'application.
///
/// Cette classe hérite de StatelessWidget car elle ne possède
/// pas de données internes qui changent pendant son exécution.
///
/// Elle permet de :
/// - Configurer l'application.
/// - Définir le thème graphique.
/// - Définir l'écran affiché au démarrage.
///
class MyApp extends StatelessWidget {
  /// Constructeur de la classe MyApp.
  const MyApp({super.key});

  /// Construit l'interface principale de l'application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      // Supprime la bannière DEBUG en haut de l'application.
      debugShowCheckedModeBanner: false,

      // Définit le titre de l'application.
      title: 'Application de connexion',

      // Définit le thème graphique global.
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      // Définit l'écran de connexion comme écran d'accueil.
      home: const LoginScreen(),
    );
  }
}

/// ============================================================
/// 2. CLASSE : LoginScreen
/// ============================================================
///
/// LoginScreen représente l'écran de connexion.
///
/// Cette classe hérite de StatefulWidget car son interface
/// doit être mise à jour selon les actions de l'utilisateur.
///
/// Par exemple :
/// - Afficher un message d'erreur.
/// - Afficher un message de réussite.
/// - Changer la couleur du message.
///
class LoginScreen extends StatefulWidget {
  /// Constructeur de l'écran de connexion.
  const LoginScreen({super.key});

  /// Crée l'objet State qui gère les données et l'interface
  /// de l'écran de connexion.
  @override
  State<LoginScreen> createState() => _LoginScreenState();///listener
}

/// ============================================================
/// 3. CLASSE : _LoginScreenState
/// ============================================================
///
/// Cette classe contient la logique de l'authentification
/// et la construction de l'interface utilisateur.
///
/// Le caractère _ indique que la classe est privée
/// à la bibliothèque Dart dans laquelle elle est déclarée.
///
class _LoginScreenState extends State<LoginScreen> {

  /// Contrôleur permettant de récupérer le nom d'utilisateur
  /// saisi dans le premier champ TextField.
  final TextEditingController _usernameController =
      TextEditingController();

  /// Contrôleur permettant de récupérer le mot de passe
  /// saisi dans le deuxième champ TextField.
  final TextEditingController _passwordController =
      TextEditingController();

  /// Variable qui contient le message à afficher.
  ///
  /// Elle est initialement vide pour ne rien afficher
  /// avant que l'utilisateur clique sur Se connecter.
  String _message = '';

  /// Indique si l'authentification est réussie.
  ///
  /// true  : connexion réussie (message vert).
  /// false : connexion échouée (message rouge).
  bool _isSuccess = false;

  /// Identifiants utilisés pour tester l'application.
  ///
  /// Ces valeurs sont définies directement dans le code.
  /// Elles ne sont pas adaptées à une application réelle
  /// car elles ne sont pas protégées par un serveur.
  final String correctUsername = 'aya';
  final String correctPassword = '1234';

  /// ==========================================================
  /// 4. MÉTHODE : _handleLogin()
  /// ==========================================================
  ///
  /// Cette méthode vérifie les informations saisies.
  ///
  /// Étapes :
  /// 1. Récupérer le nom d'utilisateur et le mot de passe.
  /// 2. Vérifier que les champs ne sont pas vides.
  /// 3. Comparer les valeurs avec les identifiants de test.
  /// 4. Afficher un message selon le résultat.
  ///
  /// La méthode setState() permet de reconstruire l'interface
  /// lorsqu'une variable d'état est modifiée.
  ///
  void _handleLogin() {

    // Récupère le nom d'utilisateur.
    // trim() supprime les espaces au début et à la fin.
    String username = _usernameController.text.trim();

    // Récupère le mot de passe tel qu'il a été saisi.
    String password = _passwordController.text;

    // Vérifie si au moins un champ est vide.
    if (username.isEmpty || password.isEmpty) {

      // Actualise l'interface pour afficher une erreur.
      setState(() {
        _message = 'Veuillez remplir tous les champs.';
        _isSuccess = false;
      });

      // Arrête l'exécution de la méthode.
      return;
    }

    // Vérifie si les deux identifiants sont corrects.
    if (username == correctUsername &&
        password == correctPassword) {

      // Cas : authentification réussie.
      setState(() {
        _message = 'Vous êtes bien authentifié !';
        _isSuccess = true;
      });

    } else {

      // Cas : identifiants incorrects.
      setState(() {
        _message = 'Identifiants incorrects. Veuillez réessayer.';
        _isSuccess = false;
      });
    }
  }

  /// ==========================================================
  /// 5. CONSTRUCTION DE L'INTERFACE UTILISATEUR
  /// ==========================================================
  ///
  /// build() retourne l'interface de l'écran de connexion.
  ///
  /// L'interface contient :
  /// - Une barre supérieure AppBar.
  /// - Une icône de connexion.
  /// - Un titre de bienvenue.
  /// - Un champ pour le nom d'utilisateur.
  /// - Un champ pour le mot de passe.
  /// - Un bouton de connexion.
  /// - Un message indiquant le résultat.
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // Définit la couleur d'arrière-plan de l'écran.
      backgroundColor: Colors.grey[100],

      // Barre d'application affichée en haut.
      appBar: AppBar(
        title: const Text('Authentification'),

        // Centre le titre dans la barre.
        centerTitle: true,
      ),

      // Contenu principal de l'écran.
      body: Center(

        // Permet le défilement vertical lorsque
        // l'espace disponible est insuffisant.
        ///permet de se déplacer vers le haut ou vers le bas 
        child: SingleChildScrollView(

          // Ajoute une marge intérieure de 24 pixels.
          padding: const EdgeInsets.all(24),

          // Organise les widgets verticalement.
          child: Column(

            // Centre les éléments sur l'axe vertical
            // dans l'espace disponible à la colonne.
            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              // ------------------------------------------------
              // ICÔNE DE CONNEXION
              // ------------------------------------------------
              const Icon(
                Icons.lock_person,
                size: 80,
                color: Colors.blue,
              ),

              // Ajoute un espace vertical de 20 pixels.
              const SizedBox(height: 20),

              // ------------------------------------------------
              // TITRE DE BIENVENUE
              // ------------------------------------------------
              const Text(
                'Bienvenue !',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              // ------------------------------------------------
              // CHAMP : NOM D'UTILISATEUR
              // ------------------------------------------------
              TextField(

                // Associe le champ à son contrôleur.
                controller: _usernameController,

                // Définit l'apparence du champ.
                decoration: const InputDecoration(

                  // Texte affiché comme étiquette.
                  labelText: "Nom d'utilisateur",

                  // Texte indicatif lorsque le champ est vide.
                  hintText: 'Entrez votre nom',

                  // Ajoute une icône utilisateur.
                  prefixIcon: Icon(Icons.person),

                  // Ajoute une bordure rectangulaire.
                  border: OutlineInputBorder(),

                  // Active la couleur de fond.
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),

              const SizedBox(height: 20),

              // ------------------------------------------------
              // CHAMP : MOT DE PASSE
              // ------------------------------------------------
              TextField(

                // Associe le champ au contrôleur du mot de passe.
                controller: _passwordController,

                // Masque les caractères du mot de passe.
                obscureText: true,

                decoration: const InputDecoration(
                  labelText: 'Mot de passe',
                  hintText: 'Entrez votre mot de passe',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),

              const SizedBox(height: 25),

              // ------------------------------------------------
              // BOUTON : SE CONNECTER
              // ------------------------------------------------
              ElevatedButton(

                // Exécute _handleLogin() lors du clic.
                onPressed: _handleLogin,

                // Définit les dimensions minimales du bouton.
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),

                // Texte affiché à l'intérieur du bouton.
                child: const Text(
                  'Se connecter',
                  style: TextStyle(fontSize: 18),
                ),
              ),

              const SizedBox(height: 20),

              // ------------------------------------------------
              // MESSAGE DE RÉSULTAT
              // ------------------------------------------------

              // Affiche le message uniquement s'il n'est pas vide.
              if (_message.isNotEmpty)
                Text(
                  _message,

                  // Centre le texte horizontalement.
                  textAlign: TextAlign.center,

                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,

                    // Vert si l'authentification est réussie.
                    // Rouge si l'authentification a échoué.
                    color: _isSuccess
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// ==========================================================
  /// 6. MÉTHODE : dispose()
  /// ==========================================================
  ///
  /// Cette méthode est appelée lorsque le widget est détruit.
  ///
  /// Elle permet de libérer les ressources utilisées
  /// par les contrôleurs TextEditingController.
  ///
  /// Cette opération évite de conserver inutilement
  /// des ressources en mémoire.
  ///
  @override
  void dispose() {

    // Libère le contrôleur du nom d'utilisateur.
    _usernameController.dispose();

    // Libère le contrôleur du mot de passe.
    _passwordController.dispose();

    // Appelle la méthode dispose() de la classe parente.
    super.dispose();
  }
}
