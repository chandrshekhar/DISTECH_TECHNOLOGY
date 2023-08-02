import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Widgets/full_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanBarCodeScreen extends StatefulWidget {
  const ScanBarCodeScreen({super.key});

  @override
  State<ScanBarCodeScreen> createState() => _ScanBarCodeScreenState();
}

class _ScanBarCodeScreenState extends State<ScanBarCodeScreen> {
  Widget? scannedTicket;
  String barcodeValue = "NA";
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes = "NA";
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      if (barcodeScanRes.isNotEmpty) {
        var resData = await apiProvider.verifyTicket(barcodeScanRes.trim());
        if (resData['success'] && resData['valid'] && resData['type']) {
          setState(() {
            scannedTicket = const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Valid Ticket",
                  style: TextStyle(fontSize: 18, color: Colors.green),
                ),
                Icon(Icons.check_circle_outline, color: Colors.green)
              ],
            );
            barcodeValue = barcodeScanRes;
          });
        } else {
          setState(() {
            scannedTicket = const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Invalid Ticket or Bar Code",
                  style: TextStyle(fontSize: 18, color: Colors.red),
                ),
                Icon(
                  Icons.close_outlined,
                  color: Colors.red,
                )
              ],
            );
            barcodeValue = barcodeScanRes;
          });
        }
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }

  ApiProvider apiProvider = ApiProvider();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Bar Code : $barcodeValue",
              style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 15),
          scannedTicket ?? const Text(''),
          const Spacer(),
          FullButton(label: "Scan Barcode", onPressed: scanBarcodeNormal)
        ],
      ),
    );
  }
}
