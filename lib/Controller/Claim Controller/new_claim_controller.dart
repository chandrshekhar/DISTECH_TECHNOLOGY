// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:base32/base32.dart';
import 'package:crypto/crypto.dart';
import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Api/urls.dart';
import 'package:distech_technology/Features/Claim/Model/claim_from_ticket_model.dart';
import 'package:distech_technology/Features/Claim/Model/claim_to_tickets_model.dart';
import 'package:distech_technology/Utils/Toast/app_toast.dart';
import 'package:distech_technology/Utils/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../Commons/app_colors.dart';
import '../../Utils/date_time_format.dart';

class NewClaimController extends GetxController {
  RxString dateFormat = ''.obs;
  RxString fromTicketScanValue = ''.obs;
  RxString toTicketScanValue = ''.obs;
  RxBool fromTicketScaning = false.obs;
  RxBool toTicketScaing = false.obs;
  RxString userName = ''.obs;
  RxString fullName = ''.obs;
  ApiProvider apiProvider = ApiProvider();
  Rx<ClaimFromTicketModel> claimFromTicketModel = ClaimFromTicketModel().obs;
  Rx<ClaimToTicketModel> claimToTicketModel = ClaimToTicketModel().obs;
  RxString barCode1 = "".obs;
  RxString barCode2 = "".obs;
  void scanBarCode(bool fromTicket, BuildContext context, String slodId) async {
    String? barcodeScanRes = await AppHelper().scanBarCode();
    print("bar code eresnsuydg ${barcodeScanRes.toString()}");

    if (fromTicket) {
      fromTicketScaning(true);
      barCode1.value = barcodeScanRes ?? "";
      claimFromTicketModel.value = await apiProvider.verifyFromTicket(
          barcodeScanRes ?? "", dateFormat.value, slodId);
      if (claimFromTicketModel.value.success == false) {
        // ignore: use_build_context_synchronously
        AwesomeDialog(
                btnOkColor: AppColors.primary,
                context: context,
                dialogType: DialogType.error,
                animType: AnimType.bottomSlide,
                dismissOnTouchOutside: true,
                title: "Error!",
                btnOkOnPress: () {},
                desc:
                    "${claimFromTicketModel.value.message}\n${dateFormat.value}\n",
                btnOkText: "Ok",
                titleTextStyle: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                    fontSize: 16))
            .show();
        fromTicketScaning(false);
      } else {
        fromTicketScanValue.value =
            claimFromTicketModel.value.ticket!.ticketId ?? "";
        fromTicketScaning(false);
      }
    } else {
      toTicketScaing(true);
      barCode2.value = barcodeScanRes ?? "";
      claimToTicketModel.value = await apiProvider.verifyToTicket(
          barcodeScanRes ?? "", dateFormat.value, slodId);

      if (claimToTicketModel.value.success == false) {
        toTicketScaing(false);
        // ignore: use_build_context_synchronously
        AwesomeDialog(
                btnOkColor: AppColors.primary,
                context: context,
                dialogType: DialogType.error,
                animType: AnimType.bottomSlide,
                dismissOnTouchOutside: true,
                title: "Error!",
                btnOkOnPress: () {},
                desc:
                    "${claimToTicketModel.value.message}\n${dateFormat.value}\n",
                btnOkText: "Ok",
                titleTextStyle: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                    fontSize: 16))
            .show();
      } else {
        toTicketScanValue.value =
            claimToTicketModel.value.ticket!.ticketId ?? "";
        toTicketScaing(false);
      }
    }
  }

  void getMyCnf() async {
    var data = await apiProvider.getMyCnf();
    if (data['success'] == true) {
      fullName.value = data['cnfStockist']['fullName']??"";
      userName.value = data['userName']??"";
    }
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

  RxInt totalCliamTicket = 0.obs;
  RxInt totalAmount = 0.obs;
  RxString drawSlotId = ''.obs;
  RxList<ClaimModel> ticketClaimList = <ClaimModel>[].obs;
  handleAdd(BuildContext context) {
    print("FromTicket--> ${claimFromTicketModel.value.ticket!.prize!.name}");
    print("ToTicket--> ${claimToTicketModel.value.ticket!.prize!.name}");
    if (claimFromTicketModel.value.ticket!.prize!.name !=
        claimToTicketModel.value.ticket!.prize!.name) {
      AwesomeDialog(
              btnOkColor: AppColors.primary,
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.bottomSlide,
              dismissOnTouchOutside: true,
              title: "Error!",
              btnOkOnPress: () {},
              desc: "Both tickets must be of same prize",
              btnOkText: "Ok",
              titleTextStyle: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.w600, fontSize: 16))
          .show();
    } else {
      print("barcode1--> ${barCode1.value}");
      print("barcode--2> $barCode2");

      totalCliamTicket.value = countTicketsInRange(
        claimFromTicketModel.value.ticket!.ticketLetter,
        claimToTicketModel.value.ticket!.ticketLetter,
        claimFromTicketModel.value.ticket!.ticketNumber,
        claimToTicketModel.value.ticket!.ticketNumber,
      );
      totalAmount.value = totalCliamTicket.value *
          claimFromTicketModel.value.ticket!.prize!.prizeAmount!;
      drawSlotId.value = claimFromTicketModel.value.ticket?.drawSlotId ?? "";
      ticketClaimList.add(ClaimModel(
          drawSlotId: drawSlotId.value,
          fromTicket: claimFromTicketModel.value.ticket!.ticketLetter!,
          toTicket: claimToTicketModel.value.ticket!.ticketLetter!,
          totalAmount: totalAmount.value,
          totalTicket: totalCliamTicket.value,
          fromTickeCode: barCode1.value,
          toTicketCode: barCode2.value,
          ticketDate: dateFormat.toString()));
      // clear the from ticket to ticket value
      fromTicketScanValue.value = '';
      toTicketScanValue.value = '';
    }
    // return "Error", "Both tickets must be of same prize";
  }

  countTicketsInRange(String? fromLetter, String? toLetter, String? fromNumber,
      String? toNumber) {
    // Convert the fromLetter and toLetter to numerical values

    int fromLetterNumber = seriesToNumber(fromLetter!);
    int toLetterNumber = seriesToNumber(toLetter!);

    // Initialize a count for the tickets
    int ticketCount = 0;

    // Iterate through the series and count the tickets within the range
    for (int i = seriesToNumber("AA"); i <= seriesToNumber("BZ"); i++) {
      if (i >= fromLetterNumber && i <= toLetterNumber) {
        ticketCount++;
      }
    }

    // Return the count of tickets within the specified range
    int fromNumbers = int.parse(fromNumber!);
    int toNumbers = int.parse(toNumber!);
    ticketCount = ticketCount * (toNumbers - fromNumbers + 1);

    return ticketCount;
  }

  int seriesToNumber(String series) {
    String letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    String firstLetter = series[0];
    String secondLetter = series[1];
    int firstNumber = letters.indexOf(firstLetter) + 1;
    int secondNumber = letters.indexOf(secondLetter) + 1;
    return (firstNumber * 26) + secondNumber;
  }

  onSubmitClaim(BuildContext context) async {
    var reqModel = {
      "ticketList": ticketClaimList
          .map((element) => {
                "drawSlotId": element.drawSlotId,
                "date": element.ticketDate,
                "fromTicket": createSignature(element.fromTickeCode),
                "toTicket": createSignature(element.toTicketCode)
              })
          .toList()
    };
    log("req--> ${reqModel.toString()}");
    var resp = await apiProvider.claimScannedticket(reqModel: reqModel);
    if (resp['success']) {
      final completed = resp['completed'] as List;
      final failed = resp['failed'] as List;

      if (completed.isNotEmpty) {
        if (failed.isNotEmpty) {
          ToastMessage().toast(
              context: context,
              message:
                  '${completed.length} claims submitted for claim and ${failed.length} claims failed to submit for claim',
              background: Colors.yellow,
              messageColor: Colors.white);
        } else {
          ToastMessage().toast(
              context: context,
              messageColor: Colors.white,
              background: Colors.green,
              message:
                  'Succes \n ${completed.length} claims submitted for claim');
        }
      } else if (failed.isNotEmpty) {
        ToastMessage().toast(
            context: context,
            messageColor: Colors.white,
            background: Colors.red,
            message:
                'Error \n ${failed.length} claims failed to submit for claim');
      } else {
        ToastMessage().toast(
            context: context,
            messageColor: Colors.white,
            background: Colors.red,
            message: 'Error \n Something went wrong');
      }

      ticketClaimList.clear();
      log("res--> ${resp.toString()}");
    }
  }

  Map<String, dynamic> createSignature(String text) {
    // var timeStamp = 1704867041219;
    final timeStamp = DateTime.now().millisecondsSinceEpoch;
    var data = {"text": text, "timeStamp": timeStamp};
    String base32String = base32
        .encode(Uint8List.fromList(timeStamp.toRadixString(32).codeUnits));
    var decodedTimeStam = base32.decodeAsString(base32String);
    log("time--> $decodedTimeStam");
    var key =
        Urls.encKey1 + text.toLowerCase() + Urls.encKey2 + decodedTimeStam;

    log("kwy--> $key");
    final hmacSha256 = Hmac(sha256, utf8.encode(key));
    final digest = hmacSha256.convert(utf8.encode(jsonEncode(data)));

    final signature = digest.toString();
    log("signature--> $signature");

    // log("digest--> $hexString");
    return {"data": data, "signature": signature};
  }
}

class ClaimModel {
  int totalAmount;
  int totalTicket;
  String fromTicket;
  String toTicket;
  String fromTickeCode;
  String toTicketCode;
  String ticketDate;
  String drawSlotId;

  ClaimModel(
      {required this.fromTicket,
      required this.toTicket,
      required this.totalAmount,
      required this.totalTicket,
      required this.fromTickeCode,
      required this.toTicketCode,
      required this.ticketDate,
      required this.drawSlotId});
}
