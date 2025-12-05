import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app.dart';
import 'db/allergen_database.dart';

// Behavior: The main function initializes Firebase and runs the Dishcovery app
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final db = AllergenDatabase();

  runApp(MyApp(db: db));
}

// The MyApp class is the root widget of the Dishcovery application
class MyApp extends StatelessWidget {
  // database used for allergen persistence
  final AllergenDatabase db;

  // Behavior: constructs the MyApp widget
  const MyApp({super.key, required this.db});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dishcovery',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: App.generateRoute,
      initialRoute: '/',
    );
  }
}
