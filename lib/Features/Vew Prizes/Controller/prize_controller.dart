import 'dart:developer';

import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Controller/Timer%20Controller/timer_controller.dart';
import 'package:distech_technology/Features/Vew%20Prizes/Model/get_my_dashboard.dart';
import 'package:distech_technology/Features/Vew%20Prizes/Model/prize_model.dart';
import 'package:distech_technology/Features/Vew%20Prizes/Model/pwt_list_model.dart';
import 'package:distech_technology/Utils/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrizesController extends GetxController {
  RxString formatedDate =
      formatDate(date: DateTime.now(), formatType: "dd-MM-yyyy").obs;
  DateTime selectedDate = DateTime.now();
  final timerController = Get.put(TimerController());
  RxMap<String, dynamic> userTicketCounts = <String, dynamic>{}.obs;
  RxBool isPopupShowing = false.obs;

  RxBool getMyDashboardLoadfing = false.obs;
  RxBool getPrizeLoading = false.obs;

  var getModeldashBoard = GetMyDashboardModel().obs;
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
      await getMydashboard();
      await getPrize();
    }
  }

  Future<void> getMydashboard() async {
    getMyDashboardLoadfing(true);
    var reqModel = {
      "drawSlotId": timerController.slotId.value,
      "date": formatedDate.value.isEmpty
          ? formatDate(date: DateTime.now(), formatType: "yyyy-MM-dd")
          : formatDate(date: selectedDate, formatType: "yyyy-MM-dd"),
      "limit": 5,
    };
    log("req pandey--> $reqModel");
    var res = await ApiProvider().getMyDashboardDetails(reqModel);
    // print("dashboard-- > ${res.toString()}");
    if (res.success == true) {
      getModeldashBoard.value = res;

      // await getPrize();
      getMyDashboardLoadfing(false);
    }
    getMyDashboardLoadfing(false);
  }

  Future<void> getPrize() async {
    getPrizeLoading(true);
    Map<String, dynamic> reqModel = {
      "drawSlotId": timerController.slotId.value,
      "date": formatDate(date: selectedDate, formatType: "yyyy-MM-dd"),
    };
    log("getPrize --> " + reqModel.toString());
    var res = await ApiProvider().getPrizeDetails(reqModel);

    if (res.success == true) {
      getPrizeModel.value = res;
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
    var res = await ApiProvider().getPwtList(reqModel);

    if (res.success == true) {
      getpwtList.value = res;
      isPwtLoading(false);
    }
    isPwtLoading(false);
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    await getPrize();
    super.onInit();
  }
}
