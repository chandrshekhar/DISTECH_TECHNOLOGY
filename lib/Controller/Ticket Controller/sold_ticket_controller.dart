// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Commons/app_colors.dart';
import 'package:distech_technology/Controller/Timer%20Controller/timer_controller.dart';
import 'package:distech_technology/Features/Dashboard/model/all_tickets_model.dart';
import 'package:distech_technology/Utils/date_time_format.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

class SoldTicketController extends GetxController {
  RxList<Tickets> allTicketList = <Tickets>[].obs;
  RxInt allticketCount = 0.obs;
  RxList<String> selectedSoldTicket = <String>[].obs;
  ApiProvider apiProvider = ApiProvider();
  var checkBoxForAuthor = {}.obs;
  RxBool isAllSelect = false.obs;
  RxBool isAllTicketLoading = false.obs;
  RxInt semNumber = 0.obs;
  RxString searchText = ''.obs;
  RxInt limit = 10.obs;
  RxInt dropDownValue = 10.obs;
  final timerController = Get.put(TimerController());
  searchTextSave(String value) {
    searchText.value = value;
  }

  filterSemClear(int value) {
    semNumber.value = 0;
  }

  Future<void> getAllTicket({
    String? search,
    int? semNumber,
    String? date,
  }) async {
    if (semNumber == 0) {
      semNumber = null;
    }
    if (date == null || date.isEmpty) {}

    Map<String, dynamic> reqModel = (date == null || date.isEmpty)
        ? {
            "offset": 0,
            "limit": limit.value,
            "search": search ?? "",
            "SEM": semNumber,
            "drawSlotId": timerController.slotId.value
          }
        : {
            "offset": 0,
            "limit": limit.value,
            "search": search ?? "",
            "SEM": semNumber,
            "date": date,
            "drawSlotId": timerController.slotId.value
          };
    isAllTicketLoading(true);
    if (kDebugMode) {
      print(reqModel);
    }
    var res = await apiProvider.getAllTicket(reqModel);

    // ignore: prefer_for_elements_to_map_fromiterable
    var cba = Map.fromIterable(res.tickets!, key: (v) {
      return v.sId;
    }, value: (v) {
      return false;
    });
    allTicketList.value = res.tickets!;
    allticketCount.value = res.count!;
    checkBoxForAuthor.value = cba;
    isAllSelect.value = false;
    isAllTicketLoading(false);
  }

  void checkedBoxClicked(String sId, bool val) {
    checkBoxForAuthor[sId] = val;
    if (val == true) {
      selectedSoldTicket.add(sId.toString());
    } else {
      selectedSoldTicket.remove(sId);
    }
    update(); // This will trigger UI update
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  // scan bar code for return ticket
  RxString barcodeValue = ''.obs;
  RxBool scannedReturningTicket = false.obs;

  Future<void> scanBarcodeNormal(BuildContext context) async {
    RxList<String> scanedTicket = <String>[].obs;
    scannedReturningTicket(true);
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    // String barcodeScanRes = "0VY5WAG8Y";
    var data = await apiProvider.verifyTicket(barcodeScanRes.toString().trim(),
        formatedDate.value, timerController.slotId.toString());
    log("data--> $data");
    if (data['valid'] == true && data['success']) {
      scanedTicket.add(data["ticket"]["ticketId"]);

      AwesomeDialog(
        btnOkColor: Colors.green,
        context: context,
        dialogType: DialogType.question,
        animType: AnimType.bottomSlide,
        dismissOnTouchOutside: false,
        body: Column(
          children: [
            const Text(
              "Ticket Details",
              style: TextStyle(fontSize: 20, color: AppColors.primary),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "TicketId  : ${data['ticket']['ticketId'].toString()}",
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.grey),
            ),
            Text(
              "BarCode  : ${data['ticket']['barCode'].toString()}",
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.grey),
            ),
            Text(
              "QrCode  : ${data['ticket']['qrCode'].toString()}",
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.grey),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Please Choose One option:",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: Colors.blue),
            ),
          ],
        ),
        btnCancelOnPress: () {},
        btnOkText: "Sold",
        btnCancelColor: Colors.red,
        btnOkOnPress: () async {
          var res = await ApiProvider().soldTciket(
            scanedTicket,
            formatedDate.value,
            timerController.slotId.value,
          );

          log("return Res--> $res");
          if (res['success'] = true) {
            Get.snackbar("Successful", "${scanedTicket.first} Ticket Sold",
                backgroundColor: Colors.green,
                colorText: Colors.white,
                isDismissible: true,
                snackPosition: SnackPosition.BOTTOM);
          } else {
            Get.snackbar("Error!", res['message'],
                backgroundColor: Colors.red,
                colorText: Colors.white,
                isDismissible: true,
                snackPosition: SnackPosition.BOTTOM);
          }
        },
      ).show();

      scannedReturningTicket(false);
      await getAllTicket(
        date: formatedDate.value,
      );
    } else {
      Get.snackbar("Error!", data['message'],
          backgroundColor: Colors.red,
          colorText: Colors.white,
          isDismissible: true,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // choose date
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
      await getAllTicket(
          date: formatedDate.value,
          search: searchText.value,
          semNumber: semNumber.value);
      print("date--> $formatedDate");
    }
  }

  List selectedValueList = [10, 25, 50, 100, 500];
}
