import 'dish.dart';

/// This class represents a restaurant. Each restaurant consists of a restaurant id, 
/// a name, a short description of what the restaurant is all about, an image url to 
/// display in the home page, a rating, and a list of dishes. 
class Restaurant {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double rating;
  final List<Dish> dishes;

  const Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.dishes,
  });
}
