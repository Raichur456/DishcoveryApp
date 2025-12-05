import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// The ProfileView class shows user profile details fetched from FirebaseAuth
class ProfileView extends StatelessWidget {
  // constructs the profile view widget
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    // gets the current user from FirebaseAuth
    final user = FirebaseAuth.instance.currentUser;

    // extracts email and name, fallback if missing
    final String email = user?.email ?? 'Not signed in';
    final String name = user?.displayName ?? 'Name not set';

    // main scaffold for profile screen
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'User Profile',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // display name
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Name'),
              subtitle: Text(name),
            ),
            // display email
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email'),
              subtitle: Text(email),
            ),
          ],
        ),
      ),
    );
  }
}
