import 'dart:developer';

import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Api/urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppStateController extends GetxController with WidgetsBindingObserver {
  ApiProvider apiProvider = ApiProvider();

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
    if (state == AppLifecycleState.resumed) {
      await callAppState(Urls.setActiveState);
      log('App active, calling API...');
    } else if (state == AppLifecycleState.paused) {
      log('App inactive, calling API...');
      await callAppState(Urls.setInactiveState);
    }
  }

  Future<void> callAppState(String url) async {
    var res = await apiProvider.updateUserCount(url: url);
    if (res['success'] == true) {
      log("status--> ${res.toString()}");
    }
  }
}
