import 'package:dishcovery/db/allergen_database.dart';
import 'package:dishcovery/screens/settings/edit_allergens_page.dart';
import 'package:flutter/material.dart';

import 'profile_view.dart';
import 'password_view.dart';
import 'package:dishcovery/services/firebase_auth_service.dart';

// The SettingsView class provides a user interface for managing application settings
class SettingsView extends StatelessWidget {
  // The database used for user allergen persistence
  final AllergenDatabase db;

  // constructs the settings view widget
  const SettingsView({super.key, required this.db});

  // signs out the user and navigates to the landing page
  Future<void> _signOut(BuildContext context) async {
    final auth = FirebaseAuthService();
    await auth.signOut();

    // clears navigation stack and goes back to the landing page
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // list of settings options
    final options = <Widget>[
      // profile option
      ListTile(
        leading: const Icon(Icons.person),
        title: const Text('Profile'),
        subtitle: const Text('View your account details'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProfileView()),
          );
        },
      ),
      // change password option
      ListTile(
        leading: const Icon(Icons.lock),
        title: const Text('Change Password'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const PasswordView()),
          );
        },
      ),
      // manage allergens option
      ListTile(
        leading: const Icon(Icons.food_bank),
        title: const Text('Manage Allergens'),
        subtitle: const Text('Update your allergen preferences'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => EditAllergensPage(db: db)),
          );
        },
      ),
      const Divider(),
      // sign out option
      ListTile(
        leading: const Icon(Icons.logout, color: Colors.red),
        title: const Text('Sign Out', style: TextStyle(color: Colors.red)),
        onTap: () => _signOut(context),
      ),
    ];

    // main scaffold for settings screen
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back to Landing',
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // responsive layout for wide screens
          final list = ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            itemCount: options.length,
            separatorBuilder: (_, __) => const SizedBox(height: 20),
            itemBuilder: (context, i) => options[i],
          );

          if (constraints.maxWidth > 600) {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: list,
              ),
            );
          } else {
            return list;
          }
        },
      ),
    );
  }
}
