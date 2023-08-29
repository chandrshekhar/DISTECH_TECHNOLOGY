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
    if (semNumber == 0) {
      semNumber = null;
    }
    Map<String, dynamic> reqModel = (date == null || date.isEmpty)
        ? {
            "offset": 0,
            "limit": 500,
            "search": search ?? "",
            "SEM": semNumber,
          }
        : {
            "offset": 0,
            "limit": 500,
            "search": search ?? "",
            "SEM": semNumber,
            "date": date
          };

    isSoldListLoading(true);
    if (kDebugMode) {
      log(reqModel.toString());
    }
    var res = await apiProvider.getAllSoldTicket(reqModel);

    if (res.sales!.isNotEmpty) {
      isSoldListLoading(false);
      soldTicketList.value = res.sales!;
    } else {
      soldTicketList.value = [];
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
