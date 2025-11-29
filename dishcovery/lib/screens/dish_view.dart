import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../models/dish.dart';

class DishView extends StatelessWidget {
  final Restaurant restaurant;

  const DishView({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    final List<Dish> dishes = restaurant.dishes;

    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
      ),
      body: ListView.builder(
        itemCount: dishes.length,
        itemBuilder: (context, index) {
          final Dish dish = dishes[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  dish.imageUrl,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.fastfood),
                ),
              ),
              title: Text(dish.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('\$${dish.price.toStringAsFixed(2)}'),
                  const SizedBox(height: 4),
                  if (dish.containsAllergens.isNotEmpty)
                    Text(
                      'Contains: ${dish.containsAllergens.join(', ')}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  if (dish.safeForAllergens.isNotEmpty)
                    Text(
                      'Safe for: ${dish.safeForAllergens.join(', ')}',
                      style: const TextStyle(color: Colors.green),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
