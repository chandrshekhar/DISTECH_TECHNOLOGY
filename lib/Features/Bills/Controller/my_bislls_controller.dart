import 'dart:developer';

import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Features/Profile/Profile%20Controller/profile_controller.dart';
import 'package:distech_technology/Features/Bills/Models/my_bills_model.dart';
import 'package:distech_technology/Utils/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyBillsController extends GetxController {
  RxString fromDateController = ''.obs;
  RxString toDateController = ''.obs;
  RxBool isBillLoading = false.obs;
  Rx<DateTime> startDate = DateTime.now().obs;
  Rx<DateTime> endDate = DateTime.now().obs;
  final textEditController = TextEditingController(
          text:
              "${formatDate(date: DateTime.now(), formatType: "dd-MM-yyyy")} - ${formatDate(date: DateTime.now(), formatType: "dd-MM-yyyy")}")
      .obs;

  RxList<Bills> billList = <Bills>[].obs;

  ApiProvider apiProvider = ApiProvider();

  final profileController = Get.put(ProfileController());

  getMyBills() async {
    isBillLoading(true);
    Map<String, dynamic> reqModel = {
      "fromDate": formatDate(date: startDate.value, formatType: "yyyy-MM-dd"),
      "toDate": formatDate(date: endDate.value, formatType: "yyyy-MM-dd"),
      "stockistId": profileController.userProfileModel.value.user?.sId,
      "limit": 100,
      "offset": 0,
    };
    log("getMybill->  $reqModel");
    var res = await apiProvider.getMyBills(reqModel);
    if (res.success == true && res.bills!.isNotEmpty) {
      billList.clear();
      billList.value = res.bills ?? [];
      isBillLoading(false);
    } else {
      billList.clear();
    }

    isBillLoading(false);
  }

  Future<String?> selectDate(BuildContext context) async {
    final picked = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2020),
        lastDate: DateTime(2025),
        initialDateRange:
            DateTimeRange(start: DateTime.now(), end: DateTime.now()));
    if (picked != null) {
      startDate.value = picked.start;
      endDate.value = picked.end;
      await getMyBills();
      return "${formatDate(date: startDate.value, formatType: "dd-MM-yyyy")} - ${formatDate(date: endDate.value, formatType: "dd-MM-yyyy")}";
    } else {
      return null;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getMyBills();
  }
}
