import 'package:dishcovery/db/allergen_database.dart';
import 'package:flutter/material.dart';
import '../../services/firebase_auth_service.dart';
import '../../config/mock_data.dart';
import '../../config/irl_mock_data.dart';
import '../../models/restaurant.dart';
import '../../utils/favorites_manager.dart';
import '../home/dish_view.dart';
import '../favorites/favorites_view.dart';
import '../settings/settings_view.dart';
import '../barcode/barcode_scanner_page.dart';
import '../favorites/draggable_favorite_restaurant_card.dart';

// The Homeview class displays a tabbed interface for browsing restaurants, managing favorites,
// editing settings, and scanning barcodes. It handles navigation between tabs and loading restaurant
// data from mock/live sources
class HomeView extends StatefulWidget {
  // database used for user allergen and favorites persistence
  final AllergenDatabase db;

  // constructs the home view widget
  const HomeView({super.key, required this.db});

  @override
  State<HomeView> createState() => _HomeViewState();
}

// The _HomeViewState class manages the state of the HomeView
class _HomeViewState extends State<HomeView> {
  // index of the currently selected tab
  int _selectedIndex = 0;
  // current search term for filtering restaurants
  String _search = '';
  // true if sorting A-Z, false for Z-A
  bool _sortAsc = true;

  // true if restaurant data is loading
  bool _loading = true;
  // error message if restaurant loading fails
  String? _error;
  // list of restaurants to display
  List<Restaurant> _restaurants = [];

  @override
  void initState() {
    super.initState();
    _loadRestaurants();
  }

  // loads restaurants from mock/live data and initializes FavoritesManager
  // updates UI state for loading and error
  Future<void> _loadRestaurants({String term = ''}) async {
    setState(() {
      _loading = true;
      _error = null;
    });

    List<Restaurant> results;
    String? error;

    try {
      // attempts to load live Seattle restaurants (commented out for mock)
      // results = await YelpService.searchRestaurantsInSeattle(term: term.trim());
      results = irlMockRestaurants;
    } catch (e) {
      // uses mock data if live API fails
      results = mockRestaurants;
      error =
          'Could not load live Seattle restaurants. Showing sample data instead.';
    }

    // initializes FavoritesManager with restaurants and database
    await FavoritesManager.instance.init(
      db: widget.db,
      allRestaurants: results,
    );

    if (!mounted) return;

    setState(() {
      _restaurants = results;
      _error = error;
      _loading = false;
    });
  }

  // Behavior: builds the home tab UI for browsing and searching restaurants
  // Returns: the home tab widget
  Widget _buildHomeTab() {
    // filters restaurants by search term
    List<Restaurant> filtered = _restaurants
        .where((r) => r.name.toLowerCase().contains(_search.toLowerCase()))
        .toList();

    // sorts restaurants by name
    filtered.sort(
      (a, b) => _sortAsc ? a.name.compareTo(b.name) : b.name.compareTo(a.name),
    );

    if (_loading) {
      // shows loading indicator while fetching data
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search restaurants in Seattle',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (v) {
                    // update search term and reload restaurants
                    setState(() => _search = v);
                    _loadRestaurants(term: v);
                  },
                ),
              ),
              IconButton(
                icon: Icon(
                  _sortAsc ? Icons.arrow_upward : Icons.arrow_downward,
                ),
                tooltip: _sortAsc ? 'Sort A-Z' : 'Sort Z-A',
                onPressed: () {
                  // toggles sort order
                  setState(() => _sortAsc = !_sortAsc);
                },
              ),
            ],
          ),
        ),
        if (_error != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Text(_error!, style: const TextStyle(color: Colors.red)),
          ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final Restaurant restaurant = filtered[index];
              final bool isFav = FavoritesManager.instance.isFavorite(
                restaurant,
              );

              // card for each restaurant, supports drag-to-favorite and tap-to-view
              return DraggableFavoriteRestaurantCard(
                restaurant: restaurant,
                isFavorite: isFav,
                onToggleFavorite: () {
                  setState(() {
                    if (isFav) {
                      FavoritesManager.instance.remove(restaurant);
                    } else {
                      FavoritesManager.instance.add(restaurant);
                    }
                  });
                },
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DishView(restaurant: restaurant),
                    ),
                  ).then((_) {
                    // refresh state on return
                    setState(() {});
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }

  // Behavior: builds the favorites tab UI
  // Returns: the favorites tab widget
  Widget _buildFavoritesTab() {
    return const FavoritesView();
  }

  // Behavior: builds the settings tab UI
  // Returns: the settings tab widget
  Widget _buildSettingsTab() {
    return SettingsView(db: widget.db);
  }

  // Behavior: builds the barcode scanner tab UI
  // Returns: the barcode scanner tab widget
  Widget _buildBarcodeTab() {
    return BarcodeScannerPage(db: widget.db);
  }

  @override
  Widget build(BuildContext context) {
    // list of tab widgets for navigation
    List<Widget> tabs = [
      _buildHomeTab(),
      _buildFavoritesTab(),
      _buildSettingsTab(),
      _buildBarcodeTab(),
    ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Dishcovery'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sign out',
            onPressed: () async {
              // signs out from Firebase
              await FirebaseAuthService().signOut();

              // navigate to landing page
              if (!context.mounted) return;
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
          ),
        ],
      ),

      body: SafeArea(child: tabs[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scan',
          ),
        ],
      ),
    );
  }
}
