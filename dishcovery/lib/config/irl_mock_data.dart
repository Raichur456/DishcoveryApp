import '../models/restaurant.dart';
import '../models/dish.dart';

const irlMockRestaurants = <Restaurant>[
  // r1 – Pho Than Brothers (U District)
  Restaurant(
    id: 'r1',
    name: 'Pho Than Brothers',
    description: 'Classic Seattle pho spot known for rich broth and cream puffs.',
    imageUrl:
        'https://images.unsplash.com/photo-1519501025264-65ba15a82390?auto=format&fit=crop&w=800&q=80',
    rating: 4.5,
    dishes: [
      Dish(
        id: 'd1',
        restaurantId: 'r1',
        name: 'Pho Bo - Tai',
        price: 13.50,
        imageUrl:
            'https://images.unsplash.com/photo-1543353071-873f17a7a088?auto=format&fit=crop&w=800&q=80',
        containsAllergens: ['Fish'],
        safeForAllergens: ['Dairy-Free', 'Nut-Free'],
      ),
      Dish(
        id: 'd2',
        restaurantId: 'r1',
        name: 'Pho Ga',
        price: 13.00,
        imageUrl:
            'https://images.unsplash.com/photo-1512058564366-18510be2db19?auto=format&fit=crop&w=800&q=80',
        containsAllergens: ['Fish'],
        safeForAllergens: ['Dairy-Free', 'Nut-Free'],
      ),
      Dish(
        id: 'd3',
        restaurantId: 'r1',
        name: 'Pho Chay (Veggie Pho)',
        price: 13.50,
        imageUrl:
            'https://images.unsplash.com/photo-1525755662778-989d0524087e?auto=format&fit=crop&w=800&q=80',
        containsAllergens: ['Soy'],
        safeForAllergens: ['Dairy-Free', 'Nut-Free'],
      ),
    ],
  ),

  // r2 – Thai Tom (The Ave)
  Restaurant(
    id: 'r2',
    name: 'Thai Tom',
    description: 'Tiny, fiery Thai spot on The Ave with lines out the door.',
    imageUrl:
        'https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?auto=format&fit=crop&w=800&q=80',
    rating: 4.6,
    dishes: [
      Dish(
        id: 'd4',
        restaurantId: 'r2',
        name: 'Pad Thai (Chicken)',
        price: 15.50,
        imageUrl:
            'https://images.unsplash.com/photo-1604908176997-1251884b08a3?auto=format&fit=crop&w=800&q=80',
        containsAllergens: ['Eggs', 'Peanuts', 'Fish', 'Soy'],
        safeForAllergens: ['Dairy-Free'],
      ),
      Dish(
        id: 'd5',
        restaurantId: 'r2',
        name: 'Panang Curry (Chicken)',
        price: 16.00,
        imageUrl:
            'https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?auto=format&fit=crop&w=800&q=80',
        containsAllergens: ['Fish'],
        safeForAllergens: ['Dairy-Free', 'Gluten-Free'],
      ),
      Dish(
        id: 'd6',
        restaurantId: 'r2',
        name: 'Tom Yum Soup (Shrimp)',
        price: 15.00,
        imageUrl:
            'https://images.unsplash.com/photo-1534939561126-855b8675edd7?auto=format&fit=crop&w=800&q=80',
        containsAllergens: ['Shellfish', 'Fish'],
        safeForAllergens: ['Dairy-Free', 'Nut-Free', 'Gluten-Free'],
      ),
    ],
  ),

  // r3 – Morsel (U District)
  Restaurant(
    id: 'r3',
    name: 'Morsel',
    description: 'Beloved biscuit shop serving sandwiches, gravy, and coffee.',
    imageUrl:
        'https://images.unsplash.com/photo-1512058564366-18510be2db19?auto=format&fit=crop&w=800&q=80',
    rating: 4.7,
    dishes: [
      Dish(
        id: 'd7',
        restaurantId: 'r3',
        name: 'The Fast Break',
        price: 14.00,
        imageUrl:
            'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&w=800&q=80',
        containsAllergens: ['Gluten', 'Eggs', 'Dairy'],
        safeForAllergens: [],
      ),
      Dish(
        id: 'd8',
        restaurantId: 'r3',
        name: 'The Spanish Fly',
        price: 15.50,
        imageUrl:
            'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=800&q=80',
        containsAllergens: ['Gluten', 'Eggs', 'Dairy'],
        safeForAllergens: [],
      ),
      Dish(
        id: 'd9',
        restaurantId: 'r3',
        name: 'Biscuit & Gravy',
        price: 13.00,
        imageUrl:
            'https://images.unsplash.com/photo-1588167865096-71c620227d92?auto=format&fit=crop&w=800&q=80',
        containsAllergens: ['Gluten', 'Dairy'],
        safeForAllergens: [],
      ),
    ],
  ),

  // r4 – Cafe on the Ave
  Restaurant(
    id: 'r4',
    name: 'Cafe on the Ave',
    description: 'All-day cafe with Korean, Japanese, and American comfort food.',
    imageUrl:
        'https://images.unsplash.com/photo-1521017432531-fbd92d768814?auto=format&fit=crop&w=800&q=80',
    rating: 4.3,
    dishes: [
      Dish(
        id: 'd10',
        restaurantId: 'r4',
        name: 'Beef Bulgogi Bibimbap',
        price: 20.70,
        imageUrl:
            'https://images.unsplash.com/photo-1617196034796-73dfa7b1fd56?auto=format&fit=crop&w=800&q=80',
        containsAllergens: ['Soy', 'Sesame', 'Eggs', 'Gluten'],
        safeForAllergens: [],
      ),
      Dish(
        id: 'd11',
        restaurantId: 'r4',
        name: 'Katsudon',
        price: 16.10,
        imageUrl:
            'https://images.unsplash.com/photo-1553621042-f6e147245754?auto=format&fit=crop&w=800&q=80',
        containsAllergens: ['Gluten', 'Eggs', 'Soy', 'Dairy'],
        safeForAllergens: [],
      ),
      Dish(
        id: 'd12',
        restaurantId: 'r4',
        name: 'AVE Monster Burger',
        price: 20.70,
        imageUrl:
            'https://images.unsplash.com/photo-1550547660-d9450f859349?auto=format&fit=crop&w=800&q=80',
        containsAllergens: ['Gluten', 'Dairy', 'Eggs'],
        safeForAllergens: [],
      ),
    ],
  ),

  // r5 – Portage Bay Cafe (Roosevelt)
  Restaurant(
    id: 'r5',
    name: 'Portage Bay Cafe (Roosevelt)',
    description: 'Brunch spot focused on local, organic ingredients and big portions.',
    imageUrl:
        'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&w=800&q=80',
    rating: 4.6,
    dishes: [
      Dish(
        id: 'd13',
        restaurantId: 'r5',
        name: 'Seattle Benedict',
        price: 35.00,
        imageUrl:
            'https://images.unsplash.com/photo-1525755662778-989d0524087e?auto=format&fit=crop&w=800&q=80',
        containsAllergens: ['Eggs', 'Dairy', 'Gluten', 'Shellfish'],
        safeForAllergens: [],
      ),
      Dish(
        id: 'd14',
        restaurantId: 'r5',
        name: 'Classic Benedict',
        price: 26.00,
        imageUrl:
            'https://images.unsplash.com/photo-1508739773434-c26b3d09e071?auto=format&fit=crop&w=800&q=80',
        containsAllergens: ['Eggs', 'Dairy', 'Gluten'],
        safeForAllergens: [],
      ),
      Dish(
        id: 'd15',
        restaurantId: 'r5',
        name: 'Bananas Foster French Toast',
        price: 20.00,
        imageUrl:
            'https://images.unsplash.com/photo-1509440159596-0249088772ff?auto=format&fit=crop&w=800&q=80',
        containsAllergens: ['Gluten', 'Eggs', 'Dairy'],
        safeForAllergens: [],
      ),
    ],
  ),

  // r6 – Aladdin Gyro-Cery & Deli
  Restaurant(
    id: 'r6',
    name: 'Aladdin Gyro-Cery & Deli',
    description: 'Late-night Mediterranean spot famous for gyros and fries.',
    imageUrl:
        'https://images.unsplash.com/photo-1608038509085-7bb9d5c0d48b?auto=format&fit=crop&w=800&q=80',
    rating: 4.4,
    dishes: [
      Dish(
        id: 'd16',
        restaurantId: 'r6',
        name: 'Gyro Sandwich',
        price: 12.99,
        imageUrl:
            'https://images.unsplash.com/photo-1612929633738-8fe44f7ec841?auto=format&fit=crop&w=800&q=80',
        containsAllergens: ['Gluten', 'Dairy'],
        safeForAllergens: [],
      ),
      Dish(
        id: 'd17',
        restaurantId: 'r6',
        name: 'Falafel Sandwich',
        price: 11.50,
        imageUrl:
            'https://images.unsplash.com/photo-1615937691194-96f162713690?auto=format&fit=crop&w=800&q=80',
        containsAllergens: ['Gluten', 'Sesame'],
        safeForAllergens: ['Dairy-Free'],
      ),
      Dish(
        id: 'd18',
        restaurantId: 'r6',
        name: 'Aladdin Fries Special',
        price: 17.99,
        imageUrl:
            'https://images.unsplash.com/photo-1542280756-74b2f75e62c4?auto=format&fit=crop&w=800&q=80',
        containsAllergens: ['Dairy'],
        safeForAllergens: ['Nut-Free'],
      ),
    ],
  ),

  // r7 – Cedars (University District)
  Restaurant(
    id: 'r7',
    name: 'Cedars Restaurant',
    description: 'Indian & Mediterranean favorites just off campus.',
    imageUrl:
        'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=800&q=80',
    rating: 4.5,
    dishes: [
      Dish(
        id: 'd19',
        restaurantId: 'r7',
        name: 'Chicken Tikka Masala',
        price: 23.99,
        imageUrl:
            'https://images.unsplash.com/photo-1543340713-8b1caebc09fd?auto=format&fit=crop&w=800&q=80',
        containsAllergens: ['Dairy'],
        safeForAllergens: ['Nut-Free'],
      ),
      Dish(
        id: 'd20',
        restaurantId: 'r7',
        name: 'Channa Masala',
        price: 16.99,
        imageUrl:
            'https://images.unsplash.com/photo-1543353071-873f17a7a088?auto=format&fit=crop&w=800&q=80',
        containsAllergens: [],
        safeForAllergens: ['Vegan', 'Dairy-Free', 'Nut-Free'],
      ),
      Dish(
        id: 'd21',
        restaurantId: 'r7',
        name: 'Garlic Naan',
        price: 5.50,
        imageUrl:
            'https://images.unsplash.com/photo-1523987355523-c7b5b0723c6a?auto=format&fit=crop&w=800&q=80',
        containsAllergens: ['Gluten', 'Dairy'],
        safeForAllergens: [],
      ),
    ],
  ),

  // r8 – Xi’an Noodles (U District)
  Restaurant(
    id: 'r8',
    name: "Xi'an Noodles",
    description: 'Hand-pulled biang biang noodles and Shaanxi street food.',
    imageUrl:
        'https://images.unsplash.com/photo-1512058564366-18510be2db19?auto=format&fit=crop&w=800&q=80',
    rating: 4.7,
    dishes: [
      Dish(
        id: 'd22',
        restaurantId: 'r8',
        name: 'Spicy Cumin Lamb Biang Biang Noodles',
        price: 14.99,
        imageUrl:
            'https://images.unsplash.com/photo-1546069901-5ec6a79120b0?auto=format&fit=crop&w=800&q=80',
        containsAllergens: ['Gluten', 'Soy'],
        safeForAllergens: [],
      ),
      Dish(
        id: 'd23',
        restaurantId: 'r8',
        name: 'Spicy & Tingly Beef Biang Biang Noodles',
        price: 14.99,
        imageUrl:
            'https://images.unsplash.com/photo-1504544750208-dc0358e63f7f?auto=format&fit=crop&w=800&q=80',
        containsAllergens: ['Gluten', 'Soy'],
        safeForAllergens: [],
      ),
      Dish(
        id: 'd24',
        restaurantId: 'r8',
        name: 'Vegetable Biang Biang Noodles',
        price: 13.99,
        imageUrl:
            'https://images.unsplash.com/photo-1506354666786-959d6d497f1a?auto=format&fit=crop&w=800&q=80',
        containsAllergens: ['Gluten', 'Soy'],
        safeForAllergens: [],
      ),
    ],
  ),

  // r9 – U:Don Fresh Japanese Noodle Station
  Restaurant(
    id: 'r9',
    name: 'U:Don Fresh Japanese Noodle Station',
    description: 'Build-your-own udon bowls with broth, sauce, and toppings.',
    imageUrl:
        'https://images.unsplash.com/photo-1604908177525-4025a15c6817?auto=format&fit=crop&w=800&q=80',
    rating: 4.5,
    dishes: [
      Dish(
        id: 'd25',
        restaurantId: 'r9',
        name: 'Kake Soup Udon',
        price: 12.00,
        imageUrl:
            'https://images.unsplash.com/photo-1543353071-873f17a7a088?auto=format&fit=crop&w=800&q=80',
        containsAllergens: ['Gluten', 'Soy', 'Fish'],
        safeForAllergens: [],
      ),
      Dish(
        id: 'd26',
        restaurantId: 'r9',
        name: 'Niku Soup Udon (Soy Braised Beef)',
        price: 15.50,
        imageUrl:
            'https://images.unsplash.com/photo-1504542982118-59308b40fe0c?auto=format&fit=crop&w=800&q=80',
        containsAllergens: ['Gluten', 'Soy', 'Fish'],
        safeForAllergens: [],
      ),
      Dish(
        id: 'd27',
        restaurantId: 'r9',
        name: 'Kitsune Soup Udon',
        price: 14.50,
        imageUrl:
            'https://images.unsplash.com/photo-1625944527940-ef32bc4a5369?auto=format&fit=crop&w=800&q=80',
        containsAllergens: ['Gluten', 'Soy', 'Fish'],
        safeForAllergens: [],
      ),
    ],
  ),

  // r10 – Korean Tofu House
  Restaurant(
    id: 'r10',
    name: 'Korean Tofu House',
    description: 'Cozy Korean spot with bubbling tofu soups and BBQ plates.',
    imageUrl:
        'https://images.unsplash.com/photo-1604908176997-1251884b08a3?auto=format&fit=crop&w=800&q=80',
    rating: 4.4,
    dishes: [
      Dish(
        id: 'd28',
        restaurantId: 'r10',
        name: 'Seafood Tofu Soup',
        price: 11.99,
        imageUrl:
            'https://images.unsplash.com/photo-1546069901-5ec6a79120b0?auto=format&fit=crop&w=800&q=80',
        containsAllergens: ['Shellfish', 'Eggs', 'Soy'],
        safeForAllergens: ['Dairy-Free', 'Nut-Free'],
      ),
      Dish(
        id: 'd29',
        restaurantId: 'r10',
        name: 'Bibimbap',
        price: 12.49,
        imageUrl:
            'https://images.unsplash.com/photo-1604908176997-1251884b08a3?auto=format&fit=crop&w=800&q=80',
        containsAllergens: ['Eggs', 'Sesame', 'Soy'],
        safeForAllergens: ['Dairy-Free', 'Nut-Free'],
      ),
      Dish(
        id: 'd30',
        restaurantId: 'r10',
        name: 'Spicy BBQ Pork',
        price: 16.99,
        imageUrl:
            'https://images.unsplash.com/photo-1593032465171-8b8a3222289e?auto=format&fit=crop&w=800&q=80',
        containsAllergens: ['Soy', 'Sesame'],
        safeForAllergens: ['Dairy-Free', 'Nut-Free'],
      ),
    ],
  ),
  // r11 – Kukai Ramen & Izakaya (Northgate – Japanese Ramen)
Restaurant(
  id: 'r11',
  name: 'Kukai Ramen & Izakaya',
  description: 'Popular ramen stop with rich broths and shareable izakaya plates.',
  imageUrl:
      'https://images.unsplash.com/photo-1606755962773-d3243f4b8f1d?auto=format&fit=crop&w=800&q=80',
  rating: 4.5,
  dishes: [
    Dish(
      id: 'd31',
      restaurantId: 'r11',
      name: 'Tonkotsu Ramen',
      price: 15.50,
      imageUrl:
          'https://images.unsplash.com/photo-1606851091908-1d50f2f98d2e?auto=format&fit=crop&w=800&q=80',
      containsAllergens: ['Gluten', 'Eggs', 'Soy'],
      safeForAllergens: [],
    ),
    Dish(
      id: 'd32',
      restaurantId: 'r11',
      name: 'Shoyu Ramen',
      price: 14.50,
      imageUrl:
          'https://images.unsplash.com/photo-1557872943-16a5ac26437e?auto=format&fit=crop&w=800&q=80',
      containsAllergens: ['Gluten', 'Soy'],
      safeForAllergens: [],
    ),
    Dish(
      id: 'd33',
      restaurantId: 'r11',
      name: 'Chicken Karaage',
      price: 8.99,
      imageUrl:
          'https://images.unsplash.com/photo-1598511726903-5da5e049a3cd?auto=format&fit=crop&w=800&q=80',
      containsAllergens: ['Gluten', 'Eggs'],
      safeForAllergens: [],
    ),
  ],
),

// r12 – Ba Bar (Capitol Hill – Vietnamese)
Restaurant(
  id: 'r12',
  name: 'Ba Bar',
  description: 'Modern Vietnamese street food and craft cocktails.',
  imageUrl:
      'https://images.unsplash.com/photo-1553621042-f6e147245754?auto=format&fit=crop&w=800&q=80',
  rating: 4.6,
  dishes: [
    Dish(
      id: 'd34',
      restaurantId: 'r12',
      name: 'Phở Gà Trắng',
      price: 16.00,
      imageUrl:
          'https://images.unsplash.com/photo-1598514982842-2e0e12e51a9f?auto=format&fit=crop&w=800&q=80',
      containsAllergens: ['Fish'],
      safeForAllergens: [],
    ),
    Dish(
      id: 'd35',
      restaurantId: 'r12',
      name: 'Bún Chả',
      price: 18.50,
      imageUrl:
          'https://images.unsplash.com/photo-1603133872878-684f63c5f3f2?auto=format&fit=crop&w=800&q=80',
      containsAllergens: ['Fish', 'Soy'],
      safeForAllergens: [],
    ),
    Dish(
      id: 'd36',
      restaurantId: 'r12',
      name: 'Crispy Imperial Rolls',
      price: 10.00,
      imageUrl:
          'https://images.unsplash.com/photo-1604908176690-0adbdc995b42?auto=format&fit=crop&w=800&q=80',
      containsAllergens: ['Gluten', 'Soy'],
      safeForAllergens: [],
    ),
  ],
),

// r13 – Din Tai Fung (University Village – Taiwanese)
Restaurant(
  id: 'r13',
  name: 'Din Tai Fung',
  description: 'Famous dim sum and Taiwanese specialties.',
  imageUrl:
      'https://images.unsplash.com/photo-1585937421612-70a00805f3f8?auto=format&fit=crop&w=800&q=80',
  rating: 4.7,
  dishes: [
    Dish(
      id: 'd37',
      restaurantId: 'r13',
      name: 'Pork Xiao Long Bao',
      price: 14.75,
      imageUrl:
          'https://images.unsplash.com/photo-1583500179011-5cbe47f82a1b?auto=format&fit=crop&w=800&q=80',
      containsAllergens: ['Gluten'],
      safeForAllergens: [],
    ),
    Dish(
      id: 'd38',
      restaurantId: 'r13',
      name: 'Shrimp & Pork Dumplings',
      price: 15.50,
      imageUrl:
          'https://images.unsplash.com/photo-1606755962765-5315f7c2c32b?auto=format&fit=crop&w=800&q=80',
      containsAllergens: ['Gluten', 'Shellfish'],
      safeForAllergens: [],
    ),
    Dish(
      id: 'd39',
      restaurantId: 'r13',
      name: 'Dan Dan Noodles',
      price: 13.25,
      imageUrl:
          'https://images.unsplash.com/photo-1625944527002-6fc73e2059d4?auto=format&fit=crop&w=800&q=80',
      containsAllergens: ['Gluten', 'Sesame', 'Soy'],
      safeForAllergens: [],
    ),
  ],
),

// r14 – Katsu Burger (Georgetown / Capitol Hill – Japanese-American)
Restaurant(
  id: 'r14',
  name: 'Katsu Burger',
  description: 'Giant panko-fried burgers with Japanese flair.',
  imageUrl:
      'https://images.unsplash.com/photo-1550547660-d9450f859349?auto=format&fit=crop&w=800&q=80',
  rating: 4.4,
  dishes: [
    Dish(
      id: 'd40',
      restaurantId: 'r14',
      name: 'Tokyo Classic Katsu Burger',
      price: 14.99,
      imageUrl:
          'https://images.unsplash.com/photo-1528735602780-2552fd46c7af?auto=format&fit=crop&w=800&q=80',
      containsAllergens: ['Gluten', 'Eggs', 'Dairy'],
      safeForAllergens: [],
    ),
    Dish(
      id: 'd41',
      restaurantId: 'r14',
      name: 'Wabi Sabi Curry Burger',
      price: 15.99,
      imageUrl:
          'https://images.unsplash.com/photo-1541557435984-1c79685a082e?auto=format&fit=crop&w=800&q=80',
      containsAllergens: ['Gluten', 'Dairy', 'Eggs'],
      safeForAllergens: [],
    ),
    Dish(
      id: 'd42',
      restaurantId: 'r14',
      name: 'Furikake Fries',
      price: 6.50,
      imageUrl:
          'https://images.unsplash.com/photo-1568051243853-76df1bca44e1?auto=format&fit=crop&w=800&q=80',
      containsAllergens: ['Fish', 'Soy'],
      safeForAllergens: [],
    ),
  ],
),

// r15 – Mamnoon (Capitol Hill – Middle Eastern)
Restaurant(
  id: 'r15',
  name: 'Mamnoon',
  description: 'Modern Lebanese & Syrian cuisine with bold spices.',
  imageUrl:
      'https://images.unsplash.com/photo-1603133892874-5d816fdae3c8?auto=format&fit=crop&w=800&q=80',
  rating: 4.7,
  dishes: [
    Dish(
      id: 'd43',
      restaurantId: 'r15',
      name: 'Chicken Shawarma',
      price: 18.00,
      imageUrl:
          'https://images.unsplash.com/photo-1585903835302-9cb38a962f0a?auto=format&fit=crop&w=800&q=80',
      containsAllergens: ['Gluten', 'Sesame'],
      safeForAllergens: [],
    ),
    Dish(
      id: 'd44',
      restaurantId: 'r15',
      name: 'Mezze Trio',
      price: 14.50,
      imageUrl:
          'https://images.unsplash.com/photo-1617196034796-73dfa7b1fd56?auto=format&fit=crop&w=800&q=80',
      containsAllergens: ['Sesame'],
      safeForAllergens: ['Gluten-Free'],
    ),
    Dish(
      id: 'd45',
      restaurantId: 'r15',
      name: 'Lamb Kebabs',
      price: 19.75,
      imageUrl:
          'https://images.unsplash.com/photo-1555072956-7758afb20ea2?auto=format&fit=crop&w=800&q=80',
      containsAllergens: [],
      safeForAllergens: ['Gluten-Free', 'Dairy-Free'],
    ),
  ],
),

// r16 – Tacos Chukís (Capitol Hill / South Lake Union – Mexican)
Restaurant(
  id: 'r16',
  name: 'Tacos Chukís',
  description: 'Seattle-loved mini tacos and al pastor with pineapple.',
  imageUrl:
      'https://images.unsplash.com/photo-1617196035113-98aacbb44e0c?auto=format&fit=crop&w=800&q=80',
  rating: 4.6,
  dishes: [
    Dish(
      id: 'd46',
      restaurantId: 'r16',
      name: 'Taco al Pastor',
      price: 3.00,
      imageUrl:
          'https://images.unsplash.com/photo-1600340675641-699de8d5dc03?auto=format&fit=crop&w=800&q=80',
      containsAllergens: [],
      safeForAllergens: ['Dairy-Free', 'Nut-Free', 'Gluten-Free'],
    ),
    Dish(
      id: 'd47',
      restaurantId: 'r16',
      name: 'Taco de Pollo',
      price: 3.00,
      imageUrl:
          'https://images.unsplash.com/photo-1612197322631-3b07d8f4a45e?auto=format&fit=crop&w=800&q=80',
      containsAllergens: [],
      safeForAllergens: ['Dairy-Free', 'Nut-Free', 'Gluten-Free'],
    ),
    Dish(
      id: 'd48',
      restaurantId: 'r16',
      name: 'Chukis Especial',
      price: 4.50,
      imageUrl:
          'https://images.unsplash.com/photo-1608038509085-7bb9d5c0d48b?auto=format&fit=crop&w=800&q=80',
      containsAllergens: ['Dairy'],
      safeForAllergens: ['Nut-Free'],
    ),
  ],
),

// r17 – Seattle Fish Guys (Central District – Seafood)
Restaurant(
  id: 'r17',
  name: 'Seattle Fish Guys',
  description: 'Fresh seafood bowls and poke from a local fish market.',
  imageUrl:
      'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=800&q=80',
  rating: 4.8,
  dishes: [
    Dish(
      id: 'd49',
      restaurantId: 'r17',
      name: 'Salmon Poke Bowl',
      price: 16.99,
      imageUrl:
          'https://images.unsplash.com/photo-1577968897966-6781c2203f2b?auto=format&fit=crop&w=800&q=80',
      containsAllergens: ['Fish', 'Soy', 'Sesame'],
      safeForAllergens: [],
    ),
    Dish(
      id: 'd50',
      restaurantId: 'r17',
      name: 'Ahi Tuna Bowl',
      price: 17.99,
      imageUrl:
          'https://images.unsplash.com/photo-1553621042-f6e147245754?auto=format&fit=crop&w=800&q=80',
      containsAllergens: ['Fish', 'Soy', 'Sesame'],
      safeForAllergens: [],
    ),
    Dish(
      id: 'd51',
      restaurantId: 'r17',
      name: 'Seafood Chowder',
      price: 9.99,
      imageUrl:
          'https://images.unsplash.com/photo-1498654896293-37aacf113fd9?auto=format&fit=crop&w=800&q=80',
      containsAllergens: ['Dairy', 'Shellfish', 'Gluten'],
      safeForAllergens: [],
    ),
  ],
),

// r18 – Marination (South Lake Union – Hawaiian-Korean)
Restaurant(
  id: 'r18',
  name: 'Marination',
  description: 'Hawaiian-Korean fusion tacos, sliders, and bowls.',
  imageUrl:
      'https://images.unsplash.com/photo-1608038509085-7bb9d5c0d48b?auto=format&fit=crop&w=800&q=80',
  rating: 4.7,
  dishes: [
    Dish(
      id: 'd52',
      restaurantId: 'r18',
      name: 'Kalbi Beef Taco',
      price: 4.50,
      imageUrl:
          'https://images.unsplash.com/photo-1552332386-f8dd00dc2f85?auto=format&fit=crop&w=800&q=80',
      containsAllergens: ['Soy', 'Gluten'],
      safeForAllergens: [],
    ),
    Dish(
      id: 'd53',
      restaurantId: 'r18',
      name: 'Spam Sliders',
      price: 8.00,
      imageUrl:
          'https://images.unsplash.com/photo-1585238342027-147adcc54d5d?auto=format&fit=crop&w=800&q=80',
      containsAllergens: ['Gluten', 'Soy'],
      safeForAllergens: [],
    ),
    Dish(
      id: 'd54',
      restaurantId: 'r18',
      name: 'Kimchi Fried Rice',
      price: 12.00,
      imageUrl:
          'https://images.unsplash.com/photo-1541696432-82c6da8ce7bf?auto=format&fit=crop&w=800&q=80',
      containsAllergens: ['Eggs', 'Soy', 'Sesame'],
      safeForAllergens: [],
    ),
  ],
),

// r19 – Café Besalu (Ballard – French Bakery)
Restaurant(
  id: 'r19',
  name: 'Café Besalu',
  description: 'Legendary Ballard bakery known for perfect croissants.',
  imageUrl:
      'https://images.unsplash.com/photo-1600891963935-c9b6d7e6a6c9?auto=format&fit=crop&w=800&q=80',
  rating: 4.8,
  dishes: [
    Dish(
      id: 'd55',
      restaurantId: 'r19',
      name: 'Butter Croissant',
      price: 4.50,
      imageUrl:
          'https://images.unsplash.com/photo-1588196749597-9ff075ee6b5b?auto=format&fit=crop&w=800&q=80',
      containsAllergens: ['Gluten', 'Dairy'],
      safeForAllergens: [],
    ),
    Dish(
      id: 'd56',
      restaurantId: 'r19',
      name: 'Chocolate Croissant',
      price: 5.00,
      imageUrl:
          'https://images.unsplash.com/photo-1617196035323-20593d3536bc?auto=format&fit=crop&w=800&q=80',
      containsAllergens: ['Gluten', 'Dairy'],
      safeForAllergens: [],
    ),
    Dish(
      id: 'd57',
      restaurantId: 'r19',
      name: 'Quiche Lorraine',
      price: 6.75,
      imageUrl:
          'https://images.unsplash.com/photo-1601000921344-87d87f71cb96?auto=format&fit=crop&w=800&q=80',
      containsAllergens: ['Eggs', 'Dairy', 'Gluten'],
      safeForAllergens: [],
    ),
  ],
),

// r20 – Tian Fu (Bellevue – Sichuan Chinese)
Restaurant(
  id: 'r20',
  name: 'Tian Fu',
  description: 'Authentic Sichuan cuisine with bold spices and heat.',
  imageUrl:
      'https://images.unsplash.com/photo-1504544750208-dc0358e63f7f?auto=format&fit=crop&w=800&q=80',
  rating: 4.4,
  dishes: [
    Dish(
      id: 'd58',
      restaurantId: 'r20',
      name: 'Mapo Tofu',
      price: 14.99,
      imageUrl:
          'https://images.unsplash.com/photo-1525755662778-989d0524087e?auto=format&fit=crop&w=800&q=80',
      containsAllergens: ['Soy', 'Sesame'],
      safeForAllergens: [],
    ),
    Dish(
      id: 'd59',
      restaurantId: 'r20',
      name: 'Chongqing Spicy Chicken',
      price: 16.99,
      imageUrl:
          'https://images.unsplash.com/photo-1504674900247-eca3a4b9b6b3?auto=format&fit=crop&w=800&q=80',
      containsAllergens: ['Soy'],
      safeForAllergens: ['Dairy-Free', 'Nut-Free'],
    ),
    Dish(
      id: 'd60',
      restaurantId: 'r20',
      name: 'Dan Dan Noodles',
      price: 13.99,
      imageUrl:
          'https://images.unsplash.com/photo-1625944527002-6fc73e2059d4?auto=format&fit=crop&w=800&q=80',
      containsAllergens: ['Gluten', 'Sesame', 'Soy'],
      safeForAllergens: [],
    ),
  ],
),

];
