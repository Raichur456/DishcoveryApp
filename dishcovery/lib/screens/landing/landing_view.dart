import 'package:flutter/material.dart';

class LandingView extends StatelessWidget {
  const LandingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// app title
              const Text(
                'Dishcovery',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              /// welcome message
              const Text(
                'Dishcovery helps you explore and share amazing recipes from around the world!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 40),

              /// login button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/login'),
                  child: const Text('Login'),
                ),
              ),

              const SizedBox(height: 12),

              /// signup button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/signup'),
                  child: const Text('Sign Up'),
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/allergens'),
                  child: const Text('Edit Allergens'),
                ),
              ),

              const SizedBox(height: 24),

              // temporary debug button to quickly open HomeView during development
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/home'),
                  child: const Text('Open Home View (temporary)'),
                ),
              ),

              const SizedBox(height: 24),

              /// about us button
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/about'),
                child: const Text('About Us'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
