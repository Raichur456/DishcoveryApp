import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:dishcovery/db/allergen_database.dart';
import 'package:dishcovery/screens/home_view.dart';
import 'package:dishcovery/screens/auth/login_view.dart';

class AuthGate extends StatelessWidget {
  final AllergenDatabase db;

  const AuthGate({super.key, required this.db});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // If we have a user -> go straight to home
        if (snapshot.hasData) {
          return HomeView(db: db);
        }

        // No user -> show login screen
        return const LoginView();
      },
    );
  }
}
