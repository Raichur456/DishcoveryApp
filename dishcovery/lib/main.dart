import 'package:flutter/material.dart';
import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
