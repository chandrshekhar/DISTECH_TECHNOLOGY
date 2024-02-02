import 'dart:async';

import 'package:distech_technology/Api/api_provider.dart';
import 'package:get/get.dart';

class TimerController extends GetxController {
  // Replace with your target time
  final countdown = RxString('');
  final lastReturnTime = RxString("00:00");
  final drawTime = RxString("00:00");
  Rx<DateTime> currentTime = DateTime.now().obs;
  late Rx<Duration> remainingTime;
  List<String> timeParts = RxList<String>();

  RxBool gettingSlotLoding = false.obs;
  // RxString slotId = ''.obs;
  RxString intialSlot = ''.obs;
  // RxList<String> slotList = <String>[].obs;

  @override
  void onInit() {
    getServerTime();
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
    // Map<String, dynamic> reqModel = {"drawSlotId": slotId.value};
    var res = await apiProvider.getServerTime();
    if (res['success'] == true) {
      lastReturnTime.value = convertTo12HourFormat(
          res['lastReturnTime'].toString().substring(0, 5));
      drawTime.value =
          convertTo12HourFormat(res['drawTime'].toString().substring(0, 5));
      timeParts = res['lastReturnTime'].toString().substring(0, 5).split(':');
      // print("target Time--$timeParts");
      var targetTime = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, int.parse(timeParts[0]), int.parse(timeParts[1]));
      timer?.cancel();
      startTimer(targetTime);
    }
  }
}






