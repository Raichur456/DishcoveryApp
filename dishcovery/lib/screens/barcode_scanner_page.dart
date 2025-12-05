import 'package:dishcovery/db/allergen_database.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'ingredient_result_page.dart';

// The BarcodeScannerPage class displays a barcode scanner and navigates to ingredient results
class BarcodeScannerPage extends StatefulWidget {
  // database used to check allergens for scanned products
  final AllergenDatabase db;

  // Behavior: Constructs the barcode scanner page widget.
  const BarcodeScannerPage({super.key, required this.db});

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}


/// Private state class for BarcodeScannerPage.
///
/// Handles barcode scanning logic, manages scanned state to prevent duplicate scans,
/// and navigates to the ingredient result page when a barcode is detected.
class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  // True if a barcode has been scanned and result is being shown.
  bool _scanned = false;

  @override
  Widget build(BuildContext context) {
    // Main scaffold for the barcode scanner screen
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Scan a product'),
      ),
      body: MobileScanner(
        onDetect: (capture) {
          // Prevent duplicate scans while result is being shown
          if (_scanned) return;
          final barcode = capture.barcodes.first.rawValue;
          if (barcode == null) return; // Ignore if no barcode value
          setState(() => _scanned = true); // Mark as scanned
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => IngredientResultPage(barcode: barcode, db: widget.db),
            ),
          ).then((_) {
            // Reset scanned state when returning to scanner
            setState(() => _scanned = false);
          });
        },
      ),
    );
  }
}
