import 'dart:convert';
import 'package:http/http.dart' as http;

/// This class represents a Food API. It makes an http request to fetch 
/// data relating to food whose barcode gets scanned and returns a list of ingredients 
/// used to make the item. 
class FoodApi {

  /// B: Fetches a string of ingredients in json
  /// E: N/A
  /// R: String - list of ingredients as JSON text if found, null otherwise
  /// P: String barcode - the barcode of the food whose ingredients 
  ///    we are looking up
  static Future<String?> fetchIngredients(String barcode) async {
    final url = Uri.parse(
      'https://world.openfoodfacts.org/api/v0/product/$barcode.json',
    );

    /// We make an http request; User Agent and name of the app 
    /// are necessary when accessing OpenFoodFacts 
    /// https://openfoodfacts.github.io/openfoodfacts-dart/
    final res = await http.get(
      url,
      headers: {
        "User-Agent": "Dishcovery - Flutter",
      },
    );

    /// result code 200 indicates result was found. 
    /// Other results like 404 indicate an error and we 
    /// return null
    if (res.statusCode != 200) return null;

    // Decodes the result we fetched from HTTP
    final data = jsonDecode(res.body);

    // Returns null if status is not 1, product not found
    if (data['status'] != 1) return null;

    // getting the product (almost like an array)
    final product = data['product'];

    // getting the product's ingredients
    final ingredientsText = product['ingredients_text'];

    // Retung the ingredients_text associated with the product
    if (ingredientsText != null && ingredientsText.toString().isNotEmpty) {
      return ingredientsText;
    }

    return null;
  }
}
