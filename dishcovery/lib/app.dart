import 'package:dishcovery/db/app_database.dart';
import 'package:dishcovery/screens/auth/login_view.dart';
import 'package:dishcovery/screens/edit_allergens_page.dart';
import 'package:flutter/material.dart';

// landing screens
import 'screens/landing/landing_view.dart';
import 'screens/landing/about_view.dart';

/// handles navigation for the application
class App {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // default route
      case '/':
        return MaterialPageRoute(builder: (_) => const LandingView());
      case '/about':
        return MaterialPageRoute(builder: (_) => const AboutUsView());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginView());
      case '/allergens':
        AppDatabase db = AppDatabase();
        return MaterialPageRoute(builder: (_) => EditAllergensPage(db: db));

      // catches unknown routes
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                'Route not found: ${settings.name}',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        );
    }
  }
}
