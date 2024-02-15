import 'dart:developer';

import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Controller/Profile%20Controller/profile_controller.dart';
import 'package:distech_technology/Controller/Timer%20Controller/timer_controller.dart';
import 'package:distech_technology/Features/SoldTicket/Models/sold_ticket_model.dart';
import 'package:distech_technology/Utils/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SoldTicketListController extends GetxController {
  RxList<Sales> soldTicketList = <Sales>[].obs;
  ApiProvider apiProvider = ApiProvider();
  RxBool isSoldListLoading = false.obs;
  RxInt semNumber = 0.obs;
  RxString searchText = ''.obs;
  RxInt soldTicketCont = 0.obs;
  RxInt limit = 10.obs;
  final timerController = Get.put(TimerController());
  final searchController = TextEditingController().obs;
  RxList<String> selectedSoldTicket = <String>[].obs;
  var checkBoxForSoldTicket = {}.obs;
  RxBool isAllSoldTicketSelected = false.obs;

  final profileController = Get.put(ProfileController());
  searchTextSave(String value) {
    searchText.value = value;
  }

  void checkedBoxClicked(String sId, bool val) {
    checkBoxForSoldTicket[sId] = val;

    if (val == true) {
      selectedSoldTicket.add(sId.toString());
    } else {
      selectedSoldTicket.remove(sId);
    }
    update(); // This will trigger UI update
  }

  // revert sold ticket
  // delete returned ticket

  void revertSoldTicket() async {
    if (selectedSoldTicket.isNotEmpty) {
      var res = await apiProvider.revertMySales(reqModel: {
        "tickets": selectedSoldTicket,
        "date": formatedDate.value
      });
      log("return sale -- >$res");
      if (res['success']) {
        Get.snackbar("Success", " Return Deleted Successfully",
            backgroundColor: Colors.green, colorText: Colors.white);
        getSoldTicketList();
        isAllSoldTicketSelected(false);
        selectedSoldTicket.clear();
      } else {
        Get.snackbar("Error!", res['message'],
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } else {
      Get.snackbar("Error!", "No ticket for revert",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
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
            "limit": limit.value,
            "search": search ?? "",
            "SEM": semNumber,
          }
        : {
            "offset": 0,
            "limit": limit.value,
            "search": search ?? "",
            "SEM": semNumber,
            "date": date,
          };

    isSoldListLoading(true);
    var res = await apiProvider.getAllSoldTicket(reqModel);

    if (res.sales!.isNotEmpty) {
      isSoldListLoading(false);
      soldTicketList.value = res.sales!;
      soldTicketCont.value = res.count!;
    } else {
      soldTicketList.value = res.sales!;
      soldTicketCont.value = 0;
      isSoldListLoading(false);
    }
    isSoldListLoading(false);
  }

  RxString formatedDate = ''.obs;
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
      formatedDate.value = formatDate(date: picked, formatType: "yyyy-MM-dd");
      getSoldTicketList(
        date: formatedDate.value,
        semNumber: semNumber.value,
      );
    }
  }

  @override
  void onReady() {
    super.onReady();
    getSoldTicketList();
  }
}
