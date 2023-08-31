import 'package:distech_technology/Controller/Ticket%20Controller/sold_ticket_controller.dart';
import 'package:distech_technology/Controller/Timer%20Controller/timer_controller.dart';
import 'package:distech_technology/Features/SoldTicket/Widgets/ticket_list_item.dart';
import 'package:distech_technology/Widgets/paginatiuon_custom_footer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../Controller/Return Ticket Controller/return_ticket.dart';

class DashboardListWidget extends StatefulWidget {
  final String date;
  final bool isSelected;
  bool dashBoard;
  DashboardListWidget(
      {super.key,
      required this.date,
      required this.isSelected,
      this.dashBoard = true});

  @override
  State<DashboardListWidget> createState() => _DashboardListWidgetState();
}

class _DashboardListWidgetState extends State<DashboardListWidget> {
  final getMyreturnController = Get.put(GetMyReturnController());
  final soldTicketzcontroller = Get.put(SoldTicketController());
  final timerController = Get.put(TimerController());
  bool countLimit(bool selectedValue) {
    if (((getMyreturnController.returnCount.value -
                    soldTicketzcontroller.selectedSoldTicket.length) <=
                0 ||
            timerController.countdown.value == "0:00:00") &&
        selectedValue == true) {
      return false;
    }
    return true;
  }

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  final soldTicketController = Get.put(SoldTicketController());
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        controller: refreshController,
        enablePullDown: false,
        enablePullUp: true,
        onRefresh: () {
          // soldTicketController.getAllTicket(date: formatedDate);
          refreshController.refreshCompleted();
        },
        onLoading: () async {
          soldTicketController.selectedSoldTicket.clear();
          soldTicketController.limit.value +=
              soldTicketController.dropDownValue.value;
          await soldTicketController.getAllTicket(
              date: widget.date,
              search: soldTicketController.searchText.value,
              semNumber: soldTicketController.semNumber.value);

          refreshController.loadComplete();
        },
        footer: const CustomFooterWidget(),
        child: ListView.builder(
          itemCount: soldTicketController.allTicketList.length,
          itemBuilder: (context, index) {
            var e = soldTicketController.allTicketList[index];
            return TicketListItemWithCheckbox(
              isSelectedIndex: widget.isSelected,
              ticketItemModel: soldTicketController.allTicketList[index],
              itemIndex: index,
              child: Transform.scale(
                scale: 1.3,
                alignment: Alignment.center,
                child: Checkbox(
                  value: soldTicketController.checkBoxForAuthor[e.sId],
                  onChanged: (value) {
                    if (widget.dashBoard == false) {
                      if (countLimit(value!)) {
                        soldTicketController.checkedBoxClicked(
                            e.sId.toString(), value);
                        setState(() {});
                      }
                    } else {
                      soldTicketController.checkedBoxClicked(
                          e.sId.toString(), value!);
                      setState(() {});
                    }
                  },
                ),
              ),
            );
          },
        ));
  }
}
