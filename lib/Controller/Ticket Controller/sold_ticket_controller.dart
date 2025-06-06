import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Features/Dashboard/model/all_tickets_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class SoldTicketController extends GetxController {
  RxList<Tickets> allTicketList = <Tickets>[].obs;
  RxInt allticketCount = 0.obs;
  RxList<String> selectedSoldTicket = <String>[].obs;
  ApiProvider apiProvider = ApiProvider();
  var checkBoxForAuthor = {}.obs;
  RxBool isAllSelect = false.obs;
  RxBool isAllTicketLoading = false.obs;
  RxInt semNumber = 0.obs;
  RxString searchText = ''.obs;
  RxInt limit = 10.obs;
  RxInt dropDownValue = 10.obs;
  searchTextSave(String value) {
    searchText.value = value;
  }

  filterSemClear(int value) {
    semNumber.value = 0;
  }

  Future<void> getAllTicket({
    String? search,
    int? semNumber,
    String? date,
  }) async {
    if (semNumber == 0) {
      semNumber = null;
    }
    if (date == null || date.isEmpty) {}

    Map<String, dynamic> reqModel = (date == null || date.isEmpty)
        ? {
            "offset": 0,
            "limit": limit.value,
            "search": search ?? "",
            "SEM": semNumber,
          }
        : {
            "offset": 0,
            "limit": limit.value,
            "search": search ?? "",
            "SEM": semNumber,
            "date": date
          };
    isAllTicketLoading(true);
    if (kDebugMode) {
      print(reqModel);
    }
    var res = await apiProvider.getAllTicket(reqModel);

    // ignore: prefer_for_elements_to_map_fromiterable
    var cba = Map.fromIterable(res.tickets!, key: (v) {
      return v.sId;
    }, value: (v) {
      return false;
    });
    allTicketList.value = res.tickets!;
    allticketCount.value = res.count!;
    checkBoxForAuthor.value = cba;
    isAllSelect.value = false;
    isAllTicketLoading(false);
  }

  void checkedBoxClicked(String sId, bool val) {
    checkBoxForAuthor[sId] = val;
    if (val == true) {
      selectedSoldTicket.add(sId.toString());
    } else {
      selectedSoldTicket.remove(sId);
    }
    update(); // This will trigger UI update
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  List selectedValueList = [10, 25, 50, 100, 500];
}
