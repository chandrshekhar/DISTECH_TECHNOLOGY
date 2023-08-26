
import 'dart:async';
import 'package:get/get.dart';
class TimerController extends GetxController {
  final targetTime =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 19,30); // Replace with your target time
  final countdown = RxString('');

  Rx<DateTime> currentTime = DateTime.now().obs;
  late Rx<Duration> remainingTime;

  @override
  void onInit() {
    super.onInit();
    remainingTime = (targetTime.difference(currentTime.value)).obs;
    // Update the remaining time every second
    Timer.periodic(const Duration(seconds: 1), (timer) {
      currentTime.value = DateTime.now();
      remainingTime.value = targetTime.difference(currentTime.value);

      if (remainingTime.value.isNegative) {
        countdown.value = "Timer Expired";
        timer.cancel();
      } else {
        int hours = remainingTime.value.inHours;
        int minutes = remainingTime.value.inMinutes.remainder(60);
        int seconds = remainingTime.value.inSeconds.remainder(60);
        countdown.value =
            '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
      }
    });
  }
}
