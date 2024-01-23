import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Controller/Timer%20Controller/timer_controller.dart';
import 'package:distech_technology/Features/SoldTicket/Models/sold_ticket_model.dart';
import 'package:get/get.dart';

class SoldTicketListController extends GetxController {
  RxList<Sales> soldTicketList = <Sales>[].obs;
  ApiProvider apiProvider = ApiProvider();
  RxBool isSoldListLoading = false.obs;
  RxInt semNumber = 0.obs;
  RxString searchText = ''.obs;
  RxInt soldTicketCont = 0.obs;
  RxInt limit = 10.obs;
  final timerController = Get.put(TimerController());
  searchTextSave(String value) {
    searchText.value = value;
  }

  filterSemClear(int value) {
    semNumber.value = 0;
  }

  getSoldTicketList({String? search, int? semNumber, String? date}) async {
    if (semNumber == 0) {
      semNumber = null;
    }
    Map<String, dynamic> reqModel = (date == null || date.isEmpty)
        ? {
            "offset": 0,
            "limit": limit.value,
            "search": search ?? "",
            "SEM": semNumber,
            "drawSlotId": timerController.slotId.value
          }
        : {
            "offset": 0,
            "limit": limit.value,
            "search": search ?? "",
            "SEM": semNumber,
            "date": date,
            "drawSlotId": timerController.slotId.value
          };

    isSoldListLoading(true);
    var res = await apiProvider.getAllSoldTicket(reqModel);

    if (res.sales!.isNotEmpty) {
      isSoldListLoading(false);
      soldTicketList.value = res.sales!;
      soldTicketCont.value = res.count!;
    } else {
      soldTicketList.value = res.sales!;
      soldTicketCont.value = 0;
      isSoldListLoading(false);
    }
    isSoldListLoading(false);
  }

  @override
  void onReady() {
    super.onReady();
    getSoldTicketList();
  }
}
