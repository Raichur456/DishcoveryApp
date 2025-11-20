import 'package:flutter/material.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About Dishcovery')),
      body: const Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Our Mission',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 12),

            Text(
              'Dishcovery helps users with food allergies and dietary restrictions find safe '
              'meals, scan items, understand ingredients, and explore dishes that fit their needs. '
              'We aim to simplify eating—whether you\'re grocery shopping, dining out, or meal planning.',
              style: TextStyle(fontSize: 16, height: 1.4),
            ),

            SizedBox(height: 32),

            Text(
              'Why We Built This',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 12),

            Text(
              'Millions of people struggle with navigating food allergies daily. Whether it’s reading '
              'confusing ingredient labels, avoiding certain restaurants, or trying new foods safely, it '
              'can be overwhelming.\n\n'
              'Dishcovery was designed to give users confidence—helping them find dishes, products, '
              'and restaurants that align with their dietary needs.',
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
