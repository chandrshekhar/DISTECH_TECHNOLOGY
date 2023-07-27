import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Features/Dashboard/model/all_tickets_model.dart';
import 'package:get/get.dart';

class SoldTicketController extends GetxController {
  RxList<Tickets> allTicketList = <Tickets>[].obs;
  RxList<Tickets> searchedList = <Tickets>[].obs;
  RxList<String> selectedSoldTicket = <String>[].obs;
  ApiProvider apiProvider = ApiProvider();
  var checkBoxForAuthor = {}.obs;
  RxBool isAllTicketLoading = false.obs;

  getAllTicket() async {
    Map<String, dynamic> reqModel = {"offset": 10, "limit": 50};
    isAllTicketLoading(true);
    var res = await apiProvider.getAllTicket(reqModel);
    // ignore: prefer_for_elements_to_map_fromiterable
    var cba = Map.fromIterable(res.tickets!, key: (v) {
      return v.sId;
    }, value: (v) {
      return false;
    });
    allTicketList.value = res.tickets!;
    checkBoxForAuthor.value = cba;
    searchedList = allTicketList;
    isAllTicketLoading(false);
  }

  checkBoxChangeAuthor(var key, dynamic checkBoxValue) {
    checkBoxForAuthor[key] = checkBoxValue;
  }

  void filterSearch(String? query) {
    searchedList.value = allTicketList
        .where((element) => element.ticketId!
            .trim()
            .toLowerCase()
            .toString()
            .contains(query!.trim().toLowerCase().toString()))
        .toList();
  }

  void filterSearchBySem(String query) {
    searchedList.value = allTicketList
        .where((element) =>
            element.sEM.toString().contains(query.toLowerCase().toString()))
        .toList();
  }

  checkedBoxClicked(sId, val) {
    checkBoxChangeAuthor(sId, val);
    if (val == true) {
      selectedSoldTicket.add(sId.toString());
    } else {
      selectedSoldTicket.remove(sId);
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getAllTicket();
  }
}
