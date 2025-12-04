// ignore: dangling_library_doc_comments
/// This class represents a Dish. A Dish consists of an id, the id of the restaurant 
/// it belongs to, a name, a price, an imageUrl that displays it, a list of 
/// allergens that it contains, and a list of allergens that it is safe for. 

class Dish {
  final String id;
  final String restaurantId;
  final String name;
  final double price;
  final String imageUrl;
  final List<String> containsAllergens;
  final List<String> safeForAllergens;

  const Dish({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.containsAllergens,
    required this.safeForAllergens,
  });
}
