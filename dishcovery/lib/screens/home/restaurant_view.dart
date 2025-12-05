import 'package:flutter/material.dart';

import '../../config/mock_data.dart';
import '../../models/restaurant.dart';
import '../../utils/favorites_manager.dart';
import '../home/dish_view.dart';

// The RestaurantView class provides a scrollable list of restaurants
class RestaurantView extends StatefulWidget {
  // constructs the restaurant view widget
  const RestaurantView({super.key});

  @override
  State<RestaurantView> createState() => _RestaurantViewState();
}

// The _RestaurantViewState class manages the state of the RestaurantView
class _RestaurantViewState extends State<RestaurantView> {
  @override
  Widget build(BuildContext context) {
    // main scaffold for restaurant list screen
    return Scaffold(
      appBar: AppBar(title: const Text('Restaurants')),
      body: ListView.builder(
        itemCount: mockRestaurants.length,
        itemBuilder: (context, index) {
          final Restaurant restaurant = mockRestaurants[index];
          final bool isFav = FavoritesManager.instance.isFavorite(restaurant);

          // card for each restaurant, supports favoriting and tap-to-view
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  restaurant.imageUrl,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,

                  // fallback icon
                  errorBuilder: (_, __, ___) => const Icon(Icons.restaurant),
                ),
              ),
              title: Text(restaurant.name),
              subtitle: Text(
                restaurant.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // favorite toggle button
                  IconButton(
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? Colors.red : null,
                    ),
                    onPressed: () {
                      setState(() {
                        if (isFav) {
                          FavoritesManager.instance.remove(restaurant);
                        } else {
                          FavoritesManager.instance.add(restaurant);
                        }
                      });
                    },
                  ),
                  const SizedBox(width: 4),
                  // restaurant rating
                  const Icon(Icons.star, size: 16, color: Colors.amber),
                  Text(restaurant.rating.toStringAsFixed(1)),
                ],
              ),
              onTap: () {
                // navigate to dish details
                Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                        builder: (_) => DishView(restaurant: restaurant),
                      ),
                    )
                    .then((_) {
                      setState(() {});
                    });
              },
            ),
          );
        },
      ),
    );
  }
}
