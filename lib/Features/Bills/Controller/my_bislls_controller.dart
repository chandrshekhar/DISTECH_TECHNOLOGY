import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Controller/Profile%20Controller/profile_controller.dart';
import 'package:distech_technology/Features/Bills/Models/my_bills_model.dart';
import 'package:distech_technology/Utils/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyBillsController extends GetxController {
  RxString fromDateController = ''.obs;
  RxString toDateController = ''.obs;
  RxBool isBillLoading = false.obs;
  Rx<String> startDate =
      formatDate(date: DateTime.now(), formatType: "yyyy-MM-dd").obs;
  Rx<String> endDate =
      formatDate(date: DateTime.now(), formatType: "yyyy-MM-dd").obs;
  final textEditController = TextEditingController().obs;
  // Rx<MyBillModel> myBillModel = MyBillModel().obs;

  RxList<Bills> billList = <Bills>[].obs;

  ApiProvider apiProvider = ApiProvider();

  final profileController = Get.put(ProfileController());

  getMyBills() async {
    isBillLoading(true);
    Map<String, dynamic> reqModel = {
      "fromDate": startDate.value,
      "toDate": endDate.value,
      "stockistId": profileController.userProfileModel.value.user?.sId,
      "limit": 100,
      "offset": 0,
    };
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
      startDate.value =
          formatDate(date: picked.start, formatType: "yyyy-MM-dd");
      endDate.value = formatDate(date: picked.end, formatType: "yyyy-MM-dd");
      await getMyBills();
      return "$startDate - $endDate";
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
