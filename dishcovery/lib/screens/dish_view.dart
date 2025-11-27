import 'package:flutter/material.dart'; // mockData for dish
import '../models/restaurant.dart';
import '../models/dish.dart';

class DishView extends StatelessWidget {
  final Restaurant restaurant;

  const DishView({super.key, required this.restaurant});

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
          final dish = dishes[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  dish.imageUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                dish.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '\$${dish.price.toStringAsFixed(2)}\n'
                'Contains: ${dish.containsAllergens.isEmpty ? 'None' : dish.containsAllergens.join(", ")}\n'
                'Safe for: ${dish.safeForAllergens.isEmpty ? '—' : dish.safeForAllergens.join(", ")}',
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}
