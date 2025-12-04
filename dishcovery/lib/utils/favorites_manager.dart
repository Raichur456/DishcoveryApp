import '../models/restaurant.dart';
import '../db/allergen_database.dart';

class FavoritesManager {
  FavoritesManager._privateConstructor();
  static final FavoritesManager _instance =
      FavoritesManager._privateConstructor();
  static FavoritesManager get instance => _instance;

  final List<Restaurant> _favorites = [];

  late AllergenDatabase _db;
  late List<Restaurant> _allRestaurants;
  bool _initialized = false;

  /// B: Initializes the favorites manager with a database and the full list of
  ///    restaurants, then loads any saved favorites from the DB.
  /// E: N/A
  /// R: Future<void>
  /// P: AllergenDatabase db - the Drift database
  ///    List<Restaurant> allRestaurants - all restaurants available in the app
  Future<void> init({
    required AllergenDatabase db,
    required List<Restaurant> allRestaurants,
  }) async {
    if (_initialized) return;

    _db = db;
    _allRestaurants = allRestaurants;

    // Load saved restaurant IDs from the DB and map them to Restaurant objects.
    final savedIds = await _db.getRestaurantIds();
    final idSet = savedIds.toSet();

    _favorites
      ..clear()
      ..addAll(
        _allRestaurants.where((r) => idSet.contains(r.id)),
      );

    _initialized = true;
  }

  List<Restaurant> get favorites => List.unmodifiable(_favorites);

  bool isFavorite(Restaurant restaurant) =>
      _favorites.any((r) => r.id == restaurant.id);

  void add(Restaurant restaurant) {
    if (!isFavorite(restaurant)) {
      _favorites.add(restaurant);
      _syncToDb();
    }
  }

  void remove(Restaurant restaurant) {
    _favorites.removeWhere((r) => r.id == restaurant.id);
    _syncToDb();
  }

  /// Replace the entire favorites list. Useful for undo/redo operations.
  void replaceAll(List<Restaurant> restaurants) {
    _favorites
      ..clear()
      ..addAll(restaurants);
    _syncToDb();
  }

  void _syncToDb() {
    if (!_initialized) return;

    final ids = _favorites.map((r) => r.id).toList();
    _db.setRestaurantIds(ids);
  }
}
