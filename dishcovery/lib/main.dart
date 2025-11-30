import 'package:dishcovery/services/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const DishcoveryApp());
}

/// Root of the Dishcovery Application
class DishcoveryApp extends StatelessWidget {
  const DishcoveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dishcovery',
      debugShowCheckedModeBanner: false,

      // route-based navigation
      onGenerateRoute: App.generateRoute,
      initialRoute: '/',
    );
  }
}
