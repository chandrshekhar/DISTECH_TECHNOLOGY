import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Features/ReturnedTickets/model/returned_ticket_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetMyReturnController extends GetxController {
  RxInt returnCount = 0.obs;
  RxList<AllReturnedTickets> returnTicketsList = <AllReturnedTickets>[].obs;
  RxBool isReturnTicketLoading = false.obs;
  RxBool isTicketValidating = false.obs;
  ApiProvider apiProvider = ApiProvider();

  RxList<Map> validateTicketsList = <Map>[].obs;

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

  void removeValidateReturnTicket(int index) {
    validateTicketsList.removeAt(index);
  }

  validateReturnTicket(String userId, String date) async {
    isTicketValidating(true);
    Map<String, dynamic> reqModel = {
      "userId": userId,
      "date": date,
      "fromLetter": fromLetterController.value.text.toString().trim(),
      "toLetter": toLetterController.value.text.toString().trim(),
      "fromNumber": fromNumberController.value.text.toString().trim(),
      "toNumber": toNumberController.value.text.toString().trim()
    };
    clearText();
    isTicketValidating(false);
    var res = await apiProvider.varidateReturnTicket(reqModel);
    if (res['success']) {
      validateTicketsList.add(reqModel);
      print("validate--> ${res['success']}");
    } else {
      print("validate--> ${res['success']}");
    }
  }
}
