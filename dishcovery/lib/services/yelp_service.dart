// lib/services/yelp_service.dart
import 'dart:convert'; // For decoding JSON responses
import 'package:http/http.dart' as http; // For making HTTP requests

import '../models/restaurant.dart'; // Restaurant model
import '../models/dish.dart'; // Dish model

/// Service that fetches live restaurant data from Yelp for Seattle.
class YelpService {
  static const String _baseUrl = 'https://api.yelp.com/v3'; // Yelp API base URL
  static const String _apiKey =
      '6coyp3JN9haEf0uunBnuud8HDvEwMYZpGDQH5JT3YyotYm-KLeach-IvXUszyhgsd2XeLCnpJjHw-WL8jUXIR7yVoAnGVV0E11q2TVTAx_gOE0DS9Y6q6LWmt3oraXYx'; // Your API key

  /// Fetch restaurants in Seattle.
  /// [term] is an optional search keyword (e.g. "thai", "pizza").
  static Future<List<Restaurant>> searchRestaurantsInSeattle({
    String term = '',
  }) async {
    if (_apiKey.isEmpty) {
      throw StateError('Yelp API key is missing.'); // Error if key not set
    }

    final uri = Uri.parse('$_baseUrl/businesses/search').replace(
      queryParameters: {
        'location': 'Seattle, WA', // Restrict searches to Seattle
        'categories': 'restaurants', // Search only restaurants
        'term': term, // Optional user search term
        'limit': '20', // Max results to return
      },
    );

    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $_apiKey', // Required Yelp header
      },
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Yelp request failed: ${response.statusCode} ${response.reasonPhrase}', // Error if API call fails
      );
    }

    // Decode JSON from Yelp response
    final Map<String, dynamic> data = json.decode(response.body);
    final List<dynamic> businesses = data['businesses'] ?? []; // List of restaurants

    return businesses.map<Restaurant>((dynamic b) {
      final m = b as Map<String, dynamic>; // Cast to map

      final location = (m['location'] as Map<String, dynamic>?); // Address info
      final address1 = location?['address1'] as String? ?? ''; // Street address
      final city = location?['city'] as String? ?? 'Seattle'; // Default city

      final categories = (m['categories'] as List<dynamic>? ?? []); // Categories array
      final categoryNames = categories
          .map((c) => (c as Map<String, dynamic>)['title'] as String?)
          .whereType<String>()
          .toList(); // Category titles

      final parts = <String>[]; // Build description parts
      if (address1.isNotEmpty) parts.add(address1);
      if (city.isNotEmpty) parts.add(city);
      if (categoryNames.isNotEmpty) {
        parts.add(categoryNames.join(', ')); // Add category info
      }

      final description =
          parts.isEmpty ? 'Seattle restaurant' : parts.join(' • '); // Final string

      return Restaurant(
        id: m['id'] as String, // Unique Yelp restaurant ID
        name: m['name'] as String, // Restaurant name
        description: description, // Auto-generated description
        imageUrl: (m['image_url'] as String?) ?? '', // Restaurant image
        rating: (m['rating'] as num?)?.toDouble() ?? 0.0, // Yelp rating
        dishes: const <Dish>[], // No dish-level data from Yelp
      );
    }).toList(); // Return list of Restaurant objects
  }
}
