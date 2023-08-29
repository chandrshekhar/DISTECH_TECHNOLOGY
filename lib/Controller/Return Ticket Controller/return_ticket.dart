import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Features/ReturnedTickets/model/returned_ticket_model.dart';
import 'package:get/get.dart';

class GetMyReturnController extends GetxController {
  RxInt returnCount = 0.obs;
  RxList<AllReturnedTickets> returnTicketsList = <AllReturnedTickets>[].obs;
  RxBool isReturnTicketLoading = false.obs;
  ApiProvider apiProvider = ApiProvider();
  getAllReturnTicket({String? dateTime}) async {
    Map<String, dynamic> reqModel = (dateTime == null || dateTime.isEmpty)
        ? {
            // "offset": 0,
            // "limit": 1000,
          }
        : {"date": dateTime};
    isReturnTicketLoading(true);
    var res = await apiProvider.getMyReturn(reqModel);
    if (res.allReturnedTickets != null) {
      isReturnTicketLoading(false);
      returnCount.value = res.remainingReturns!;
    } else {
      isReturnTicketLoading(false);
      Get.snackbar("Error", "Something went wrong");
    }
  }
}
