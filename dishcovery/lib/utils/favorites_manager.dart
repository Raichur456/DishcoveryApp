import '../models/restaurant.dart';

class FavoritesManager {
  FavoritesManager._privateConstructor();
  static final FavoritesManager _instance =
      FavoritesManager._privateConstructor();
  static FavoritesManager get instance => _instance;

  final List<Restaurant> _favorites = [];

  List<Restaurant> get favorites => List.unmodifiable(_favorites);

  bool isFavorite(Restaurant restaurant) =>
      _favorites.any((r) => r.id == restaurant.id);

  void add(Restaurant restaurant) {
    if (!isFavorite(restaurant)) {
      _favorites.add(restaurant);
    }
  }

  void remove(Restaurant restaurant) {
    _favorites.removeWhere((r) => r.id == restaurant.id);
  }
}
