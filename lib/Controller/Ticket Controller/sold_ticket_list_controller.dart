import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Features/SoldTicket/Models/sold_ticket_model.dart';
import 'package:get/get.dart';

class SoldTicketListController extends GetxController {
  RxList<Sales> soldTicketList = <Sales>[].obs;
  ApiProvider apiProvider = ApiProvider();
  RxBool isSoldListLoading = false.obs;
  RxInt semNumber = 0.obs;
  RxString searchText = ''.obs;

  searchTextSave(String value) {
    searchText.value = value;
  }

  filterSemClear(int value) {
    semNumber.value = 0;
  }

  getSoldTicketList({String? search, int? semNumber}) async {
    Map<String, dynamic> reqModel = {
      "offset": 0,
      "limit": 10000
     
    };
    isSoldListLoading(true);
    var res = await apiProvider.getAllSoldTicket(reqModel);
    soldTicketList.value = res.sales!;
    isSoldListLoading(false);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getSoldTicketList();
  }
}
