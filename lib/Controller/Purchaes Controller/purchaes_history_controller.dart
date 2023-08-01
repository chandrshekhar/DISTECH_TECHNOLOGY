import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Features/PurchaseHistory/Model/purchase_hostory_model.dart';
import 'package:get/get.dart';

class PurchaseController extends GetxController {
  RxList<Purchases> puchaseList = <Purchases>[].obs;
  RxBool isPurchaLoading = false.obs;
  ApiProvider apiProvider = ApiProvider();

  getAllPurchaesTicket(
      {String? search, int? semNumber, String? dateTime}) async {
    Map<String, dynamic> reqModel = {
      "offset": 0,
      "limit": 1000,
      "date": dateTime
    };
    isPurchaLoading(true);
    var res = await apiProvider.getAllPurcHistoryTicket(reqModel);
    if (res.errprMsg == null) {
      if (res.purchases!.isNotEmpty) {
        isPurchaLoading(false);
        puchaseList.value = res.purchases!;
      } else {
        puchaseList.clear();
      }
    } else {
      Get.snackbar("Error", res.errprMsg.toString());
      isPurchaLoading(false);
    }

    isPurchaLoading(false);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
}
