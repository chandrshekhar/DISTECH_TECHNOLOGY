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
  RxInt limit = 30.obs;
  RxInt purDetLimit = 40.obs;
  RxInt countPurchaesTickets = 0.obs;
  getAllPurchaesTicket(
      {String? search, int? semNumber, String? dateTime}) async {
    Map<String, dynamic> reqModel = dateTime == null || dateTime.isEmpty
        ? {
            "offset": 0,
            "limit": limit.value,
          }
        : {"offset": 0, "limit": limit.value, "date": dateTime};
    isPurchaLoading(true);
    var res = await apiProvider.getAllPurcHistoryTicket(reqModel);
    if (res.errorMsg == null) {
      if (res.purchases!.isNotEmpty) {
        isPurchaLoading(false);
        puchaseList.value = res.purchases!;
        countPurchaesTickets.value = res.count!;
      } else {
        countPurchaesTickets.value = 0;
        puchaseList.clear();
        isPurchaLoading(false);
      }
    } else {
      Get.snackbar("Error", res.errorMsg.toString());
      isPurchaLoading(false);
    }

    isPurchaLoading(false);
  }

  getAllPurchaesTicketDetails(
      {String? search, int? semNumber, String? orderID, String? slotId}) async {
    Map<String, dynamic> reqModel = {
      "orderId": orderID,
      "offset": 0,
      "limit": purDetLimit.value,
         "drawSlotId": slotId
    };

    isPurchaseDetailsLoading(true);
    var res = await apiProvider.getAllPurcHistoryTicketDetails(reqModel);

    if (res.tickets!.isNotEmpty) {
      isPurchaseDetailsLoading(false);
      purchaseHistoryDetailsList.value = res.tickets!;
    } else {
      isPurchaseDetailsLoading(false);
      purchaseHistoryDetailsList.value = [];
    }

    isPurchaseDetailsLoading(false);
  }

  @override
  void onReady() {
    super.onReady();
    getAllPurchaesTicket();
  }
}
