import 'dart:developer';

import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Controller/Purchaes%20Controller/purchaes_history_controller.dart';
import 'package:distech_technology/Controller/Timer%20Controller/timer_controller.dart';
import 'package:distech_technology/Utils/date_time_format.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../../Features/ScanCode/Model/scan_ticket_model.dart';

class ScanBarcodeController extends GetxController {
  ApiProvider apiProvider = ApiProvider();

  Rx<ScanTicketModel> scanTickModel = ScanTicketModel().obs;
  RxBool isTicketScanning = false.obs;
  RxString barcodeValue = "NA".obs;
  RxString invalidString = ''.obs;
  RxString ticketId = ''.obs;
  RxString dateFormatValidateTicket = ''.obs;
  RxBool verifyTicketButton = false.obs;
  RxString select = "Please Scan".obs;
  final purchaseController = Get.put(PurchaseController());
  final timerController = Get.put(TimerController());

  final barcodeController = TextEditingController().obs;
  final dateEditingController =
      TextEditingController(text: formateDateddMMyyyy(DateTime.now())).obs;

  setverifyTicketButton(String val) {
    if (val.isNotEmpty) {
      verifyTicketButton.value = true;
    } else {
      verifyTicketButton.value = false;
    }
  }

  //void selectDate() {}
  DateTime selectedDate = DateTime.now();
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(3000, 8),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      var formatedDate = formatDate(date: picked, formatType: "yyyy-MM-dd");
      dateFormatValidateTicket.value = formatedDate;
      // purchaseController.getAllPurchaesTicket(dateTime: selectedDate);
      invalidString.value = "";
      // scanbarcodeController.barcodeValue.value = "NA";
      dateEditingController.value.text = formateDateddMMyyyy(selectedDate);
      barcodeController.value.clear();
    }
  }

  Future<void> verifyTicketById() async {
    scanTickModel.value = await apiProvider.verifyTicketbyID(
        ticketId: barcodeController.value.text.trim(),
        date: dateFormatValidateTicket.value,
        slotId: timerController.slotId.value);
    barcodeController.value.clear();
  }

  Future<void> scanBarcodeNormal() async {
    invalidString.value = "";
    barcodeValue.value = "NA";
    ticketId.value = "";

    try {
      isTicketScanning(true);
      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      barcodeValue.value = barcodeScanRes;
      var data = await apiProvider.verifyTicket(
          barcodeValue.value.toString().trim(),
          dateFormatValidateTicket.value,
          timerController.slotId.value);
      log("data--> $data");
      if (data['valid'] == true && data['success']) {
        ticketId.value = data["ticket"]["ticketId"];
        scanTickModel.value = await apiProvider.verifyTicketbyID(
            ticketId: ticketId.value,
            date: dateFormatValidateTicket.value,
            slotId: timerController.slotId.value);
      } else {
        invalidString.value = data['message'];
        scanTickModel.value = ScanTicketModel();
      }

      isTicketScanning(false);
    } on PlatformException {
      if (kDebugMode) {
        print("Platform  Exception");
      }
      isTicketScanning(false);
    }
  }

  // void callBarCode(String dateFormat) async {
  //   print(dateFormat);
  //   print("tickeid-> $ticketId");

  //   scanTickModel.value = ScanTicketModel();
  //   var res = await apiProvider.verifyTicketbyID(
  //       ticketId: ticketId.value, date: dateFormat);
  //   scanTickModel.value = res;
  // }
}

// model class for scan ticket response

