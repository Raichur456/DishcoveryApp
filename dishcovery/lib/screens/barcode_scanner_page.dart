import 'package:dishcovery/db/allergen_database.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'ingredient_result_page.dart';

/// This class builds the barcode scanner page as a stateful widget. 
class BarcodeScannerPage extends StatefulWidget {
  final AllergenDatabase db;

  const BarcodeScannerPage({super.key, required this.db});

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  // 
  bool _scanned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Scan a product'),
      ),

      // Mobile scanner: almost a first-person view of what the phone is facing through 
      // its camera
      body: MobileScanner(
        onDetect: (capture) {
          if (_scanned) return;

          final barcode = capture.barcodes.first.rawValue;
          if (barcode == null) return;

          // Sets state of scanner to be true
          setState(() => _scanned = true);

          // Pushes result of scanning the item, which would return information 
          // regarding what the dish consists of, and whether or not it is safe for the 
          // user to eat based on their selected allergens
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  IngredientResultPage(barcode: barcode, db: widget.db),
            ),
          ).then((_) {
            setState(() => _scanned = false);
          });
        },
      ),
    );
  }
}
