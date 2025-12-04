import 'package:dishcovery/db/allergen_database.dart';
import 'package:dishcovery/screens/barcode_scanner_page.dart';
import 'package:dishcovery/screens/edit_allergens_page.dart';
import 'package:flutter/material.dart';

import 'profile_view.dart';
import 'password_view.dart';
import 'package:dishcovery/services/firebase_auth_service.dart';

class SettingsView extends StatelessWidget {
  final AllergenDatabase db;
  const SettingsView({super.key, required this.db});

  Future<void> _signOut(BuildContext context) async {
    final auth = FirebaseAuthService();
    await auth.signOut();

    // Clear navigation stack and go back to login screen
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/login',
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final options = <Widget>[
      ListTile(
        leading: const Icon(Icons.person),
        title: const Text('Profile'),
        subtitle: const Text('View your account details'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ProfileView(),
            ),
          );
        },
      ),
      ListTile(
        leading: const Icon(Icons.lock),
        title: const Text('Change Password'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const PasswordView(),
            ),
          );
        },
      ),
      ListTile(
        leading: const Icon(Icons.food_bank),
        title: const Text('Manage Allergens'),
        subtitle: const Text('Update your allergen preferences'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => EditAllergensPage(db: db),
            ),
          );
        },
      ),
      // ListTile(
      //   leading: const Icon(Icons.qr_code_scanner),
      //   title: const Text('Scan a Barcode'),
      //   subtitle: const Text('Check if an item is safe for you'),
      //   onTap: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (_) => BarcodeScannerPage(db: db),
      //       ),
      //     );
      //   },
      // ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.logout, color: Colors.red),
        title: const Text(
          'Sign Out',
          style: TextStyle(color: Colors.red),
        ),
        onTap: () => _signOut(context),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: LayoutBuilder(
        builder: (context, constraints) {
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
