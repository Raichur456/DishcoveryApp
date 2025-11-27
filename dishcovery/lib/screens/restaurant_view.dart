import 'package:flutter/material.dart';
import '../config/mock_data.dart';
import '../models/restaurant.dart';
import 'dish_view.dart';

class RestaurantView extends StatelessWidget {
  const RestaurantView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurants'),
      ),
      body: ListView.builder(
        itemCount: mockRestaurants.length,
        itemBuilder: (context, index) {
          final Restaurant restaurant = mockRestaurants[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  restaurant.imageUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                restaurant.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${restaurant.description}\n⭐ ${restaurant.rating.toStringAsFixed(1)}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              isThreeLine: true,
              onTap: () {
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
