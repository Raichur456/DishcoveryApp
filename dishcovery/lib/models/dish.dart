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
