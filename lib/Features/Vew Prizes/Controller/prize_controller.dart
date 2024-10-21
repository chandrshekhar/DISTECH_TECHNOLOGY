import 'dart:developer';

import 'package:distech_technology/Api/api_client.dart';
import 'package:distech_technology/Api/urls.dart';
import 'package:distech_technology/Controller/Timer%20Controller/timer_controller.dart';
import 'package:distech_technology/Features/Vew%20Prizes/Model/prize_model.dart';
import 'package:distech_technology/Features/Vew%20Prizes/Model/pwt_list_model.dart';
import 'package:distech_technology/Utils/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrizesController extends GetxController {
  final apiClient = ApiClient();

  RxString formatedDate =
      formatDate(date: DateTime.now(), formatType: "dd-MM-yyyy").obs;
  DateTime selectedDate = DateTime.now();
  final timerController = Get.put(TimerController());
  RxMap<String, dynamic> userTicketCounts = <String, dynamic>{}.obs;
  RxBool isPopupShowing = false.obs;
  RxBool getPrizeLoading = false.obs;
  var getPrizeModel = GetPrizeModel().obs;

  /// pwt
  RxBool isPwtLoading = false.obs;
  Rx<PwtListModel> getpwtList = PwtListModel().obs;
  final pwtDateController = TextEditingController(
          text: formatDate(date: DateTime.now(), formatType: "dd-MM-yyyy"))
      .obs;

  Future<void> selectDateForCheckPrizes(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(3000, 8),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      // formatedDate.value = formatDate(date: picked, formatType: "dd-MM-yyyy");
      pwtDateController.value.text = formateDateddMMyyyy(selectedDate);

      await getPrize();
    }
  }

  Future<void> getPrize() async {
    getPrizeLoading(true);
    Map<String, dynamic> reqModel = {
      "drawSlotId": timerController.slotId.value,
      "date": formatDate(date: selectedDate, formatType: "yyyy-MM-dd"),
    };
    log("getPrize --> $reqModel");
    // var res = await ApiProvider().getPrizeDetails(reqModel);
    var res = await apiClient.postRequest(
        endPoint: EndPoints.getPrize,
        reqModel: reqModel,
        fromJson: (d) => GetPrizeModel.fromJson(d));

    if (res.data?.success == true) {
      getPrizeModel.value = res.data!;
      getPrizeLoading(false);
    }
    getPrizeLoading(false);
  }

  Future<void> getPwtList(
      {required String pwtStatus, required DateTime date}) async {
    isPwtLoading(true);
    Map<String, dynamic> reqModel = {
      "date": formatDate(date: date, formatType: "yyyy-MM-dd"),
      "drawSlotId": timerController.slotId.value,
      "status":
          pwtStatus, // "Returned"  for unsold data // "Sold" for sold data
      "limit": 10,
      "offset": 0,
      "search": ""
    };
    log(reqModel.toString());
    // var res = await ApiProvider().getPwtList(reqModel);

    var res = await apiClient.postRequest(
        endPoint: EndPoints.myPwtSoldUnsoldData,
        reqModel: reqModel,
        fromJson: (d) => PwtListModel.fromJson(d));

    if (res.data?.success == true) {
      getpwtList.value = res.data!;
      isPwtLoading(false);
    }
    isPwtLoading(false);
  }

  @override
  void onInit() async {
    await getPrize();
    super.onInit();
  }
}
