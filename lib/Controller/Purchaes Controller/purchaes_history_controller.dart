import 'dart:developer';

import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Controller/Timer%20Controller/timer_controller.dart';
import 'package:distech_technology/Features/PurchaseHistory/Model/purchase_history_details_model.dart';
import 'package:distech_technology/Features/PurchaseHistory/Model/purchase_hostory_model.dart';
import 'package:distech_technology/Utils/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PurchaseController extends GetxController {
  RxList<Purchases> puchaseList = <Purchases>[].obs;
  RxList<Tickets> purchaseHistoryDetailsList = <Tickets>[].obs;
  RxBool isPurchaseDetailsLoading = false.obs;
  RxBool isPurchaLoading = false.obs;
  ApiProvider apiProvider = ApiProvider();
  RxInt limit = 100.obs;
  RxInt purDetLimit = 40.obs;
  RxInt countPurchaesTickets = 0.obs;
  final timerController = Get.put(TimerController());
  var dateEditngController = TextEditingController().obs;
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
      "orderId": orderID,
      "offset": 0,
      "limit": purDetLimit.value,
    };

    isPurchaseDetailsLoading(true);
    var res = await apiProvider.getAllPurcHistoryTicketDetails(reqModel);

    if (res.tickets!.isNotEmpty) {
      isPurchaseDetailsLoading(false);
      purchaseHistoryDetailsList.value = res.tickets!;
    } else {
      isPurchaseDetailsLoading(false);
      purchaseHistoryDetailsList.value = [];
    }

    isPurchaseDetailsLoading(false);
  }

  @override
  void onReady() {
    super.onReady();
    getAllPurchaesTicket();
  }

  // Open date picker dialog and select date from calender view
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(3000, 8),
    );
    if (picked != null) {
      dateEditngController.value.text = formateDateddMMyyyy(picked);
      getAllPurchaesTicket();
    }
  }
}
