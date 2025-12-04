import 'package:dishcovery/db/allergen_database.dart';
import 'package:dishcovery/screens/barcode_scanner_page.dart';
import 'package:dishcovery/screens/edit_allergens_page.dart';
import 'package:flutter/material.dart';
import 'profile_view.dart';
import 'password_view.dart';

class SettingsView extends StatelessWidget {
  final AllergenDatabase db;
  const SettingsView({super.key, required this.db});

  @override
  Widget build(BuildContext context) {
    final options = [
      ListTile(
        leading: const Icon(Icons.person),
        title: const Text('Profile'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProfileView()),
          );
        },
      ),
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
      ListTile(
        leading: const Icon(Icons.food_bank),
        title: const Text('Edit Allergens'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => EditAllergensPage(db: db)),
          );
        },
      ),
      ListTile(
        leading: const Icon(Icons.qr_code_scanner),
        title: const Text('Scan Product'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => BarcodeScannerPage(db: db)),
          );
        },
      ),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isLandscape = constraints.maxWidth > constraints.maxHeight;
          if (isLandscape) {
            return GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 2.5,
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              children: options,
            );
          } else {
            return ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              itemCount: options.length,
              separatorBuilder: (_, __) => const SizedBox(height: 20),
              itemBuilder: (context, i) => options[i],
            );
          }
        },
      ),
    );
  }
}
