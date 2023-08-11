import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Utils/date_time_format.dart';
import 'package:distech_technology/Widgets/full_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

import '../../Commons/app_colors.dart';
import '../../Commons/app_icons.dart';
import '../../Commons/app_sizes.dart';
import '../../Controller/Purchaes Controller/purchaes_history_controller.dart';

class ScanBarCodeScreen extends StatefulWidget {
  const ScanBarCodeScreen({super.key});

  @override
  State<ScanBarCodeScreen> createState() => _ScanBarCodeScreenState();
}

class _ScanBarCodeScreenState extends State<ScanBarCodeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    dateFormat = '';
    super.initState();
  }

  Map<dynamic, dynamic> tikcetDetails = {};
  Widget? scannedTicket;
  String barcodeValue = "NA";
  Future<void> scanBarcodeNormal() async {
    try {
      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      apiProvider.verifyTicket(barcodeScanRes.trim(), dateFormat).then((value) {
        if (value['type'] != null) {}
        if (value['valid'] == true && value['type'] == "Ticket") {
          setState(() {
            tikcetDetails = value;
            scannedTicket = const Text(
              "Valid Ticket",
              style: TextStyle(fontSize: 18, color: Colors.green),
            );
            barcodeValue = barcodeScanRes;
          });
        } else {
          setState(() {
             tikcetDetails={};
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

  final purchaesController = Get.put(PurchaseController());
  DateTime selectedDate = DateTime.now();
  String dateFormat = '';
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(3000, 8),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        var formatedDate = formatDate(date: picked, formatType: "yyyy-MM-dd");
        dateFormat = formatedDate;
        //purchaesController.getAllPurchaesTicket(dateTime: formatedDate);
      });
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Select Date", style: TextStyle(fontSize: 20)),
              InkWell(
                onTap: () {
                  _selectDate(context);
                },
                child: Container(
                  padding: EdgeInsets.all(AppSizes.kDefaultPadding / 1.5),
                  height: AppSizes.buttonHeight + 4,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(AppSizes.cardCornerRadius / 2),
                      border: Border.all(color: AppColors.bg)),
                  child: Image.asset(
                    AppIcons.calenderIcon,
                    width: 25,
                    height: 25,
                  ),
                ),
              ),
            ],
          ),
          tikcetDetails['ticket'] != null
              ? ListView(
                  shrinkWrap: true,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    _buildTicketDetails(context, "Ticket id",
                        tikcetDetails['ticket']['ticketId'] ?? ""),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildTicketDetails(context, "SEM",
                        tikcetDetails['ticket']['SEM'].toString()),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildTicketDetails(context, "barCode id",
                        tikcetDetails['ticket']['barCode'] ?? ""),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildTicketDetails(
                        context, "Date", tikcetDetails['ticket']['date'] ?? ""),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                )
              : const SizedBox(),
          const SizedBox(height: 15),
          scannedTicket ?? const Text(''),
          const Spacer(),
          dateFormat.toString().isNotEmpty
              ? FullButton(label: "Scan Barcode", onPressed: scanBarcodeNormal)
              : Text("Please select date first")
        ],
      ),
    );
  }

  Widget _buildTicketDetails(BuildContext context, String title, String value) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 20,
        ),
        Text(value),
      ],
    );
  }
}
