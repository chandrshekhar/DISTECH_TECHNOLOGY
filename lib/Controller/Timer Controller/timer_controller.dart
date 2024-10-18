import 'dart:async';
import 'package:distech_technology/Api/api_client.dart';
import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Api/urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimerController extends GetxController {
  final apiClient = ApiClient();

  // initializing with the current theme of the device
  Rx<ThemeMode> currentTheme = ThemeMode.system.obs;
  // function to switch between themes
  void switchTheme() {
    currentTheme.value = currentTheme.value == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
  }

  // Replace with your target time
  final countdown = RxString('');
  final lastReturnTime = RxString("00:00");
  final drawTime = RxString("00:00");
  Rx<DateTime> currentTime = DateTime.now().obs;
  late Rx<Duration> remainingTime;
  List<String> timeParts = RxList<String>();

  RxBool gettingSlotLoding = false.obs;
  RxString slotId = ''.obs;
  RxString intialSlot = ''.obs;
  // RxList<String> slotList = <String>[].obs;
  Rx<DrawSlotModel> drawModel = DrawSlotModel().obs;

  @override
  void onInit() {
    getSloat();
    super.onInit();
  }

  Timer? timer;

  ApiProvider apiProvider = ApiProvider();
  void startTimer(DateTime dateTime) {
    remainingTime = (dateTime.difference(currentTime.value)).obs;
    // Update the remaining time every second
    timer = Timer.periodic(const Duration(seconds: 1), (timers) async {
      currentTime.value = DateTime.now();
      remainingTime.value = dateTime.difference(currentTime.value);
      if (remainingTime.value.isNegative) {
        countdown.value = "0:00:00";
        timers.cancel();
        _startMethodAfterDelay();
      } else {
        int hours = remainingTime.value.inHours;
        int minutes = remainingTime.value.inMinutes.remainder(60);
        int seconds = remainingTime.value.inSeconds.remainder(60);
        countdown.value =
            '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
      }
    });
  }

  Future<void> _startMethodAfterDelay() async {
    var targetTime = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, int.parse(timeParts[0]), int.parse(timeParts[1]));
    await Future.delayed(const Duration(hours: 4, minutes: 30));
    startTimer(targetTime);
  }

  String convertTo12HourFormat(String time24) {
    // Split the time into hours and minutes
    List<String> timeParts = time24.split(':');
    int hours = int.parse(timeParts[0]);
    int minutes = int.parse(timeParts[1]);
    // Determine AM or PM
    String amPm = hours < 12 ? 'AM' : 'PM';
    // Convert to 12-hour format
    hours = hours % 12 == 0 ? 12 : hours % 12;
    // Format the result
    String time12 = '$hours:${minutes.toString().padLeft(2, '0')} $amPm';
    return time12;
  }

  getServerTime() async {
    Map<String, dynamic> reqModel = {"drawSlotId": slotId.value};
    // var res = await apiProvider.getServerTime(reqModel);
    var res = await apiClient.postRequest(
        endPoint: EndPoints.serverTime, fromJson: (v) => v, reqModel: reqModel);
    if (res.data?['success'] == true) {
      lastReturnTime.value = convertTo12HourFormat(
          res.data!['lastReturnTime'].toString().substring(0, 5));
      drawTime.value = convertTo12HourFormat(
          res.data!['drawTime'].toString().substring(0, 5));
      timeParts =
          res.data!['lastReturnTime'].toString().substring(0, 5).split(':');
      // print("target Time--$timeParts");
      var targetTime = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, int.parse(timeParts[0]), int.parse(timeParts[1]));
      timer?.cancel();
      startTimer(targetTime);
    }
  }

  Future<void> getSloat() async {
    gettingSlotLoding(true);
    // var res = await apiProvider.getSlot();
    var res = await apiClient.getRequest(
        endPoint: EndPoints.getSlot,
        fromJson: (d) => DrawSlotModel.fromJson(d));

    if (res.data?.success == true) {
      drawModel.value = res.data!;
      // slotId.value = drawModel.value.data?[0].sId ?? "";
      getServerTime();
      // intialSlot.value = drawModel.value.data![0].name.toString();
      gettingSlotLoding(false);
    } else {
      gettingSlotLoding(false);
    }
  }
}

class DrawSlotModel {
  bool? success;
  List<Data>? data;
  String? error;

  DrawSlotModel.withError(String err) {
    error = err;
  }

  DrawSlotModel({this.success, this.data});

  DrawSlotModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? name;
  String? drawTime;
  String? returnTime;
  String? returnDeleteTime;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? number;
  int? targetTime;
  bool? isClosest;

  Data(
      {this.sId,
      this.name,
      this.drawTime,
      this.returnTime,
      this.returnDeleteTime,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.number,
      this.targetTime,
      this.isClosest});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    drawTime = json['drawTime'];
    returnTime = json['returnTime'];
    returnDeleteTime = json['returnDeleteTime'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    number = json['number'];
    targetTime = json['targetTime'];
    isClosest = json['isClosest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['drawTime'] = drawTime;
    data['returnTime'] = returnTime;
    data['returnDeleteTime'] = returnDeleteTime;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['number'] = number;
    data['targetTime'] = targetTime;
    data['isClosest'] = isClosest;
    return data;
  }
}
