import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Features/Profile/model/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
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

//get user data

  getUserDetails() async {
    try {
      isLoading(true);
      var res = await apiProvider.getUserDetails();
      if (res.success == true) {
        var res = await apiProvider.getUserDetails();
        userProfileModel.value = res;
        intiValueController();
        isLoading(false);
      } else {
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
    }
  }

  intiValueController() {
    firstNameController.value.text =
        userProfileModel.value.user!.fullName ?? "";
    addressController.value.text = userProfileModel.value.user!.address1 ?? "";
    addharController.value.text = "377348";
    panController.value.text = userProfileModel.value.user!.panNumber ?? "";
    pincodeController.value.text = userProfileModel.value.user!.pinCode ?? "";
    mobileControlelr.value.text =
        userProfileModel.value.user!.mobileNumber ?? "";
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
    var res = await apiProvider.editProfile(reqModel);
    if (res == true) {
      isUserDataSave(false);
      await getUserDetails();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text("Profile Update success fully")));

      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } else {
      isUserDataSave(false);
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getUserDetails();
  }
}
