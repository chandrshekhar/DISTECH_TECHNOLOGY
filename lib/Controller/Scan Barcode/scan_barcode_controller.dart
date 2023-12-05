import 'package:distech_technology/Api/api_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

class ScanBarcodeController extends GetxController {
  ApiProvider apiProvider = ApiProvider();

  Rx<ScanTicketModel> scanTickModel = ScanTicketModel().obs;

  RxBool isTicketScanning = false.obs;

  RxString barcodeValue = "NA".obs;

  RxString invalidString = ''.obs;

  Future<void> scanBarcodeNormal(String dateFormat) async {
    try {
      isTicketScanning(true);
      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      barcodeValue.value = barcodeScanRes;
      await apiProvider
          .verifyTicket(barcodeValue.trim(), dateFormat)
          .then((value) {
        print("value1->${value.error}");

        invalidString.value = value.error.toString();

        isTicketScanning(false);
      });
    } on PlatformException {
      if (kDebugMode) {
        print("Platform  Exception");
      }
      isTicketScanning(false);
    }
  }
}

// model class for scan ticket response
class ScanTicketModel {
  bool? success;
  Ticket? ticket;
  String? error;

  ScanTicketModel({this.success, this.ticket, this.error});

  ScanTicketModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    ticket = json['ticket'] != null ? Ticket.fromJson(json['ticket']) : null;
  }
  ScanTicketModel.withError(String errorValue) {
    error = errorValue;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    return data;
  }
}

class Ticket {
  String? sId;
  String? ticketId;
  String? ticketLetter;
  String? date;
  String? status;
  String? ticketNumber;
  Prize? prize;

  Ticket(
      {this.sId,
      this.ticketId,
      this.ticketLetter,
      this.date,
      this.status,
      this.ticketNumber,
      this.prize});

  Ticket.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    ticketId = json['ticketId'];
    ticketLetter = json['ticketLetter'];
    date = json['date'];
    status = json['status'];
    ticketNumber = json['ticketNumber'];
    prize = json['prize'] != null ? Prize.fromJson(json['prize']) : null;
  }
}

class Prize {
  String? name;
  int? value;
  int? prizeAmount;
  int? agentAmount;

  Prize({this.name, this.value, this.prizeAmount, this.agentAmount});

  Prize.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
    prizeAmount = json['prizeAmount'];
    agentAmount = json['agentAmount'];
  }
}
