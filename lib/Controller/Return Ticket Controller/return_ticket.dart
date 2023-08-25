import 'package:distech_technology/Api/api_provider.dart';
import 'package:get/get.dart';

class GetMyReturnController extends GetxController {
  RxInt returnCount = 0.obs;
  RxBool isReturnTicketLoading = false.obs;
  ApiProvider apiProvider = ApiProvider();
  getAllReturnTicket({String? dateTime}) async {
    Map<String, dynamic> reqModel = {
      // "offset": 0,
      // "limit": 1000,
      "date": dateTime
    };
   isReturnTicketLoading(true);
    var res = await apiProvider.getMyReturn(reqModel);
    if (res.isNotEmpty) {
      isReturnTicketLoading(false);
      returnCount.value = res["remainingReturns"];
      print("return ticket---> ${res["remainingReturns"]}");
    } else {
     isReturnTicketLoading(false);
      Get.snackbar("Error", "Something went wrong");
    }
  }


}
