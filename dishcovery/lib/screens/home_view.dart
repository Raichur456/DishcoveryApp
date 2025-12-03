import 'package:flutter/material.dart';
import '../config/mock_data.dart';
import '../config/irl_mock_data.dart';
import '../models/restaurant.dart';
// import '../services/yelp_service.dart';
import 'dish_view.dart';
import 'favorites_view.dart';
import 'settings_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;
  String _search = '';
  bool _sortAsc = true;

  bool _loading = true;
  String? _error;
  List<Restaurant> _restaurants = [];

  @override
  void initState() {
    super.initState();
    _loadRestaurants(); // initial load for Seattle
  }

  Future<void> _loadRestaurants({String term = ''}) async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final results = irlMockRestaurants;
      // await YelpService.searchRestaurantsInSeattle(
      //   term: term.trim(),
      // );
      setState(() {
        _restaurants = results;
        _loading = false;
      });
    } catch (e) {
      // Fallback: use mock data if live API fails
      setState(() {
        _restaurants = mockRestaurants;
        _loading = false;
        _error =
            'Could not load live Seattle restaurants. Showing sample data instead.';
      });
    }
  }

  Widget _buildHomeTab() {
    List<Restaurant> filtered = _restaurants
        .where((r) => r.name.toLowerCase().contains(_search.toLowerCase()))
        .toList();

    filtered.sort(
      (a, b) => _sortAsc ? a.name.compareTo(b.name) : b.name.compareTo(a.name),
    );

    if (_loading) {
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
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final Restaurant restaurant = filtered[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DishView(restaurant: restaurant),
                    ),
                  );
                },
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
                          restaurant.imageUrl,
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
                            Text(
                              restaurant.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              restaurant.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 12),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.amber,
                                ),
                                const SizedBox(width: 4),
                                Text(restaurant.rating.toStringAsFixed(1)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFavoritesTab() {
    return const FavoritesView();
  }

  Widget _buildSettingsTab() {
    return const SettingsView();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      _buildHomeTab(),
      _buildFavoritesTab(),
      _buildSettingsTab(),
    ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Dishcovery'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_horiz),
            onSelected: (value) {
              if (value == 'signout') {
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem<String>(value: 'signout', child: Text('Sign Out')),
            ],
          ),
        ],
      ),
      body: SafeArea(child: tabs[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
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
        ],
      ),
    );
  }
}
