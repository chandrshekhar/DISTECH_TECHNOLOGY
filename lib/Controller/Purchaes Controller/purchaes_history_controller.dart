import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Features/PurchaseHistory/Model/purchase_history_details_model.dart';
import 'package:distech_technology/Features/PurchaseHistory/Model/purchase_hostory_model.dart';
import 'package:get/get.dart';

class PurchaseController extends GetxController {
  RxList<Purchases> puchaseList = <Purchases>[].obs;
  RxList<Tickets> purchaseHistoryDetailsList = <Tickets>[].obs;
  RxBool isPurchaseDetailsLoading = false.obs;
  RxBool isPurchaLoading = false.obs;
  ApiProvider apiProvider = ApiProvider();

  getAllPurchaesTicket(
      {String? search, int? semNumber, String? dateTime}) async {
    Map<String, dynamic> reqModel = dateTime == null || dateTime.isEmpty
        ? {
            "offset": 0,
            "limit": 1000,
          }
        : {"offset": 0, "limit": 1000, "date": dateTime};
    isPurchaLoading(true);
    var res = await apiProvider.getAllPurcHistoryTicket(reqModel);
    if (res.errorMsg == null) {
      if (res.purchases!.isNotEmpty) {
        isPurchaLoading(false);
        puchaseList.value = res.purchases!;
      } else {
        puchaseList.clear();
      }
    } else {
      Get.snackbar("Error", res.errorMsg.toString());
      isPurchaLoading(false);
    }

    isPurchaLoading(false);
  }

  getAllPurchaesTicketDetails(
      {String? search, int? semNumber, String? orderID}) async {
    Map<String, dynamic> reqModel = {
      "offset": 0,
      "limit": 1000,
      "orderId": orderID
    };
    isPurchaseDetailsLoading(true);
    var res = await apiProvider.getAllPurcHistoryTicketDetails(reqModel);
    if (res.errorMsg == null) {
      if (res.tickets!.isNotEmpty) {
        isPurchaseDetailsLoading(false);
        purchaseHistoryDetailsList.value = res.tickets!;
      } else {
        purchaseHistoryDetailsList.clear();
      }
    } else {
      Get.snackbar("Error", res.errorMsg.toString());
      isPurchaseDetailsLoading(false);
    }

    isPurchaseDetailsLoading(false);
  }

  @override
  void onReady() {
    super.onReady();
    getAllPurchaesTicket();
  }
}
