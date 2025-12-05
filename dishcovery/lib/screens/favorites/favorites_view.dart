import 'package:flutter/material.dart';
import '../../models/restaurant.dart';
import '../../utils/favorites_manager.dart';
import '../home/dish_view.dart';

// The FavoritesView class displays the user's favorite restaurants and implements undo and
// redo functionality for changes made to the favorites list
class FavoritesView extends StatefulWidget {
  // Behavior: constructs the favorites view widget
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

// The _FavoritesViewState class manages the state of the FavoritesView
class _FavoritesViewState extends State<FavoritesView> {
  // list of favorite restaurants from the manager.
  List<Restaurant> get _favoriteRestaurants =>
      FavoritesManager.instance.favorites;

  // undo stack for favorites changes
  final List<List<Restaurant>> _undoStack = [];
  // redo stack for favorites changes
  final List<List<Restaurant>> _redoStack = [];

  // Behavior: saves the current state for undo
  void _saveStateForUndo() {
    _undoStack.add(List<Restaurant>.from(_favoriteRestaurants));
    _redoStack.clear();
  }

  // Behavior: undoes the last change to favorites
  void _undo() {
    if (_undoStack.isNotEmpty) {
      _redoStack.add(List<Restaurant>.from(_favoriteRestaurants));
      final previous = _undoStack.removeLast();
      FavoritesManager.instance.replaceAll(previous);
      setState(() {});
    }
  }

  // Behavior: redoes the last undone change to favorites
  void _redo() {
    if (_redoStack.isNotEmpty) {
      _undoStack.add(List<Restaurant>.from(_favoriteRestaurants));
      final next = _redoStack.removeLast();
      FavoritesManager.instance.replaceAll(next);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Favorite Restaurants'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back to Landing',
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          },
        ),
        actions: [
          // undo and redo buttons
          IconButton(
            icon: const Icon(Icons.undo),
            tooltip: 'Undo',
            onPressed: _undoStack.isNotEmpty ? _undo : null,
          ),
          IconButton(
            icon: const Icon(Icons.redo),
            tooltip: 'Redo',
            onPressed: _redoStack.isNotEmpty ? _redo : null,
          ),
        ],
      ),
      body: _favoriteRestaurants.isEmpty
          ? const Center(child: Text('No favorites yet.'))
          : ListView.builder(
              itemCount: _favoriteRestaurants.length,
              itemBuilder: (context, index) {
                final restaurant = _favoriteRestaurants[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        restaurant.imageUrl,
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.restaurant),
                      ),
                    ),
                    title: Text(restaurant.name),
                    subtitle: Text(
                      restaurant.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _saveStateForUndo();
                        setState(() {
                          FavoritesManager.instance.remove(restaurant);
                        });
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DishView(restaurant: restaurant),
                        ),
                      ).then((_) => setState(() {}));
                    },
                  ),
                );
              },
            ),
    );
  }
}
