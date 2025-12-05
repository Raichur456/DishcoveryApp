import 'package:flutter/material.dart';
import '../../models/restaurant.dart';

/// This class implements a Draggable Restaurant. Used to easily add
/// restaurants to and remove from favorites list, if wanting to do
/// many at a time.
class DraggableFavoriteRestaurantCard extends StatefulWidget {
  // The restaurant being represented
  final Restaurant restaurant;

  // Whether or not the restaurant is favorited
  final bool isFavorite;

  // What should happen if favorite is toggled (does the opposite of current state)
  final VoidCallback onToggleFavorite;

  // What should happen on tap
  final VoidCallback onTap;

  const DraggableFavoriteRestaurantCard({
    super.key,
    required this.restaurant,
    required this.isFavorite,
    required this.onToggleFavorite,
    required this.onTap,
  });

  @override
  State<DraggableFavoriteRestaurantCard> createState() =>
      _DraggableFavoriteRestaurantCardState();
}

class _DraggableFavoriteRestaurantCardState
    extends State<DraggableFavoriteRestaurantCard> {
  // Current drag
  double _dx = 0;

  // Drag needed to toggle favorite/unfavorite
  static const double _trigger = 10;

  // B: How the drag changes as the user moves their finger. 
  // details.delta.dx signifies that the widget only takes into 
  // consideration the dragging that happens in the horizontal 
  // direction while discarding any other types of dragging. 
  // E: N/A
  // R: N/A
  // P: DragUpdateDetails details - details regarding the user dragging the widget
  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _dx += details.delta.dx;
    });
  }

  /// What happens when user lets go of the card
  void _onPanEnd(DragEndDetails details) {
    final bool shouldFavorite =
        // Case: drag to the right
        (_dx > _trigger) && !widget.isFavorite;
    final bool shouldUnfavorite =
        // Case: drag to the left
        (_dx < -_trigger) && widget.isFavorite;

    if (shouldFavorite || shouldUnfavorite) {
      widget.onToggleFavorite();
    }

    // Places widget to original position
    setState(() {
      _dx = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.restaurant;

    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 12),
            // color: widget.isFavorite ? Colors.green[50] : Colors.pink[50],
          ),
        ),

        // Foreground card that moves with the user's finger
        Transform.translate(
          offset: Offset(_dx, 0),
          child: GestureDetector(
            onPanUpdate: _onPanUpdate,
            onPanEnd: _onPanEnd,
            onTap: widget.onTap,
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Image.network(
                      r.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.restaurant),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                // Name of the restaurant
                                r.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Icon(
                              // Displays different Icon + color depending on if favorited
                              widget.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: widget.isFavorite
                                  ? Colors.red
                                  : Colors.grey,
                              size: 18,
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          // Restaurant description
                          r.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          // Restaurant review stuff to be displayed
                          children: [
                            const Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 4),
                            Text(r.rating.toStringAsFixed(1)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
