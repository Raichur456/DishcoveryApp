import 'package:flutter/material.dart';
import '../config/mock_data.dart';
import '../models/restaurant.dart';
import 'dish_view.dart';

class RestaurantView extends StatelessWidget {
  const RestaurantView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Restaurants')),
      body: ListView.builder(
        itemCount: mockRestaurants.length,
        itemBuilder: (context, index) {
          final Restaurant restaurant = mockRestaurants[index];

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
                  const Icon(Icons.star, size: 16, color: Colors.amber),
                  Text(restaurant.rating.toStringAsFixed(1)),
                ],
              ),
              onTap: () {
                // Open the DishView for this restaurant
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => DishView(restaurant: restaurant),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
