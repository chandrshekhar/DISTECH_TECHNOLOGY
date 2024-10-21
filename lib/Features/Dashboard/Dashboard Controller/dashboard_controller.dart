import 'dart:developer';

import 'package:distech_technology/Api/api_client.dart';
import 'package:distech_technology/Api/urls.dart';
import 'package:distech_technology/Features/Vew%20Prizes/Model/get_my_dashboard.dart';
import 'package:distech_technology/Utils/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controller/Timer Controller/timer_controller.dart';

class DashboardController extends GetxController {
  final apiClient = ApiClient();
  RxBool isPopupShowing = false.obs;
  RxBool getMyDashboardLoadfing = false.obs;
  final timerController = Get.put(TimerController());
  Rx<GetMyDashboardModel> getModeldashBoard = GetMyDashboardModel().obs;

  final timeController = TextEditingController(
          text: formatDate(date: DateTime.now(), formatType: "dd-MM-yyyy"))
      .obs;

  Future<void> getMydashboard() async {
    getMyDashboardLoadfing(true);
    var reqModel = {
      "drawSlotId": timerController.slotId.value,
      "date": formateDateyyyyMMdd(timeController.value.text),
      "limit": 5,
    };
    var res = await apiClient.postRequest(
        endPoint: EndPoints.getMyDashboard,
        reqModel: reqModel,
        fromJson: (v) => GetMyDashboardModel.fromJson(v));

    log("response-->${res.data!.userTicketCounts}");

    if (res.data?.success == true) {
      getModeldashBoard.value = res.data!;
      getMyDashboardLoadfing(false);
    }
    getMyDashboardLoadfing(false);
  }
}
