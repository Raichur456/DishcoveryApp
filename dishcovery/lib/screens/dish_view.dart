import 'package:flutter/material.dart';
import '../models/restaurant.dart';

import '../models/dish.dart';
import '../utils/favorites_manager.dart';

class DishView extends StatefulWidget {
  final Restaurant restaurant;
  const DishView({Key? key, required this.restaurant}) : super(key: key);

  @override
  State<DishView> createState() => _DishViewState();
}

class _DishViewState extends State<DishView> {
  @override
  Widget build(BuildContext context) {
    final List<Dish> dishes = widget.restaurant.dishes;
    final isFav = FavoritesManager.instance.isFavorite(widget.restaurant);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Text(
                widget.restaurant.name,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              icon: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: isFav ? Colors.red : null,
              ),
              tooltip: isFav ? 'Unlike' : 'Like',
              onPressed: () {
                setState(() {
                  if (isFav) {
                    FavoritesManager.instance.remove(widget.restaurant);
                  } else {
                    FavoritesManager.instance.add(widget.restaurant);
                  }
                });
              },
            ),
          ],
        ),
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
