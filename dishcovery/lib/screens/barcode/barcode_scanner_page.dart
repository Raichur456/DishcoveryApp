import 'package:dishcovery/db/allergen_database.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'ingredient_result_page.dart';

// The BarcodeScannerPage class displays a barcode scanner and navigates to ingredient results
class BarcodeScannerPage extends StatefulWidget {
  // database used to check allergens for scanned products
  final AllergenDatabase db;

  // Behavior: constructs the barcode scanner page widget.
  const BarcodeScannerPage({super.key, required this.db});

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

// The _BarcodeScannerPageState class manages the state of the BarcodeScannerPage
class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  // true if a barcode has been scanned and result is being shown
  bool _scanned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Scan a product'),
      ),
      body: MobileScanner(
        onDetect: (capture) {
          if (_scanned) return;
          final barcode = capture.barcodes.first.rawValue;
          if (barcode == null) return;
          setState(() => _scanned = true);
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
