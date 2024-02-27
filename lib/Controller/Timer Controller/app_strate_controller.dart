import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppStateController extends GetxController with WidgetsBindingObserver {
  @override
  void onInit() async {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print("sate--> $state");
    switch (state) {
      case AppLifecycleState.resumed:
        {
          print("resumed");
        }
        break;
      case AppLifecycleState.inactive:
        print("inactive");
        break;
      case AppLifecycleState.paused:
        print("paused");
        break;
      case AppLifecycleState.detached:
        print("ditech");

        break;
      case AppLifecycleState.hidden:
        print("hidded");
    }
  }
}
