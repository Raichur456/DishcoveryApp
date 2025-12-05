import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app.dart'; // your App.generateRoute
import 'db/allergen_database.dart'; // AllergenDatabase

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final db = AllergenDatabase();

  runApp(MyApp(db: db));
}

class MyApp extends StatelessWidget {
  final AllergenDatabase db;
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
