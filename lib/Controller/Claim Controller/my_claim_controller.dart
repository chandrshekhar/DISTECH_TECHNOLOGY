import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Controller/Timer%20Controller/timer_controller.dart';
import 'package:distech_technology/Features/Claim/Model/my-claim_ticket_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/date_time_format.dart';

class MyClaimController extends GetxController {
  RxString dateFormat = ''.obs;
  RxInt limit = 50.obs;
  var toDates = ''.obs;
  var fromDates = ''.obs;
  RxList<ClaimsData> claimsDataList = <ClaimsData>[].obs;
  RxBool isClaimingDataLoading = false.obs;
  Rx<MyClaimTicketModel> myClaimTicketModel = MyClaimTicketModel().obs;
  final myClaimSearcController = TextEditingController().obs;
  ApiProvider apiProvider = ApiProvider();

  final timerController = Get.put(TimerController());

  getMyClaim() async {
    isClaimingDataLoading(true);
    Map<String, dynamic> reqModel = {
      "fromDate": fromDates.value,
      "limit": limit.value,
      "offset": 0,
      "search": "",
      "status": "",
      "toDate": toDates.value,
    
    };
    myClaimTicketModel.value = await apiProvider.getMyClaims(reqModel);
    claimsDataList.value = myClaimTicketModel.value.claimsData ?? [];
    isClaimingDataLoading(false);
  }

  //void selectDate() {}
  DateTime selectedDate = DateTime.now();

  Future<void> selectDate(BuildContext context) async {
    // final DateTime? picked = await showDatePicker(
    //   context: context,
    //   initialDate: selectedDate,
    //   firstDate: DateTime(2015, 8),
    //   lastDate: DateTime(3000, 8),
    // );
    final picked = await showDateRangePicker(
      context: context,
      saveText: "Select",
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              // primary: MyColors.primary,
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            //.dialogBackgroundColor:Colors.blue[900],
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      var formatedDate =
          formatDate(date: picked.start, formatType: "yyyy-MM-dd");
      var toDate = formatDate(date: picked.end, formatType: "yyyy-MM-dd");
      dateFormat.value = formatedDate;
      toDates.value = toDate;
      fromDates.value = formatedDate;
      getMyClaim();
    }
  }

  List selectDropDownLimit = [10, 25, 50, 100, 500];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getMyClaim();
  }
}
