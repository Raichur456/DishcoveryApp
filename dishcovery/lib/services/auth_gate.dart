import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:dishcovery/db/allergen_database.dart';
import 'package:dishcovery/screens/home_view.dart';
import 'package:dishcovery/screens/auth/login_view.dart';

class AuthGate extends StatelessWidget {
  // Local allergen database
  final AllergenDatabase db; 

  const AuthGate({super.key, required this.db});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      // Listen for login/logout changes
      stream: FirebaseAuth.instance.authStateChanges(), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
             // Show loading while checking auth
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData) {
           // User is logged in → go to home
          return HomeView(db: db);
        }
        // No user → show login screen
        return const LoginView(); 
      },
    );
  }
}
