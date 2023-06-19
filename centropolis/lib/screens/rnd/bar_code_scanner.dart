import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BarCodeScannerScreen extends StatefulWidget {
  const BarCodeScannerScreen({super.key});

  @override
  State<StatefulWidget> createState() => _BarCodeScannerScreenState();
}

class _BarCodeScannerScreenState extends State<BarCodeScannerScreen> {
  String scanBarcode = 'Unknown';

  barCodeGenerator() {
    return BarcodeWidget(
      barcode: Barcode.qrCode(),
      data: 'Hello Flutter',
    );
  }

  Future<void> scanQR() async {
    String barcodeScanRes;

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'CANCEL', true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  scanQR();
                },
                child: const Text('SCAN QR CODE')),
            const SizedBox(height: 20,),
            Text('Scan result : $scanBarcode\n',
                style: const TextStyle(fontSize: 20))
          ],
        ),
      ),
    );
  }
}
