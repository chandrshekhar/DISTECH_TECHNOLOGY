import 'package:distech_technology/Api/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupportController extends GetxController {
  var subjectController = TextEditingController().obs;
  var messageController = TextEditingController().obs;
  ApiProvider apiProvider = ApiProvider();
  RxBool isLoading = false.obs;

  Future<void> supportMethod() async {
    isLoading(true);
    Map<String, dynamic> reqModel = {
      "subject": subjectController.value.text,
      "message": messageController.value.text
    };
    var res = await apiProvider.userSupportApimethod(reqModel);
    if (res == true) {
      isLoading(false);
      Get.snackbar("Response", "Message sent successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          isDismissible: true,
          snackPosition: SnackPosition.BOTTOM);
      subjectController.value.clear();
      messageController.value.clear();
    } else {
      isLoading(false);
      Get.snackbar(
          "Not response", "Your are not selected any ticket for mark as sold",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          isDismissible: true,
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
