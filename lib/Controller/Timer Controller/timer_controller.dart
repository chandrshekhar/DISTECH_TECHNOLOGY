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

  @override
  void onInit() {
    getServerTime();
    super.onInit();
  }

  ApiProvider apiProvider = ApiProvider();
  void startTimer(DateTime dateTime) {
    remainingTime = (dateTime.difference(currentTime.value)).obs;
    // Update the remaining time every second
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      currentTime.value = DateTime.now();
      remainingTime.value = dateTime.difference(currentTime.value);
      if (remainingTime.value.isNegative) {
        countdown.value = "0:00:00";
        timer.cancel();
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

  getServerTime() async {
    var res = await apiProvider.getServerTime();
    if (res['success'] == true) {
      lastReturnTime.value = res['lastReturnTime'].toString().substring(0, 5);
      drawTime.value = res['drawTime'].toString().substring(0, 5);
      timeParts = lastReturnTime.value.split(':');
      var targetTime = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, int.parse(timeParts[0]), int.parse(timeParts[1]));
      startTimer(targetTime);
    }
  }
}
