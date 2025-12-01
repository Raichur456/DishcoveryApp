// lib/services/yelp_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/restaurant.dart';
import '../models/dish.dart';

/// Service that fetches live restaurant data from Yelp for Seattle.
class YelpService {
  static const String _baseUrl = 'https://api.yelp.com/v3';
  static const String _apiKey = '6coyp3JN9haEf0uunBnuud8HDvEwMYZpGDQH5JT3YyotYm-KLeach-IvXUszyhgsd2XeLCnpJjHw-WL8jUXIR7yVoAnGVV0E11q2TVTAx_gOE0DS9Y6q6LWmt3oraXYx';

  /// Fetch restaurants in Seattle.
  /// [term] is an optional search keyword (e.g., "thai", "pizza").
  static Future<List<Restaurant>> searchRestaurantsInSeattle({
    String term = '',
  }) async {
    if (_apiKey.isEmpty) {
      throw StateError(
        'Yelp API key is missing. Set _apiKey in YelpService.',
      );
    }

    final uri = Uri.parse('$_baseUrl/businesses/search').replace(
      queryParameters: {
        'location': 'Seattle, WA',
        'categories': 'restaurants',
        'term': term,
        'limit': '20',
      },
    );

    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $_apiKey',
      },
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Yelp request failed: ${response.statusCode} ${response.reasonPhrase}',
      );
    }

    // --- JSON PARSING HERE ---
    final Map<String, dynamic> data = json.decode(response.body);
    final List<dynamic> businesses = data['businesses'] ?? [];

    return businesses.map<Restaurant>((dynamic b) {
      final m = b as Map<String, dynamic>;

      final location = (m['location'] as Map<String, dynamic>?);
      final address1 = location?['address1'] as String? ?? '';
      final city = location?['city'] as String? ?? 'Seattle';

      final categories = (m['categories'] as List<dynamic>? ?? []);
      final categoryNames = categories
          .map((c) => (c as Map<String, dynamic>)['title'] as String?)
          .whereType<String>()
          .toList();

      final parts = <String>[];
      if (address1.isNotEmpty) parts.add(address1);
      if (city.isNotEmpty) parts.add(city);
      if (categoryNames.isNotEmpty) {
        parts.add(categoryNames.join(', '));
      }

      final description =
          parts.isEmpty ? 'Seattle restaurant' : parts.join(' • ');

      return Restaurant(
        id: m['id'] as String,
        name: m['name'] as String,
        description: description,
        imageUrl: (m['image_url'] as String?) ?? '',
        rating: (m['rating'] as num?)?.toDouble() ?? 0.0,
        // Yelp doesn’t give dish-level data, so this stays empty for now.
        dishes: const <Dish>[],
      );
    }).toList();
  }
}
