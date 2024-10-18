import 'package:distech_technology/Api/api_client.dart';
import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Api/urls.dart';
import 'package:distech_technology/Commons/app_colors.dart';
import 'package:distech_technology/Features/Home/Presentation/home_screen.dart';
import 'package:distech_technology/Features/Login/model/login_model.dart';
import 'package:distech_technology/Utils/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Utils/storage/local_storage.dart';

class LoginController extends GetxController {
  var userNameController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;

  ApiProvider apiProvider = ApiProvider();
  ApiClient apiClient = ApiClient();
  RxBool isLoading = false.obs;

  Future<void> userLogin(BuildContext context) async {
    Map<String, dynamic> reqModel = {
      "email": userNameController.value.text.trim(),
      "password": passwordController.value.text.trim(),
      "platform": "app"
    };
    try {
      isLoading(true);
      // final mData = await apiProvider.loginApiCall(reqModel);
      final res = await apiClient.postRequest(
          endPoint: EndPoints.loginUrl,
          reqModel: reqModel,
          fromJson: (data) => LoginResponseModel.fromJson(data));
      if (res.data?.success == true) {
        LocalStorageService().saveToDisk(
            LocalStorageService.ACCESS_TOKEN_KEY, res.data?.jWT ?? "");
        LocalStorageService().saveToDisk(
            LocalStorageService.USER_NAME, res.data?.user!.fullName);

        Get.context!.pushReplacement(HomeScreen());
        isLoading(false);
      } else {
        Get.snackbar("Error", res.data?.error ?? "Something Went Wrong",
            backgroundColor: AppColors.secondary, colorText: AppColors.white);
        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
  }
}
