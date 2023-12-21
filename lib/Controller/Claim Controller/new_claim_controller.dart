import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Features/Claim/Model/claim_from_ticket_model.dart';
import 'package:distech_technology/Features/Claim/Model/claim_to_tickets_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

import '../../Commons/app_colors.dart';
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

  void scanBarCode(bool fromTicket, BuildContext context) async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    print("bar code eresnsuydg ${barcodeScanRes.toString()}");

    if (fromTicket) {
      fromTicketScaning(true);
      claimFromTicketModel.value =
          await apiProvider.verifyFromTicket(barcodeScanRes, dateFormat.value);
      if (claimFromTicketModel.value.success == false) {
        // ignore: use_build_context_synchronously
        AwesomeDialog(
                btnOkColor: AppColors.primary,
                context: context,
                dialogType: DialogType.error,
                animType: AnimType.bottomSlide,
                dismissOnTouchOutside: true,
                title: "Error!",
                btnOkOnPress: () {},
                desc:
                    "${claimFromTicketModel.value.message}\n${dateFormat.value}\n",
                btnOkText: "Ok",
                titleTextStyle: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                    fontSize: 16))
            .show();
        fromTicketScaning(false);
      } else {
        fromTicketScanValue.value =
            claimFromTicketModel.value.ticket!.ticketId ?? "";
        fromTicketScaning(false);
      }
    } else {
      toTicketScaing(true);
      claimToTicketModel.value =
          await apiProvider.verifyToTicket(barcodeScanRes, dateFormat.value);

      if (claimToTicketModel.value.success == false) {
        toTicketScaing(false);
        // ignore: use_build_context_synchronously
        AwesomeDialog(
                btnOkColor: AppColors.primary,
                context: context,
                dialogType: DialogType.error,
                animType: AnimType.bottomSlide,
                dismissOnTouchOutside: true,
                title: "Error!",
                btnOkOnPress: () {},
                desc:
                    "${claimToTicketModel.value.message}\n${dateFormat.value}\n",
                btnOkText: "Ok",
                titleTextStyle: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                    fontSize: 16))
            .show();
      } else {
        toTicketScanValue.value =
            claimToTicketModel.value.ticket!.ticketId ?? "";
        toTicketScaing(false);
      }
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
