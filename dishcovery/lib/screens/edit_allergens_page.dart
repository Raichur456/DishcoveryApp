import 'package:flutter/material.dart';
import '../db/allergen_database.dart';

// The EditAllergensPage class allows users to select and save their allergens in the database
class EditAllergensPage extends StatefulWidget {
  // database used to store user allergens
  final AllergenDatabase db;

  // Behavior: constructs the edit allergens page widget
  const EditAllergensPage({super.key, required this.db});

  @override
  State<EditAllergensPage> createState() => _EditAllergensPageState();
}


/// Private state class for EditAllergensPage.
///
/// Handles loading and saving of user allergen selections, manages UI state for loading and saving,
/// and updates the database when the user changes their selections.
class _EditAllergensPageState extends State<EditAllergensPage> {
  // List of allergen options to display as checkboxes.
  static const List<String> _options = [
    'milk', 'egg', 'fish', 'shellfish', 'tree nut', 'peanut', 'wheat', 'gluten', 'soy', 'sesame',
  ];

  // Set of currently selected allergens.
  final Set<String> _selected = {};
  // True if allergens are loading from the database.
  bool _loading = true;
  // True if allergens are being saved to the database.
  bool _saving = false;

  // Loads the user's allergens from the database when the widget is initialized.
  @override
  void initState() {
    super.initState();
    _load(); // Begin loading allergens
  }

  // Loads allergens from the database and updates the state.
  Future<void> _load() async {
    try {
      final saved = await widget.db.getAllergens(); // Fetch saved allergens
      if (!mounted) return;
      setState(() {
        _selected..clear()..addAll(saved); // Update selected set
        _loading = false; // Done loading
      });
    } catch (e, st) {
      debugPrint('Error loading allergens: $e\n$st'); // Log error
      if (!mounted) return;
      setState(() {
        _loading = false; // Done loading even if error
      });
    }
  }

  // Saves selected allergens to the database and shows a confirmation snackbar.
  Future<void> _save() async {
    setState(() => _saving = true); // Indicate saving in progress
    await widget.db.setAllergens(_selected.toList()); // Save to database
    if (!mounted) return;
    setState(() => _saving = false); // Done saving
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Allergens saved'),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Show loading indicator while allergens are being loaded
    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Edit allergens')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    // Main scaffold for editing allergens
    return Scaffold(
      appBar: AppBar(title: const Text('Edit allergens')),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Select any allergens you want Dishcovery to avoid.',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            child: ListView(
              children: _options.map((a) {
                final checked = _selected.contains(a); // Is this allergen selected?
                return CheckboxListTile(
                  title: Text(a),
                  value: checked,
                  onChanged: (value) {
                    setState(() {
                      if (value == true) {
                        _selected.add(a); // Add allergen to selection
                      } else {
                        _selected.remove(a); // Remove allergen from selection
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saving ? null : _save, // Disable button if saving
                child: _saving
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2), // Show spinner if saving
                      )
                    : const Text('Save'), // Otherwise show Save text
              ),
            ),
          ),
        ],
      ),
    );
  }
}
