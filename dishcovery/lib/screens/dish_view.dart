import 'package:flutter/material.dart';
import 'package:dishcovery/db/allergen_database.dart';

import '../models/restaurant.dart';
import '../models/dish.dart';
import '../utils/favorites_manager.dart';

class DishView extends StatefulWidget {
  final Restaurant restaurant;

  const DishView({super.key, required this.restaurant});

  @override
  State<DishView> createState() => _DishViewState();
}

class _DishViewState extends State<DishView> {
  final AllergenDatabase _db = AllergenDatabase();
  late Future<List<String>> _userAllergensFuture;

  @override
  void initState() {
    super.initState();
    _userAllergensFuture = _db.getAllergens();
  }

  @override
  void dispose() {
    _db.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Dish> dishes = widget.restaurant.dishes;
    final bool isFav =
        FavoritesManager.instance.isFavorite(widget.restaurant);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Text(
                widget.restaurant.name,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              icon: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: isFav ? Colors.red : null,
              ),
              onPressed: () {
                setState(() {
                  if (isFav) {
                    FavoritesManager.instance.remove(widget.restaurant);
                  } else {
                    FavoritesManager.instance.add(widget.restaurant);
                  }
                });
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<String>>(
        future: _userAllergensFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final List<String> userAllergens =
              snapshot.data ?? const <String>[];

          // Dish-based suspicion (for your mock-data restaurants)
          final Set<String> dishSuspected =
              _suspectedRestaurantAllergens(dishes, userAllergens);

          // Restaurant text–based suspicion (for Yelp restaurants with no dishes)
          final Set<String> restaurantSuspected =
              _suspectedAllergiesFromRestaurantText(
                  widget.restaurant, userAllergens);

          // Combined suspected allergens
          final Set<String> allSuspected = {
            ...dishSuspected,
            ...restaurantSuspected,
          };

          return Column(
            children: [
              // Allergy banner at top
              if (userAllergens.isNotEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  color: allSuspected.isNotEmpty
                      ? Colors.red[100]
                      : (dishes.isEmpty
                          ? Colors.yellow[100]
                          : Colors.green[100]),
                  child: Text(
                    allSuspected.isNotEmpty
                        ? 'Warning: this restaurant may contain your allergies: ${allSuspected.join(", ")}. Please double-check with the staff.'
                        : (dishes.isEmpty
                            ? 'We don\'t have dish details for this restaurant yet. Because you selected allergies (${userAllergens.join(", ")}), please double-check with the staff before eating.'
                            : 'Based on the dishes we know about, we don\'t see any obvious matches with your saved allergies. Always confirm with the restaurant.'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: allSuspected.isNotEmpty
                          ? Colors.red[900]
                          : (dishes.isEmpty
                              ? Colors.orange[900]
                              : Colors.green[900]),
                    ),
                  ),
                )
              else
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  color: Colors.blueGrey[50],
                  child: const Text(
                    'Set your allergies in the Allergens screen so Dishcovery can flag risky restaurants and dishes for you.',
                    textAlign: TextAlign.center,
                  ),
                ),

              // Dish list
              Expanded(
                child: dishes.isEmpty
                    ? const Center(
                        child: Text(
                          'No dishes listed for this restaurant yet.',
                        ),
                      )
                    : ListView.builder(
                        itemCount: dishes.length,
                        itemBuilder: (context, index) {
                          final Dish dish = dishes[index];
                          final bool dishIsRisky =
                              _dishHasUserAllergen(dish, userAllergens);

                          return Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            color: dishIsRisky ? Colors.red[50] : null,
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  dish.imageUrl,
                                  width: 56,
                                  height: 56,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                      const Icon(Icons.fastfood),
                                ),
                              ),
                              title: Text(dish.name),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '\$${dish.price.toStringAsFixed(2)}',
                                  ),
                                  const SizedBox(height: 4),
                                  if (dish.containsAllergens.isNotEmpty)
                                    Text(
                                      'Contains: ${dish.containsAllergens.join(", ")}',
                                      style: TextStyle(
                                        color: dishIsRisky
                                            ? Colors.red
                                            : Colors.black,
                                      ),
                                    ),
                                  if (dishIsRisky &&
                                      userAllergens.isNotEmpty)
                                    const Text(
                                      '⚠ Matches your saved allergies',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  if (dish.safeForAllergens.isNotEmpty)
                                    Text(
                                      'Safe for: ${dish.safeForAllergens.join(", ")}',
                                      style: const TextStyle(
                                        color: Colors.green,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// Returns true if [dish] appears to contain any of the [userAllergens].
  bool _dishHasUserAllergen(Dish dish, List<String> userAllergens) {
    if (userAllergens.isEmpty) return false;

    final dishLabels = dish.containsAllergens
        .map((a) => a.toLowerCase().trim())
        .toList();

    const Map<String, List<String>> keywordMap = {
      'milk': ['milk', 'dairy', 'cheese', 'cream'],
      'egg': ['egg', 'eggs'],
      'fish': ['fish', 'salmon', 'tuna'],
      'wheat': ['wheat', 'flour', 'gluten'],
      'gluten': ['gluten'],
      'soy': ['soy', 'soybean'],
      'peanut': ['peanut', 'peanuts'],
      'tree nut': ['almond', 'cashew', 'walnut', 'pecan', 'hazelnut'],
      'shellfish': ['shrimp', 'crab', 'lobster', 'oyster', 'clam'],
      'sesame': ['sesame'],
    };

    final List<String> patterns = [];
    for (final raw in userAllergens) {
      final label = raw.toLowerCase().trim();
      final keywords = keywordMap[label] ?? [label];
      patterns.addAll(keywords.map((k) => k.toLowerCase().trim()));
    }

    return dishLabels.any(
      (dishLabel) =>
          patterns.any((keyword) => dishLabel.contains(keyword)),
    );
  }

  /// All user allergen labels that appear in at least one dish here.
  Set<String> _suspectedRestaurantAllergens(
    List<Dish> dishes,
    List<String> userAllergens,
  ) {
    final Set<String> suspected = {};
    for (final dish in dishes) {
      for (final allergen in userAllergens) {
        if (_dishHasUserAllergen(dish, [allergen])) {
          suspected.add(allergen);
        }
      }
    }
    return suspected;
  }

  /// Guess possible allergy risk using restaurant name + description,
  /// even if there are no dishes from Yelp.
  Set<String> _suspectedAllergiesFromRestaurantText(
    Restaurant r,
    List<String> userAllergens,
  ) {
    final text = ('${r.name} ${r.description}').toLowerCase();

    // Keywords we might see in Yelp categories/description mapped to allergens.
    final Map<String, List<String>> triggers = {
      'seafood': ['fish', 'shellfish'],
      'oyster': ['fish', 'shellfish'],
      'sushi': ['fish'],
      'noodle': ['wheat', 'gluten'],
      'noodles': ['wheat', 'gluten'],
      'dumpling': ['wheat', 'gluten'],
      'pizza': ['wheat', 'gluten', 'milk'],
      'bakery': ['wheat', 'gluten', 'egg', 'milk'],
      'ice cream': ['milk'],
      'creamery': ['milk'],
      'cheese': ['milk'],
      'thai': ['peanut', 'soy'],
      'malaysian': ['peanut', 'soy'],
    };

    final userSet =
        userAllergens.map((a) => a.toLowerCase().trim()).toSet();
    final Set<String> suspected = {};

    for (final entry in triggers.entries) {
      if (text.contains(entry.key)) {
        for (final possible in entry.value) {
          if (userSet.contains(possible)) {
            suspected.add(possible);
          }
        }
      }
    }

    return suspected;
  }
}
