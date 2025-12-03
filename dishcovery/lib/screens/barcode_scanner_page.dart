import 'package:dishcovery/db/allergen_database.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'ingredient_result_page.dart';

class BarcodeScannerPage extends StatefulWidget {
  final AllergenDatabase db;

  const BarcodeScannerPage({super.key, required this.db});

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  bool _scanned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan a product')),
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
