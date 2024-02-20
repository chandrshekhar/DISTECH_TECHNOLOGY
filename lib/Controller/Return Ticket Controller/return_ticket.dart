import 'dart:developer';

import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Controller/Profile%20Controller/profile_controller.dart';
import 'package:distech_technology/Features/ReturnedTickets/model/returned_ticket_model.dart';
import 'package:distech_technology/Utils/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Features/ReturnUnsoldTicket/Model/return_tickets_response_model.dart';
import '../Timer Controller/timer_controller.dart';

class GetMyReturnController extends GetxController {
  RxInt returnCount = 0.obs;
  RxInt totalReturn = 0.obs;
  RxString searchText = ''.obs;
  RxList<AllReturnedTickets> returnTicketsList = <AllReturnedTickets>[].obs;
  RxBool isReturnTicketLoading = false.obs;
  RxBool isTicketValidating = false.obs;
  RxString formatedDate = ''.obs;
  ApiProvider apiProvider = ApiProvider();
  var checkBoxForAuthor = {}.obs;
  var checkBoxForselectTicket = {}.obs;
  RxBool isAllReturnedTicketSelected = false.obs;
  RxList<FailedSeriesList> validateTicketsList = <FailedSeriesList>[].obs;
  RxList<String> selectedReturnedTicket = <String>[].obs;
  RxList<String> selectedListForReturn = <String>[].obs;
  RxBool isAllTicketSelected = false.obs;

  RxBool addButtonEnable = false.obs;
  final TimerController timerController = Get.find();
  final profileController = Get.put(ProfileController());

  var searchController = TextEditingController().obs;
  var fromLetterController = TextEditingController().obs;
  var toLetterController = TextEditingController().obs;
  var fromNumberController = TextEditingController().obs;
  var toNumberController = TextEditingController().obs;
  searchTextSave(String value) {
    searchText.value = value;
  }

  getAllReturnTicket({String? dateTime, String? search}) async {
    Map<String, dynamic> reqModel = (dateTime == null || dateTime.isEmpty)
        ? {
            "offset": 0,
            "limit": 500,
            "drawSlotId": timerController.slotId.value,
            "search": search ?? "",
          }
        : {
            "offset": 0,
            "limit": 500,
            "drawSlotId": timerController.slotId.value,
            "search": search ?? "",
            "date": dateTime
          };
    isReturnTicketLoading(true);
    log("Returned ticket-=-> $reqModel");
    var res = await apiProvider.getMyReturn(reqModel);
    if (res.allReturnedTickets != null) {
      isReturnTicketLoading(false);
      returnCount.value = res.remainingReturns!;
      totalReturn.value = res.returnedCount ?? 0;
      returnTicketsList.value = res.allReturnedTickets!;
    } else {
      returnTicketsList.value = [];
      returnCount.value = 0;
      isReturnTicketLoading(false);
      Get.snackbar("Error", "Something went wrong");
    }
  }

  void clearText() {
    fromLetterController.value.clear();
    toLetterController.value.clear();
    fromNumberController.value.clear();
    toNumberController.value.clear();
  }

  // void textFieldEnableFunction() {
  //   if (returnCount.value == 0 &&
  //       timerController.countdown.value == "0:00:00") {
  //     returnTime.value = false;
  //   } else {
  //     returnTime.value = true;
  //   }
  // }

  void buttonEnabled() {
    if (fromLetterController.value.text.length == 2 &&
        toLetterController.value.text.length == 2 &&
        fromNumberController.value.text.length == 5 &&
        toNumberController.value.text.length == 5 &&
        returnCount.value != 0 &&
        timerController.countdown.value != "0:00:00") {
      addButtonEnable.value = true;
    } else {
      addButtonEnable.value = false;
    }
  }

  void removeValidateReturnTicket(int index) {
    validateTicketsList.removeAt(index);
  }

  // select Date for return unsold ticket0.

  RxBool returnFromTicketLoading = false.obs;

  // void scanBarCodeForReturnTicket(bool fromTicket, BuildContext context) async {
  //   String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
  //       '#ff6666', 'Cancel', true, ScanMode.BARCODE);
  //   print("bar code eresnsuydg ${barcodeScanRes.toString()}");

  //   if (fromTicket) {
  //     returnFromTicketLoading(true);
  //     barCode1.value = barcodeScanRes;
  //     claimFromTicketModel.value =
  //         await apiProvider.verifyFromTicket(barcodeScanRes, dateFormat.value);
  //     if (claimFromTicketModel.value.success == false) {
  //       // ignore: use_build_context_synchronously
  //       AwesomeDialog(
  //               btnOkColor: AppColors.primary,
  //               context: context,
  //               dialogType: DialogType.error,
  //               animType: AnimType.bottomSlide,
  //               dismissOnTouchOutside: true,
  //               title: "Error!",
  //               btnOkOnPress: () {},
  //               desc:
  //                   "${claimFromTicketModel.value.message}\n${dateFormat.value}\n",
  //               btnOkText: "Ok",
  //               titleTextStyle: const TextStyle(
  //                   color: Colors.red,
  //                   fontWeight: FontWeight.w600,
  //                   fontSize: 16))
  //           .show();
  //       fromTicketScaning(false);
  //     } else {
  //       fromTicketScanValue.value =
  //           claimFromTicketModel.value.ticket!.ticketId ?? "";
  //       fromTicketScaning(false);
  //     }
  //   } else {
  //     toTicketScaing(true);
  //     barCode2.value = barcodeScanRes;
  //     claimToTicketModel.value =
  //         await apiProvider.verifyToTicket(barcodeScanRes, dateFormat.value);

