import 'package:flutter/material.dart';
import 'package:dishcovery/db/allergen_database.dart';

class EditAllergensPage extends StatefulWidget {

  // Database we will store user allergens (required to run this view)
  final AllergenDatabase db;

  const EditAllergensPage({
    super.key,
    required this.db,
  });

  @override
  State<EditAllergensPage> createState() => _EditAllergensPageState();
}

class _EditAllergensPageState extends State<EditAllergensPage> {

  // Options to be displayed to the user
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

  final Set<String> _selected = {};
  bool _loading = true;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  // Makes sure our allergens load correctly
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

  // Makes sure our allergens save
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

  // Builds the widget
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
                        // Adds the value to our selected table if 
                        // user taps on the checkbox
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
