import 'dart:developer';

import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Controller/Timer%20Controller/timer_controller.dart';
import 'package:distech_technology/Utils/app_helper.dart';
import 'package:distech_technology/Utils/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Models/return_ticket_model.dart';

class SaleTicketsController extends GetxController {
  RxBool isScanningTicket = false.obs;
  RxBool addButtonEnable = false.obs;
  RxBool isTicketValidating = false.obs;
  final fromDateController = TextEditingController(
          text: formatDate(date: DateTime.now(), formatType: "yyyy-MM-dd"))
      .obs;
  final toDateController = TextEditingController(
          text: formatDate(date: DateTime.now(), formatType: "yyyy-MM-dd"))
      .obs;
  final fromLetterController = TextEditingController().obs;
  final toLetterController = TextEditingController().obs;
  final fromNumberController = TextEditingController().obs;
  final toNumberController = TextEditingController().obs;
  RxList<SuccessReturnTicketModel> successReturnTicketList =
      <SuccessReturnTicketModel>[].obs;

  RxBool ticketScannig = false.obs;
  RxString fromTicketBarcode = ''.obs;
  RxString toTicketbarcode = ''.obs;
  RxString fromTickets = ''.obs;
  RxString toTickets = ''.obs;

  final timerController = Get.put(TimerController());

  ApiProvider apiProvider = ApiProvider();
  void isScanningTicketsMethod(bool val) {
    isScanningTicket.value = val;
    fromTickets.value = "";
    toTickets.value = "";
  }

  void moveNextFieldChar() {
    toLetterController.value.text = fromLetterController.value.text[0];
  }

  void moveNumberNext() {
    toNumberController.value.text =
        fromNumberController.value.text.toString().substring(0, 3);
  }

  void buttonEnabled() {
    if (fromLetterController.value.text.length == 2 &&
        toLetterController.value.text.length == 2 &&
        fromNumberController.value.text.length == 5 &&
        toNumberController.value.text.length == 5) {
      addButtonEnable.value = true;
    } else {
      addButtonEnable.value = false;
    }
  }

  // check validation
  validateSalesTickets({
    required int fromNumber,
    required int toNumber,
    required String fromLetter1,
    required String fromLetter2,
    required String toLetter1,
    required String toLetter2,
    required String slotId,
  }) async {
    isTicketValidating(true);

    int fromLetter = fromLetter1.codeUnitAt(0) + fromLetter2.codeUnitAt(0);
    int toLetter = toLetter1.codeUnitAt(0) + toLetter2.codeUnitAt(0);

    print("from Numbe--> $fromNumber");
    print("to Numbe--> $fromNumber");

    if (fromNumber < 00000 || toNumber > 99999 || fromNumber > 99999) {
      Get.snackbar("Error", "Invalid Number", backgroundColor: Colors.red);
      isTicketValidating(false);
    } else if (fromNumber > toNumber) {
      Get.snackbar("Error", "From number should be less than to number",
          backgroundColor: Colors.red);
      isTicketValidating(false);
    } else if (fromLetter > toLetter) {
      Get.snackbar("Error", "From letter should be less than to letter",
          backgroundColor: Colors.red);
      isTicketValidating(false);
    } else {
      Map<String, dynamic> reqModel = {
        "drawSlotId": slotId,
        "fromDate": fromDateController.value.text,
        "toDate": toDateController.value.text,
        "fromLetter": fromLetter1 + fromLetter2,
        "toLetter": toLetter1 + toLetter2,
        "fromNumber": fromNumber.toString().padLeft(5, '0'),
        "toNumber": toNumber.toString().padLeft(5, '0'),
        "stockistRole": "retailer"
      };

      var res = await apiProvider.validateSaleTicket(reqModel);
      if (res['success']) {
        isTicketValidating(false);

        if (res['successList'].length > 0) {
          Get.snackbar("Ticket", res['successList'][0]['message'],
              backgroundColor: Colors.green);
          // res['successList'];
          fromTickets.value = "";
          toTickets.value = "";
          successReturnTicketList.addAll((res['successList'] as List)
              .map((val) => SuccessReturnTicketModel.fromJson(val))
              .toList());
          for (var e in successReturnTicketList) {
            SuccessReturnTicketModel(
                date: e.date,
                fromLetter: e.fromLetter,
                toLetter: e.toLetter,
                fromNumber: e.fromNumber,
                toNumber: e.toNumber,
                success: e.success,
                message: e.message,
                count: e.count);
          }

          clearText();
          isTicketValidating(false);
          buttonEnabled();
        } else {
          // log("Fail--> ${res['failedList'].toString()}");
          Get.snackbar("Error", res['failedList'][0]['message'],
              backgroundColor: Colors.red);
        }

        log(res.toString());
      } else {
        isTicketValidating(false);
        Get.snackbar("Error", res['error'], backgroundColor: Colors.red);
      }
    }
  }





  void removeValidateReturnTicket(int index) {
    successReturnTicketList.removeAt(index);
  }

  void clearText() {
    fromLetterController.value.clear();
    toLetterController.value.clear();
    fromNumberController.value.clear();
    toNumberController.value.clear();
  }

  // verify scaned ticket
  void scanBarCode(bool fromTicket) async {
    String? barcodeScanRes = await AppHelper().scanBarCode();
    print("bar code eresnsuydg ${barcodeScanRes.toString()}");

    if (fromTicket) {
      ticketScannig(true);
      fromTicketBarcode.value = barcodeScanRes ?? "";
      var res = await apiProvider.verifyTicket(barcodeScanRes!,
          fromDateController.value.text, timerController.slotId.value);
      if (res['success']) {
        fromTickets.value = res['ticket']['ticketId'];
      } else {
        Get.snackbar("Error", "Invalid Ticket", backgroundColor: Colors.red);
      }
      log("From ticket res--->$res ");
    } else {
      ticketScannig(true);
      toTicketbarcode.value = barcodeScanRes ?? "";
      var res = await apiProvider.verifyTicket(barcodeScanRes ?? "",
          toDateController.value.text, timerController.slotId.value);
      if (res['success']) {
        toTickets.value = res['ticket']['ticketId'];
      } else {
        Get.snackbar("Error", "Invalid Ticket", backgroundColor: Colors.red);
      }
      log("to ticket res--->$res ");
    }
  }
}
