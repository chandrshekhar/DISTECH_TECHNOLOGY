import 'dart:developer';

import 'package:distech_technology/Api/api_provider.dart';
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

  ApiProvider apiProvider = ApiProvider();

  // RxMap reqModel = {
  //   "fromDate": "",
  //   "toDate": "",
  //   "fromLetter": "",
  //   "toLetter": "",
  //   "fromNumber": "",
  //   "toNumber": "",
  //   "stockistRole": "retailer"
  // }.obs;

  void isScanningTicketsMethod(bool val) {
    isScanningTicket.value = val;
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
  validateSalesTickets() async {
    isTicketValidating(true);
    int fromNumber = int.parse(fromNumberController.value.text);
    int toNumber = int.parse(toNumberController.value.text);
    String fromLetter1 = fromLetterController.value.text[0];
    String fromLetter2 = fromLetterController.value.text[1];
    String toLetter1 = toLetterController.value.text[0];
    String toLetter2 = toLetterController.value.text[1];
    int fromLetter = fromLetter1.codeUnitAt(0) + fromLetter2.codeUnitAt(0);
    int toLetter = toLetter1.codeUnitAt(0) + toLetter2.codeUnitAt(0);

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
        "fromDate": fromDateController.value.text,
        "toDate": toDateController.value.text,
        "fromLetter": fromLetterController.value.text.toString().trim(),
        "toLetter": toLetterController.value.text.toString().trim(),
        "fromNumber": fromNumberController.value.text.toString().trim(),
        "toNumber": toNumberController.value.text.toString().trim(),
        "stockistRole": "retailer"
      };

      var res = await apiProvider.validateSaleTicket(reqModel);
      if (res['success']) {
        isTicketValidating(false);
        log("data--> ${res.toString()}");
        if (res['successList'].length > 0) {
          Get.snackbar("Ticket", res['successList'][0]['message'],
              backgroundColor: Colors.green);
          // res['successList'];
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
}
