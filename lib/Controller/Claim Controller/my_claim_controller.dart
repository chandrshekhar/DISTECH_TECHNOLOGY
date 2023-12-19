import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Features/Claim/Model/my-claim_ticket_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/date_time_format.dart';

class MyClaimController extends GetxController {
  RxString dateFormat = ''.obs;
  RxInt limit = 50.obs;
  RxList<ClaimsData> claimsDataList = <ClaimsData>[].obs;
  RxBool isClaimingDataLoading = false.obs;
  Rx<MyClaimTicketModel> myClaimTicketModel = MyClaimTicketModel().obs;
  final myClaimSearcController = TextEditingController().obs;
  ApiProvider apiProvider = ApiProvider();

  getMyClaim({
    double? limit,
  }) async {
    isClaimingDataLoading(true);
    Map<String, dynamic> reqModel = {
      "fromDate": null,
      "limit": limit,
      "offset": 0,
      "search": "",
      "status": "",
      "toDate": null
    };
    myClaimTicketModel.value = await apiProvider.getMyClaims(reqModel);
    claimsDataList.value = myClaimTicketModel.value.claimsData ?? [];
    isClaimingDataLoading(false);
  }

  //void selectDate() {}
  DateTime selectedDate = DateTime.now();
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(3000, 8),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      var formatedDate = formatDate(date: picked, formatType: "yyyy-MM-dd");
      dateFormat.value = formatedDate;
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
