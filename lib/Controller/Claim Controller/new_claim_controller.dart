import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Features/Claim/Model/claim_from_ticket_model.dart';
import 'package:distech_technology/Features/Claim/Model/claim_to_tickets_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

import '../../Utils/date_time_format.dart';

class NewClaimController extends GetxController {
  RxString dateFormat = ''.obs;
  RxString fromTicketScanValue = ''.obs;
  RxString toTicketScanValue = ''.obs;
  RxBool fromTicketScaning = false.obs;
  RxBool toTicketScaing = false.obs;
  RxString userName = ''.obs;
  RxString fullName = ''.obs;
  ApiProvider apiProvider = ApiProvider();
  Rx<ClaimFromTicketModel> claimFromTicketModel = ClaimFromTicketModel().obs;
  Rx<ClaimToTicketModel> claimToTicketModel = ClaimToTicketModel().obs;

  void scanBarCode(bool fromTicket) async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.BARCODE);

    if (fromTicket) {
      claimFromTicketModel.value =
          await apiProvider.verifyFromTicket(barcodeScanRes, dateFormat.value);
      fromTicketScanValue.value =
          claimFromTicketModel.value.ticket!.ticketId ?? "";
    } else {
      claimToTicketModel.value =
          await apiProvider.verifyToTicket(barcodeScanRes, dateFormat.value);
      toTicketScanValue.value = claimToTicketModel.value.ticket!.ticketId ?? "";
    }
  }

  void getMyCnf() async {
    var data = await apiProvider.getMyCnf();
    if (data['success'] == true) {
      fullName.value = data['cnfStockist']['fullName'];
      userName.value = data['userName'];
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
      dateFormat.value = formatedDate;
    }
  }
}
