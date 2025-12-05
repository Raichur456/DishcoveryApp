import 'screens/barcode/barcode_scanner_page.dart';
import 'screens/favorites/favorites_view.dart';
import 'db/allergen_database.dart';
import 'screens/settings/edit_allergens_page.dart';
import 'package:flutter/material.dart';

// landing screens
import 'screens/landing/landing_view.dart';
import 'screens/landing/about_view.dart';

// home view
import 'screens/home/home_view.dart';

// auth screens
import 'screens/auth/login_view.dart';
import 'screens/auth/signup_view.dart';

// restaurant view
import 'screens/home/restaurant_view.dart';
import 'screens/settings/settings_view.dart';

AllergenDatabase db = AllergenDatabase();

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
      case '/signup':
        return MaterialPageRoute(builder: (_) => const SignupView());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeView(db: db));
      case '/favorites':
        return MaterialPageRoute(builder: (_) => FavoritesView());
      case '/restaurants':
        return MaterialPageRoute(builder: (_) => const RestaurantView());

      case '/settings':
        return MaterialPageRoute(builder: (_) => SettingsView(db: db));

      case '/allergens':
        return MaterialPageRoute(builder: (_) => EditAllergensPage(db: db));

      case '/scan':
        return MaterialPageRoute(builder: (_) => BarcodeScannerPage(db: db));

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
