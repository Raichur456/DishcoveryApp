import 'package:dishcovery/db/allergen_database.dart';
import 'package:flutter/material.dart';
import '../../providers/food_api.dart';

/* This file represents the ingredients results page. This gets pushes into view 
* after the barcode scanner scans an item. It will either return the ingredients listed
* along with whether or not the food is safe to consume, or nothing if no food assocaited
* with the barcode number is found.
*/
class IngredientResultPage extends StatefulWidget {
  final String barcode;
  final AllergenDatabase db;

  const IngredientResultPage({
    super.key,
    required this.barcode,
    required this.db,
  });

  @override
  State<IngredientResultPage> createState() => _IngredientResultPageState();
}

class _IngredientResultPageState extends State<IngredientResultPage> {
  late Future<_IngredientAndAllergenData> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = _loadData();
  }

  // Loads data from the food api
  Future<_IngredientAndAllergenData> _loadData() async {
    final ingredientsText = await FoodApi.fetchIngredients(widget.barcode);
    final userAllergens = await widget.db.getAllergens();

    final list = ingredientsText == null
        ? <String>[]
        : _parseIngredients(ingredientsText);

    // Returns an ingredient's information, most of which was 
    // fetched from the Food API
    return _IngredientAndAllergenData(
      barcode: widget.barcode,
      ingredientsText: ingredientsText ?? '',
      ingredients: list,
      userAllergens: userAllergens,
    );
  }

  // Used to test if the ingredient is among any of the user's allergens
  bool _ingredientHasAllergen(String ingredient, List<String> userAllergens) {
    final ingLower = ingredient.toLowerCase();

    // We populate with allergens associated with what we mapped 
    // specific keys to be. For example, if "fish" is a selected allergen,
    // it populates this list with "tuna" and "salmon" 
    final List<String> patterns = [];

    for (final rawLabel in userAllergens) {
      final label = rawLabel.toLowerCase().trim();
      final keywords = allergenKeywordMap[label] ?? [label];
      patterns.addAll(keywords.map((k) => k.toLowerCase().trim()));
    }

    // Runs a comparison to see if any of our listed allergens are within the ingredients
    // of the food item. 
    return patterns.any((keyword) => ingLower.contains(keyword));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // App bar that says Ingredients for (barcode number) are being shown
      appBar: AppBar(
        title: Text('Ingredients for ${widget.barcode}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back to Landing',
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          },
        ),
      ),
      body: FutureBuilder<_IngredientAndAllergenData>(
        future: _futureData,

        // Builds page around the snapshot, our fetched IngredientAndAllergenData; 
        // manages and reacts to state of asynchronous operation
        builder: (context, snapshot) {

          // Case: snapshot waiting (so not fetched yet)
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Case: snapshot error (error fetching the IngredientAndAllergenData)
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // Else: returns snapshot data
          final data = snapshot.data;

          // Case: no ingredients associated with the barcode/dish
          if (data == null || data.ingredients.isEmpty) {
            return const Center(child: Text('No ingredient data found.'));
          }

          final ingredients = data.ingredients;
          final allergens = data.userAllergens;

          final offending = ingredients
              .where((ing) => _ingredientHasAllergen(ing, allergens))
              .toList();

          // Else: Lists out if food can be eaten or not
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Safe/ Unsafe
              Container(
                padding: const EdgeInsets.all(16),
                color: offending.isNotEmpty
                    ? Colors.red[700]
                    : Colors.green[700],
                child: Text(
                  offending.isNotEmpty ? 'NOT SAFE FOR YOU' : 'SAFE FOR YOU',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Lists offending ingredients
              if (offending.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(12),
                  color: Colors.red[200],
                  child: Text(
                    'Contains: ${offending.join(", ")}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

              const SizedBox(height: 8),

              // Lists the ingredients
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView.builder(
                    itemCount: ingredients.length,
                    itemBuilder: (context, index) {
                      final ingredient = ingredients[index];
                      final unsafe = _ingredientHasAllergen(
                        ingredient,
                        allergens,
                      );

                      return Card(
                        color: unsafe ? Colors.red[50] : Colors.green[50],
                        child: ListTile(
                          title: Text(
                            ingredient,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: unsafe
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                          trailing: unsafe
                              ? const Icon(Icons.error, color: Colors.red)
                              : const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Turns the JSON string of ingredients found from scanning the item
/// into a list of strings
List<String> _parseIngredients(String ingredientsText) {
  return ingredientsText
      .split(RegExp(r'[;,]'))
      .map((s) => s.trim())
      .where((s) => s.isNotEmpty)
      .toList();
}

/// Made a map. I kept failing testing cans of tuna because it doesn't have the
/// ingredient "fish" in it, so mapping a name to different potential string values
/// seemed to be helpful
const Map<String, List<String>> allergenKeywordMap = {
  'milk': ['milk', 'lactose', 'casein', 'whey'],
  'egg': ['egg', 'albumen'],
  'peanut': ['peanut'],
  'tree nut': [
    'almond',
    'walnut',
    'cashew',
    'pecan',
    'hazelnut',
    'pistachio',
    'macadamia',
    'brazil nut',
    'pine nut',
    'chestnut',
  ],
  'gluten': ['wheat', 'barley', 'rye', 'malt', 'spelt'],
  'soy': ['soy', 'soya', 'soybean'],
  'sesame': ['sesame'],
  'fish': ['tuna', 'salmon'],
};

// This class represents the ingredient and allergen data of the fetched food item. 
// It contains the barcode, (which we scanned from barcode_scanner_page), a text
// representation of ingredients (if applicable), a list representation of 
// its ingredients, and the user allergens. 
class _IngredientAndAllergenData {
  final String barcode;
  final String ingredientsText;
  final List<String> ingredients;
  final List<String> userAllergens;

  _IngredientAndAllergenData({
    required this.barcode,
    required this.ingredientsText,
    required this.ingredients,
    required this.userAllergens,
  });
}
