import 'dart:async';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TimerController extends GetxController {
  RxInt remainingSeconds = 300.obs; // 5 minutes
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    startCountdown();
  }

  void startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        _timer?.cancel();
        // You can add actions to perform when the timer reaches zero here.
      }
    });
  }
  String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  int minutes = duration.inMinutes;
  int seconds = duration.inSeconds.remainder(60);
  return '${twoDigits(minutes)}:${twoDigits(seconds)}';
}

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
