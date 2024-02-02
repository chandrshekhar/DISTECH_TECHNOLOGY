import 'dart:developer';

import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Features/Home/Presentation/home_screen.dart';
import 'package:distech_technology/Utils/app_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/storage/local_storage.dart';

class LoginController extends GetxController {
  var userNameController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;

  ApiProvider apiProvider = ApiProvider();
  RxBool isLoading = false.obs;

  userLogin(BuildContext context) async {
    Map<String, dynamic> reqModel = {
      "email": userNameController.value.text.trim(),
      "password": passwordController.value.text.trim(),
      "platform": "app"
    };

    if (kDebugMode) {
      print(reqModel);
    }
    try {
      isLoading(true);
      final mData = await apiProvider.loginApiCall(reqModel);
      log("mudate-- > ${mData.success}");
      if (mData.success == true) {
        LocalStorageService()
            .saveToDisk(LocalStorageService.ACCESS_TOKEN_KEY, mData.jWT);
        LocalStorageService()
            .saveToDisk(LocalStorageService.USER_NAME, mData.user!.fullName);
        // ignore: use_build_context_synchronously
        context.pushReplacement( HomeScreen());
        isLoading(false);
      } else {
        Get.snackbar("Error", mData.error ?? "Something Went Wrong");
        isLoading(false);
      }
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      }

      Get.snackbar("Error", e.toString());
      isLoading(false);
    }
  }
}
