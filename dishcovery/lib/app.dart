import 'package:dishcovery/screens/auth/login_view.dart';
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
        return MaterialPageRoute(builder: (_) => const LoginView());
      case '/about':
        return MaterialPageRoute(builder: (_) => const AboutUsView());

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
