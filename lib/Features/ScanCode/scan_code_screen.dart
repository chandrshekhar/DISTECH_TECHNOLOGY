import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Widgets/full_button.dart';
import 'package:flutter/foundation.dart';
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
    try {
      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);

    apiProvider.verifyTicket(barcodeScanRes.trim()).then((value) {
        print(value);
        if (value['type'] != null) {}
        if (value['valid'] == true && value['type'] == "Ticket") {
          setState(() {
            scannedTicket = const Text(
              "Valid Ticket",
              style: TextStyle(fontSize: 18, color: Colors.green),
            );
            barcodeValue = barcodeScanRes;
          });
        } else {
          setState(() {
            scannedTicket = const Text(
              "Invalid Ticket or Bar Code",
              style: TextStyle(fontSize: 18, color: Colors.red),
            );
            barcodeValue = barcodeScanRes;
          });
        }
      });
    } on PlatformException {
      if (kDebugMode) {
        print("Platform  Exception");
      }
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
