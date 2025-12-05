import 'package:flutter/material.dart';
import '../../db/allergen_database.dart';

// The EditAllergensPage class allows users to select and save their allergens in the database
class EditAllergensPage extends StatefulWidget {
  // database used to store user allergens
  final AllergenDatabase db;

  // Behavior: constructs the edit allergens page widget
  const EditAllergensPage({super.key, required this.db});

  @override
  State<EditAllergensPage> createState() => _EditAllergensPageState();
}

// The _EditAllergensPageState class manages the state of the EditAllergensPage
class _EditAllergensPageState extends State<EditAllergensPage> {
  // list of allergen options to display
  static const List<String> _options = [
    'milk',
    'egg',
    'fish',
    'shellfish',
    'tree nut',
    'peanut',
    'wheat',
    'gluten',
    'soy',
    'sesame',
  ];

  // set of selected allergens.
  final Set<String> _selected = {};
  // true if allergens are loading from the database.
  bool _loading = true;
  // true if allergens are being saved.
  bool _saving = false;

  // Behavior: loads the user's allergens from the database on init
  @override
  void initState() {
    super.initState();
    _load();
  }

  // Behavior: loads allergens from the database and updates state
  Future<void> _load() async {
    try {
      final saved = await widget.db.getAllergens();
      if (!mounted) return;
      setState(() {
        _selected
          ..clear()
          ..addAll(saved);
        _loading = false;
      });
    } catch (e, st) {
      debugPrint('Error loading allergens: $e\n$st');
      if (!mounted) return;
      setState(() {
        _loading = false;
      });
    }
  }

  // Behavior: saves selected allergens to the database and shows a confirmation
  Future<void> _save() async {
    setState(() => _saving = true);
    await widget.db.setAllergens(_selected.toList());
    if (!mounted) return;
    setState(() => _saving = false);
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
    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Edit allergens')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

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
                final checked = _selected.contains(a);
                return CheckboxListTile(
                  title: Text(a),
                  value: checked,
                  onChanged: (value) {
                    setState(() {
                      if (value == true) {
                        _selected.add(a);
                      } else {
                        _selected.remove(a);
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
                onPressed: _saving ? null : _save,
                child: _saving
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Save'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