  //     if (claimToTicketModel.value.success == false) {
  //       toTicketScaing(false);
  //       // ignore: use_build_context_synchronously
  //       AwesomeDialog(
  //               btnOkColor: AppColors.primary,
  //               context: context,
  //               dialogType: DialogType.error,
  //               animType: AnimType.bottomSlide,
  //               dismissOnTouchOutside: true,
  //               title: "Error!",
  //               btnOkOnPress: () {},
  //               desc:
  //                   "${claimToTicketModel.value.message}\n${dateFormat.value}\n",
  //               btnOkText: "Ok",
  //               titleTextStyle: const TextStyle(
  //                   color: Colors.red,
  //                   fontWeight: FontWeight.w600,
  //                   fontSize: 16))
  //           .show();
  //     } else {
  //       toTicketScanValue.value =
  //           claimToTicketModel.value.ticket!.ticketId ?? "";
  //       toTicketScaing(false);
  //     }
  //   }
  // },

  // delete returned ticket

  void ReturnTicketInList() async {
    if (selectedReturnedTicket.isNotEmpty) {
      var res = await apiProvider.deleteMyReturn(reqModel: {
        "drawSlotId": timerController.slotId.value,
        "returnIds": selectedReturnedTicket,
        "userId": profileController.userProfileModel.value.user?.sId ?? ""
      });
      if (res['success']) {
        Get.snackbar("Success", "${res['count']} Return Deleted Successfully",
            backgroundColor: Colors.green, colorText: Colors.white);
        getAllReturnTicket();
        isAllReturnedTicketSelected(false);
        selectedReturnedTicket.clear();
      } else {
        Get.snackbar("Error!", res['error']['message'],
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } else {
      Get.snackbar("Error!", "No ticket for delete",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void deleteReturnedTicket() async {
    if (selectedReturnedTicket.isNotEmpty) {
      var res = await apiProvider.deleteMyReturn(reqModel: {
        "returnIds": selectedReturnedTicket,
        "userId": profileController.userProfileModel.value.user?.sId ?? ""
      });
      if (res['success']) {
        Get.snackbar("Success", "${res['count']} Return Deleted Successfully",
            backgroundColor: Colors.green, colorText: Colors.white);
        getAllReturnTicket();
        isAllReturnedTicketSelected(false);
        selectedReturnedTicket.clear();
      } else {
        Get.snackbar("Error!", res['error']['message'],
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } else {
      Get.snackbar("Error!", "No ticket for delete",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void checkedBoxClicked(String sId, bool val) {
    checkBoxForAuthor[sId] = val;
    if (val == true) {
      selectedReturnedTicket.add(sId.toString());
    } else {
      selectedReturnedTicket.remove(sId);
    }
    update(); // This will trigger UI update
  }

  void checkedBoxClickedOnReturn(String sId, bool val) {
    checkBoxForselectTicket[sId] = val;
    if (val == true) {
      selectedListForReturn.add(sId.toString());
    } else {
      selectedListForReturn.remove(sId);
    }
    update(); // This will trigger UI update
  }

  validateReturnTicket(String userId, String date) async {
    isTicketValidating(true);
    int fromNumber = int.parse(fromNumberController.value.text);
    int toNumber = int.parse(toNumberController.value.text);
    String fromLetter1 = fromLetterController.value.text[0];
    String fromLetter2 = fromLetterController.value.text[1];
    String toLetter1 = toLetterController.value.text[0];
    String toLetter2 = toLetterController.value.text[1];
    int fromLetter = fromLetter1.codeUnitAt(0) + fromLetter2.codeUnitAt(0);
    int toLetter = toLetter1.codeUnitAt(0) + toLetter2.codeUnitAt(0);

    if (fromNumber < 00000 || toNumber > 99999 || fromNumber > 99999) {
      Get.snackbar("Error", "Invalid Number", backgroundColor: Colors.red);
      isTicketValidating(false);
    } else if (fromNumber > toNumber) {
      Get.snackbar("Error", "From number should be less than to number",
          backgroundColor: Colors.red);
      isTicketValidating(false);
    } else if (fromLetter > toLetter) {
      Get.snackbar("Error", "From letter should be less than to letter",
          backgroundColor: Colors.red);
      isTicketValidating(false);
    } else {
      FailedSeriesList reqModel = FailedSeriesList(
          date: date,
          userId: userId,
          fromLetter: fromLetterController.value.text.toString().trim(),
          toLetter: toLetterController.value.text.toString().trim(),
          fromNumber: fromNumberController.value.text.toString().trim(),
          toNumber: toNumberController.value.text.toString().trim());
      // Map<String, dynamic> reqModel = {
      //   "userId": userId,
      //   "date": date,
      //   "fromLetter": fromLetterController.value.text.toString().trim(),
      //   "toLetter": toLetterController.value.text.toString().trim(),
      //   "fromNumber": fromNumberController.value.text.toString().trim(),
      //   "toNumber": toNumberController.value.text.toString().trim()
      // };

      var res = await apiProvider.varidateReturnTicket(reqModel.toJson());
      if (res['success']) {
        validateTicketsList.add(reqModel);
        isTicketValidating(false);
        Get.snackbar("Ticket", res['message'], backgroundColor: Colors.green);
      } else {
        isTicketValidating(false);
        Get.snackbar("Error", res['error'], backgroundColor: Colors.red);
      }
      clearText();
      isTicketValidating(false);
      buttonEnabled();
    }
  }

//void selectDate() {}
  // DateTime selectedDate = DateTime.now();

  Future<void> selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
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
    if (picked != null) {
      formatedDate.value = formatDate(date: picked, formatType: "yyyy-MM-dd");
    }
  }
}
