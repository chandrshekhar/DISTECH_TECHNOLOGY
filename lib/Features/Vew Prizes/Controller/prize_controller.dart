import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Controller/Timer%20Controller/timer_controller.dart';
import 'package:distech_technology/Features/Vew%20Prizes/Model/get_my_dashboard.dart';
import 'package:distech_technology/Utils/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrizesController extends GetxController {
  RxString formatedDate = ''.obs;
  DateTime selectedDate = DateTime.now();
  final timerController = TimerController();
  RxMap<String, dynamic> userTicketCounts = <String, dynamic>{}.obs;

  RxBool getMyDashboardLoadfing = false.obs;

  var getModeldashBoard = GetMyDashboardModel().obs;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(3000, 8),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      formatedDate.value = formatDate(date: picked, formatType: "yyyy-MM-dd");
      getMydashboard();

      print("date--> $formatedDate");
    }
  }

  getMydashboard() async {
    getMyDashboardLoadfing(true);
    var reqModel = {
      "date": formatedDate.value,
      "limit": 3,
      "drawSlotId": timerController.slotId.value
    };
    getModeldashBoard.value =
        await ApiProvider().getMyDashboardDetails(reqModel);
    if (getModeldashBoard.value.success == true) {
      getMyDashboardLoadfing(false);
    }
    getMyDashboardLoadfing(false);
  }

  @override
  void onInit() {
    getMydashboard();
    super.onInit();
  }
}
