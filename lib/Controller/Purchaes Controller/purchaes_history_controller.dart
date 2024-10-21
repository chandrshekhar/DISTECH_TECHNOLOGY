import 'dart:developer';

import 'package:distech_technology/Api/api_client.dart';
import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Api/urls.dart';
import 'package:distech_technology/Controller/Timer%20Controller/timer_controller.dart';
import 'package:distech_technology/Features/PurchaseHistory/Model/purchase_history_details_model.dart';
import 'package:distech_technology/Features/PurchaseHistory/Model/purchase_hostory_model.dart';
import 'package:distech_technology/Utils/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PurchaseController extends GetxController {
  final apiClient = ApiClient();

  RxList<Purchases> puchaseList = <Purchases>[].obs;
  RxList<Tickets> purchaseHistoryDetailsList = <Tickets>[].obs;
  RxBool isPurchaseDetailsLoading = false.obs;
  RxBool isPurchaLoading = false.obs;
  ApiProvider apiProvider = ApiProvider();
  RxInt limit = 100.obs;
  RxInt purDetLimit = 40.obs;
  RxInt countPurchaesTickets = 0.obs;
  final timerController = Get.put(TimerController());
  final dateEditngController = TextEditingController(
          text: formatDate(date: DateTime.now(), formatType: "dd-MM-yyyy"))
      .obs;

  RxString searchText = ''.obs;

  setSearchText(String val) {
    searchText.value = val;
  }

  getAllPurchaesTicket() async {
    log("value--> ${dateEditngController.value.text}");
    Map<String, dynamic> reqModel = {
      "drawSlotId": timerController.slotId.value,
      "offset": 0,
      "limit": limit.value,
      "date": formateDateyyyyMMdd(dateEditngController.value.text),
      "search": searchText.value
    };
    isPurchaLoading(true);
    log(reqModel.toString());
    var res = await apiProvider.getAllPurcHistoryTicket(reqModel);
    if (res.errorMsg == null) {
      if (res.purchases != null && res.purchases!.isNotEmpty) {
        isPurchaLoading(false);
        puchaseList.value = res.purchases!;
        countPurchaesTickets.value = res.totalQuantity ?? 0;
      } else {
        countPurchaesTickets.value = 0;
        puchaseList.clear();
        isPurchaLoading(false);
      }
    } else {
      Get.snackbar("Error", res.errorMsg.toString());
      isPurchaLoading(false);
    }

    isPurchaLoading(false);
  }

  getAllPurchaesTicketDetails(
      {String? search, int? semNumber, String? orderID}) async {
    Map<String, dynamic> reqModel = {
      "drawSlotId": timerController.slotId.value,
      "orderId": orderID,
      "offset": 0,
      "limit": purDetLimit.value,
      "date": formateDateyyyyMMdd(dateEditngController.value.text),
    };

    isPurchaseDetailsLoading(true);
    // var res = await apiProvider.getAllPurcHistoryTicketDetails(reqModel);

    var res = await apiClient.postRequest(
        endPoint: EndPoints.getAllPurchaseDetails,
        reqModel: reqModel,
        fromJson: (f) => PurchaseHistoryTicketDetailsModel.fromJson(f));

    if (res.data != null && res.data!.tickets!.isNotEmpty) {
      isPurchaseDetailsLoading(false);
      purchaseHistoryDetailsList.value = res.data!.tickets!;
    } else {
      isPurchaseDetailsLoading(false);
      purchaseHistoryDetailsList.value = [];
    }

    isPurchaseDetailsLoading(false);
  }
}
