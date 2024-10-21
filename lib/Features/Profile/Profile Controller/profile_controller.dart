import 'package:distech_technology/Api/api_client.dart';
import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Api/urls.dart';
import 'package:distech_technology/Features/Profile/model/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final apiClient = ApiClient();

  var firstNameController = TextEditingController().obs;
  var addharController = TextEditingController().obs;
  var addressController = TextEditingController().obs;
  var pincodeController = TextEditingController().obs;
  var mobileControlelr = TextEditingController().obs;
  var emailComtroller = TextEditingController().obs;
  var tradeLicenceController = TextEditingController().obs;
  var gstController = TextEditingController().obs;
  var panController = TextEditingController().obs;
  var userProfileModel = UserProfileModel().obs;
  ApiProvider apiProvider = ApiProvider();
  RxBool isLoading = false.obs;
  RxBool isUserDataSave = false.obs;

  RxList<bool> isExpansionList =
      [false, false, false, false, false, false, false].obs;

  getUserDetails() async {
    try {
      isLoading(true);
      // var res = await apiProvider.getUserDetails();
      var res = await apiClient.getRequest(
          endPoint: EndPoints.getUserDetails,
          fromJson: (d) => UserProfileModel.fromJson(d));
      if (res.data?.success == true) {
        userProfileModel.value = res.data!;
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> intiValueController() async {
    firstNameController.value.text =
        userProfileModel.value.user!.fullName ?? "";
    addressController.value.text = userProfileModel.value.user!.address1 ?? "";
    addharController.value.text = userProfileModel.value.user!.aadhaarId ?? "";
    panController.value.text = userProfileModel.value.user!.panNumber ?? "";
    pincodeController.value.text = userProfileModel.value.user!.pinCode ?? "";
    mobileControlelr.value.text =
        userProfileModel.value.user!.mobileNumber ?? "";
    emailComtroller.value.text = userProfileModel.value.user!.email ?? "";
    tradeLicenceController.value.text =
        userProfileModel.value.user!.tradeLicenseNumber ?? "";
    gstController.value.text = userProfileModel.value.user!.gstNumber ?? "";
  }

  Future<void> editProfile(BuildContext context) async {
    Map<String, dynamic> reqModel = {
      "fullName": firstNameController.value.text,
      "aadhaarId": addharController.value.text,
      "panNumber": "74637",
      "address1": addressController.value.text,
      "address2": "",
      "pinCode": pincodeController.value.text,
      "mobileNumber": mobileControlelr.value.text,
      "tradeLicenseNumber": tradeLicenceController.value.text,
      "gstNumber": gstController.value.text,
      "purchaseRateUs": "1133",
      "billRatePrice": "3311"
    };
    isUserDataSave(true);
    // var res = await apiProvider.editProfile(reqModel);
    var res = await apiClient.postRequest(
        endPoint: EndPoints.editProfile,
        fromJson: (data) => data,
        reqModel: reqModel);

    if (res.errorMessage != null && res.data?['success'] == true) {
      isUserDataSave(false);
      await getUserDetails();
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text("Profile Update success fully")));
      Navigator.pop(Get.context!);
    } else {
      isUserDataSave(false);
    }
  }
}
