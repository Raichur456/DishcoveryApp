import '../models/restaurant.dart';
import '../models/dish.dart';

const mockRestaurants = <Restaurant>[
  Restaurant(
    id: 'r1',
    name: 'Bombay Spice',
    description: 'Authentic Indian cuisine with biryani, curries, and naan.',
    imageUrl:
        'https://images.pexels.com/photos/128422/pexels-photo-128422.jpeg',
    rating: 4.6,
    dishes: [
      Dish(
        id: 'd1',
        restaurantId: 'r1',
        name: 'Chicken Biryani',
        price: 14.99,
        imageUrl:
            'https://images.pexels.com/photos/128422/pexels-photo-128422.jpeg',
        containsAllergens: ['Dairy'],
        safeForAllergens: ['Peanut-Free'],
      ),
      Dish(
        id: 'd2',
        restaurantId: 'r1',
        name: 'Paneer Tikka',
        price: 12.50,
        imageUrl:
            'https://images.pexels.com/photos/1640772/pexels-photo-1640772.jpeg',
        containsAllergens: ['Dairy'],
        safeForAllergens: ['Peanut-Free', 'Gluten-Free'],
      ),
      Dish(
        id: 'd3',
        restaurantId: 'r1',
        name: 'Garlic Naan',
        price: 4.99,
        imageUrl:
            'https://images.pexels.com/photos/5638268/pexels-photo-5638268.jpeg',
        containsAllergens: ['Gluten'],
        safeForAllergens: ['Peanut-Free'],
      ),
    ],
  ),
  Restaurant(
    id: 'r2',
    name: 'Tokyo Sushi House',
    description: 'Sushi, sashimi & ramen with vegetarian options.',
    imageUrl:
        'https://images.pexels.com/photos/3577561/pexels-photo-3577561.jpeg',
    rating: 4.4,
    dishes: [
      Dish(
        id: 'd4',
        restaurantId: 'r2',
        name: 'Salmon Nigiri',
        price: 9.99,
        imageUrl:
            'https://images.pexels.com/photos/209808/pexels-photo-209808.jpeg',
        containsAllergens: ['Fish'],
        safeForAllergens: ['Dairy-Free'],
      ),
      Dish(
        id: 'd5',
        restaurantId: 'r2',
        name: 'Veggie Ramen',
        price: 13.50,
        imageUrl:
            'https://images.pexels.com/photos/884600/pexels-photo-884600.jpeg',
        containsAllergens: ['Gluten', 'Soy'],
        safeForAllergens: ['Nut-Free'],
      ),
    ],
  ),
];
