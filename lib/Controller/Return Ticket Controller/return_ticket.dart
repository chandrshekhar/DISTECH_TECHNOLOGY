import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Features/ReturnedTickets/model/returned_ticket_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Timer Controller/timer_controller.dart';

class GetMyReturnController extends GetxController {
  RxInt returnCount = 0.obs;
  RxList<AllReturnedTickets> returnTicketsList = <AllReturnedTickets>[].obs;
  RxBool isReturnTicketLoading = false.obs;
  RxBool isTicketValidating = false.obs;
  ApiProvider apiProvider = ApiProvider();
  RxList<Map> validateTicketsList = <Map>[].obs;

  RxBool addButtonEnable = false.obs;
  final TimerController timerController = Get.find();

  var searchController = TextEditingController().obs;
  var fromLetterController = TextEditingController().obs;
  var toLetterController = TextEditingController().obs;
  var fromNumberController = TextEditingController().obs;
  var toNumberController = TextEditingController().obs;
  getAllReturnTicket({String? dateTime}) async {
    Map<String, dynamic> reqModel = (dateTime == null || dateTime.isEmpty)
        ? {
            // "offset": 0,
            // "limit": 1000,
          }
        : {"date": dateTime};
    isReturnTicketLoading(true);
    var res = await apiProvider.getMyReturn(reqModel);
    if (res.allReturnedTickets != null) {
      isReturnTicketLoading(false);
      returnCount.value = res.remainingReturns!;
      returnTicketsList.value = res.allReturnedTickets!;
    } else {
      returnTicketsList.value = [];
      returnCount.value = 0;
      isReturnTicketLoading(false);
      Get.snackbar("Error", "Something went wrong");
    }
  }

  void clearText() {
    fromLetterController.value.clear();
    toLetterController.value.clear();
    fromNumberController.value.clear();
    toNumberController.value.clear();
  }

  // void textFieldEnableFunction() {
  //   if (returnCount.value == 0 &&
  //       timerController.countdown.value == "0:00:00") {
  //     returnTime.value = false;
  //   } else {
  //     returnTime.value = true;
  //   }
  // }

  void buttonEnabled() {
    if (fromLetterController.value.text.length == 2 &&
        toLetterController.value.text.length == 2 &&
        fromNumberController.value.text.length == 5 &&
        toNumberController.value.text.length == 5 &&
        returnCount.value != 0 &&
        timerController.countdown.value != "0:00:00") {
      addButtonEnable.value = true;
    } else {
      addButtonEnable.value = false;
    }
  }

  void removeValidateReturnTicket(int index) {
    validateTicketsList.removeAt(index);
  }

  validateReturnTicket(String userId, String date) async {
    isTicketValidating(true);
    int fromNumber = int.parse(fromNumberController.value.text);
    int toNumber = int.parse(toNumberController.value.text);
    String fromLetter1 = fromLetterController.value.text[0];
    String fromLetter2 = fromLetterController.value.text[1];
    String toLetter1 = toLetterController.value.text[0];
    String toLetter2 = toLetterController.value.text[1];
    int fromLetter = fromLetter1.codeUnitAt(0) + fromLetter2.codeUnitAt(0);
    int toLetter = toLetter1.codeUnitAt(0) + toLetter2.codeUnitAt(0);

    if (fromNumber < 00012 || toNumber > 99999 || fromNumber > 99999) {
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
        "userId": userId,
        "date": date,
        "fromLetter": fromLetterController.value.text.toString().trim(),
        "toLetter": toLetterController.value.text.toString().trim(),
        "fromNumber": fromNumberController.value.text.toString().trim(),
        "toNumber": toNumberController.value.text.toString().trim()
      };

      var res = await apiProvider.varidateReturnTicket(reqModel);
      if (res['success']) {
        validateTicketsList.add(reqModel);
        isTicketValidating(false);
        Get.snackbar("Ticket", res['message'], backgroundColor: Colors.green);
      } else {
        isTicketValidating(false);
        Get.snackbar("Error", res['error'], backgroundColor: Colors.red);
      }
      clearText();
    }
  }
}
