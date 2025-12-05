import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Auth instance

  User? get currentUser => _auth.currentUser; // Returns logged-in user or null

  // Creates a new user with email and password
  Future<User?> register(String email, String password) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user; // Returns created user
  }

  // Signs in an existing user
  Future<User?> signIn(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user; // Returns signed-in user
  }

  // Logs the user out
  Future<void> signOut() async {
    await _auth.signOut(); // Clears Firebase session
  }
}
