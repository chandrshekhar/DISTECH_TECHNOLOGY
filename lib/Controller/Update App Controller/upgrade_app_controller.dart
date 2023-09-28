// import 'package:get/get.dart';
// import 'package:new_version/new_version.dart';

// class AppUpdateController extends GetxController {
//   @override
//   void onInit() async {
//     super.onInit();
//     final newVersion = NewVersion(
//         iOSId: 'com.google.Vespa',
//       androidId: 'com.app.singham_lottery',
//     );

//     newVersion.showAlertIfNecessary(context: Get.context!);

//     final status = await newVersion.getVersionStatus();
//     if (status != null) {
//       newVersion.showUpdateDialog(
//           context: Get.context!,
//           versionStatus: status,
//           dialogTitle: "Update Available",
//           dialogText: "Update the app to continue",
//           allowDismissal: false,
//           updateButtonText: "Update",
//           dismissAction: () {},
//           dismissButtonText: "Cancel");
//     }
//   }
// }
