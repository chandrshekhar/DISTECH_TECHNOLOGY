import 'dart:developer';

import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Controller/Timer%20Controller/timer_controller.dart';
import 'package:distech_technology/Features/Vew%20Prizes/Model/get_my_dashboard.dart';
import 'package:distech_technology/Features/Vew%20Prizes/Model/prize_model.dart';
import 'package:distech_technology/Utils/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrizesController extends GetxController {
  RxString formatedDate = ''.obs;
  DateTime selectedDate = DateTime.now();
  final timerController = Get.put(TimerController());
  RxMap<String, dynamic> userTicketCounts = <String, dynamic>{}.obs;
  RxBool isPopupShowing = false.obs;

  RxBool getMyDashboardLoadfing = false.obs;
  RxBool getPrizeLoading = false.obs;

  var getModeldashBoard = GetMyDashboardModel().obs;
  var getPrizeModel = GetPrizeModel().obs;

  Future<void> selectDateForCheckPrizes(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(3000, 8),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      formatedDate.value = formatDate(date: picked, formatType: "yyyy-MM-dd");
      await getMydashboard();
    }
  }

  Future<void> getMydashboard() async {
    getMyDashboardLoadfing(true);
    var reqModel = {
      "date": formatedDate.value,
      "limit": 3,
      "drawSlotId": timerController.slotId.value
    };
    log(reqModel.toString());
    var res = await ApiProvider().getMyDashboardDetails(reqModel);
    if (res.success == true) {
      getModeldashBoard.value = res;

      await getPrize();
      getMyDashboardLoadfing(false);
    }
    getMyDashboardLoadfing(false);
  }

  Future<void> getPrize() async {
    getPrizeLoading(true);
    Map<String, dynamic> reqModel = {
      "date": formatedDate.value,
      "drawSlotId": timerController.slotId.value
    };
    log(reqModel.toString());
    var res = await ApiProvider().getPrizeDetails(reqModel);

    if (res.success == true) {
      getPrizeModel.value = res;
      getPrizeLoading(false);
    }
    getPrizeLoading(false);
  }

  @override
  void onInit() {
    getMydashboard();
    super.onInit();
  }
}
