import '../models/restaurant.dart';
import '../models/dish.dart';

const mockRestaurants = <Restaurant>[
  Restaurant(
    id: 'r6',
    name: 'Pizza Plaza',
    description: 'Wood-fired pizzas and Italian classics.',
    imageUrl:
        'https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=800&q=80',
    rating: 4.7,
    dishes: [
      Dish(
        id: 'd12',
        restaurantId: 'r6',
        name: 'Margherita Pizza',
        price: 11.99,
        imageUrl:
            'https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=800&q=80',
        containsAllergens: ['Gluten', 'Dairy'],
        safeForAllergens: [],
      ),
      Dish(
        id: 'd13',
        restaurantId: 'r6',
        name: 'Pepperoni Pizza',
        price: 13.49,
        imageUrl:
            'https://images.unsplash.com/photo-1548365328-8b849e6c7b8b?auto=format&fit=crop&w=800&q=80',
        containsAllergens: ['Gluten', 'Dairy'],
        safeForAllergens: [],
      ),
    ],
  ),
  Restaurant(
    id: 'r7',
    name: 'Vegan Vibes',
    description: 'Plant-based meals and smoothies.',
    imageUrl:
        'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg',
    rating: 4.8,
    dishes: [
      Dish(
        id: 'd14',
        restaurantId: 'r7',
        name: 'Quinoa Salad',
        price: 9.99,
        imageUrl:
            'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg',
        containsAllergens: [],
        safeForAllergens: ['Vegan', 'Gluten-Free'],
      ),
      Dish(
        id: 'd15',
        restaurantId: 'r7',
        name: 'Vegan Burger',
        price: 10.99,
        imageUrl:
            'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg',
        containsAllergens: ['Gluten'],
        safeForAllergens: ['Vegan'],
      ),
    ],
  ),
  Restaurant(
    id: 'r8',
    name: 'Mediterranean Grill',
    description: 'Greek and Mediterranean favorites.',
    imageUrl:
        'https://images.pexels.com/photos/461382/pexels-photo-461382.jpeg',
    rating: 4.3,
    dishes: [
      Dish(
        id: 'd16',
        restaurantId: 'r8',
        name: 'Chicken Souvlaki',
        price: 12.99,
        imageUrl:
            'https://images.pexels.com/photos/461382/pexels-photo-461382.jpeg',
        containsAllergens: ['Gluten'],
        safeForAllergens: [],
      ),
      Dish(
        id: 'd17',
        restaurantId: 'r8',
        name: 'Falafel Plate',
        price: 10.49,
        imageUrl:
            'https://images.pexels.com/photos/461382/pexels-photo-461382.jpeg',
        containsAllergens: [],
        safeForAllergens: ['Vegan'],
      ),
    ],
  ),
  Restaurant(
    id: 'r9',
    name: 'BBQ Pit',
    description: 'Barbecue ribs, brisket, and more.',
    imageUrl:
        'https://images.pexels.com/photos/675951/pexels-photo-675951.jpeg',
    rating: 4.0,
    dishes: [
      Dish(
        id: 'd18',
        restaurantId: 'r9',
        name: 'BBQ Ribs',
        price: 15.99,
        imageUrl:
            'https://images.pexels.com/photos/675951/pexels-photo-675951.jpeg',
        containsAllergens: [],
        safeForAllergens: [],
      ),
      Dish(
        id: 'd19',
        restaurantId: 'r9',
        name: 'Pulled Pork Sandwich',
        price: 11.99,
        imageUrl:
            'https://images.pexels.com/photos/675951/pexels-photo-675951.jpeg',
        containsAllergens: ['Gluten'],
        safeForAllergens: [],
      ),
    ],
  ),
  Restaurant(
    id: 'r10',
    name: 'Breakfast Bistro',
    description: 'All-day breakfast and brunch.',
    imageUrl:
        'https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg',
    rating: 4.6,
    dishes: [
      Dish(
        id: 'd20',
        restaurantId: 'r10',
        name: 'Pancake Stack',
        price: 8.99,
        imageUrl:
            'https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg',
        containsAllergens: ['Gluten', 'Eggs', 'Dairy'],
        safeForAllergens: [],
      ),
      Dish(
        id: 'd21',
        restaurantId: 'r10',
        name: 'Avocado Toast',
        price: 7.49,
        imageUrl:
            'https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg',
        containsAllergens: ['Gluten'],
        safeForAllergens: [],
      ),
    ],
  ),
  Restaurant(
    id: 'r1',
    name: 'Bombay Spice',
    description: 'Authentic Indian cuisine with biryani, curries, and naan.',
    imageUrl:
        'https://images.unsplash.com/photo-1504674900247-eca3a4b9b6b3?auto=format&fit=crop&w=800&q=80',
    rating: 4.6,
    dishes: [
      Dish(
        id: 'd1',
        restaurantId: 'r1',
        name: 'Chicken Biryani',
        price: 14.99,
        imageUrl:
            'https://images.unsplash.com/photo-1504674900247-eca3a4b9b6b3?auto=format&fit=crop&w=800&q=80',
        containsAllergens: ['Dairy'],
        safeForAllergens: ['Peanut-Free'],
      ),
      Dish(
        id: 'd2',
        restaurantId: 'r1',
        name: 'Paneer Tikka',
        price: 12.50,
        imageUrl:
            'https://images.unsplash.com/photo-1519864600265-abb23847ef2c?auto=format&fit=crop&w=800&q=80',
        containsAllergens: ['Dairy'],
        safeForAllergens: ['Peanut-Free', 'Gluten-Free'],
      ),
      Dish(
        id: 'd3',
        restaurantId: 'r1',
        name: 'Garlic Naan',
        price: 4.99,
        imageUrl:
            'https://images.unsplash.com/photo-1523987355523-c7b5b0723c6a?auto=format&fit=crop&w=800&q=80',
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
        'https://images.unsplash.com/photo-1467003909585-2f8a72700288?auto=format&fit=crop&w=800&q=80',
    rating: 4.4,
    dishes: [
      Dish(
        id: 'd4',
        restaurantId: 'r2',
        name: 'Salmon Nigiri',
        price: 9.99,
        imageUrl:
            'https://images.unsplash.com/photo-1502741338009-cac2772e18bc?auto=format&fit=crop&w=800&q=80',
        containsAllergens: ['Fish'],
        safeForAllergens: ['Dairy-Free'],
      ),
      Dish(
        id: 'd5',
        restaurantId: 'r2',
        name: 'Veggie Ramen',
        price: 13.50,
        imageUrl:
            'https://images.unsplash.com/photo-1504674900247-eca3a4b9b6b3?auto=format&fit=crop&w=800&q=80',
        containsAllergens: ['Gluten', 'Soy'],
        safeForAllergens: ['Nut-Free'],
      ),
    ],
  ),
  // --- Additional mock restaurants ---
  Restaurant(
    id: 'r3',
    name: 'Burger Barn',
    description: 'Juicy burgers and crispy fries.',
    imageUrl:
        'https://images.pexels.com/photos/1639566/pexels-photo-1639566.jpeg',
    rating: 4.2,
    dishes: [
      Dish(
        id: 'd6',
        restaurantId: 'r3',
        name: 'Classic Cheeseburger',
        price: 9.99,
        imageUrl:
            'https://images.pexels.com/photos/1639566/pexels-photo-1639566.jpeg',
        containsAllergens: ['Gluten', 'Dairy'],
        safeForAllergens: [],
      ),
      Dish(
        id: 'd7',
        restaurantId: 'r3',
        name: 'Veggie Burger',
        price: 8.49,
        imageUrl:
            'https://images.pexels.com/photos/70497/pexels-photo-70497.jpeg',
        containsAllergens: ['Gluten'],
        safeForAllergens: [],
      ),
    ],
  ),
  Restaurant(
    id: 'r4',
    name: 'Curry Corner',
    description: 'Spicy and savory Indian curries.',
    imageUrl:
        'https://images.unsplash.com/photo-1504674900247-eca3a4b9b6b3?auto=format&fit=crop&w=800&q=80',
    rating: 4.5,
    dishes: [
      Dish(
        id: 'd8',
        restaurantId: 'r4',
        name: 'Chicken Tikka Masala',
        price: 13.99,
        imageUrl:
            'https://images.pexels.com/photos/461382/pexels-photo-461382.jpeg',
        containsAllergens: ['Dairy'],
        safeForAllergens: [],
      ),
      Dish(
        id: 'd9',
        restaurantId: 'r4',
        name: 'Chana Masala',
        price: 11.49,
        imageUrl:
            'https://images.pexels.com/photos/461382/pexels-photo-461382.jpeg',
        containsAllergens: [],
        safeForAllergens: [],
      ),
    ],
  ),
  Restaurant(
    id: 'r5',
    name: 'Taco Town',
    description: 'Tacos, burritos, and more.',
    imageUrl:
        'https://images.unsplash.com/photo-1600891963935-c9b6d7e6a6c9?auto=format&fit=crop&w=800&q=80',
    rating: 4.1,
    dishes: [
      Dish(
        id: 'd10',
        restaurantId: 'r5',
        name: 'Beef Taco',
        price: 3.99,
        imageUrl:
            'https://images.pexels.com/photos/461382/pexels-photo-461382.jpeg',
        containsAllergens: ['Gluten'],
        safeForAllergens: [],
      ),
      Dish(
        id: 'd11',
        restaurantId: 'r5',
        name: 'Fish Burrito',
        price: 7.99,
        imageUrl:
            'https://images.pexels.com/photos/461382/pexels-photo-461382.jpeg',
        containsAllergens: ['Fish', 'Gluten'],
        safeForAllergens: [],
      ),
    ],
  ),
];
