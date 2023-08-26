import 'dart:developer';
import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Features/SoldTicket/Models/sold_ticket_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class SoldTicketListController extends GetxController {
  RxList<Sales> soldTicketList = <Sales>[].obs;
  ApiProvider apiProvider = ApiProvider();
  RxBool isSoldListLoading = false.obs;
  RxInt semNumber = 0.obs;
  RxString searchText = ''.obs;
  searchTextSave(String value) {
    searchText.value = value;
  }

  filterSemClear(int value) {
    semNumber.value = 0;
  }

  getSoldTicketList({String? search, int? semNumber, String? date}) async {
    if (semNumber == 0) {}
    Map<String, dynamic> reqModel = {
      "offset": 0,
      "limit": 1000,
      "search": "",
      "date": date
    };
    isSoldListLoading(true);
    if (kDebugMode) {
      log(reqModel.toString());
    }
    var res = await apiProvider.getAllSoldTicket(reqModel);
    print(res.sales);
    if (res.errorMsg == null) {
      if (res.sales!.isNotEmpty) {
        isSoldListLoading(false);
        soldTicketList.value = res.sales!;
      }
    } else {
      Get.snackbar("Error", res.errorMsg.toString());
      isSoldListLoading(false);
    }

    isSoldListLoading(false);
  }

  @override
  void onReady() {
    super.onReady();
    getSoldTicketList();
  }
}
