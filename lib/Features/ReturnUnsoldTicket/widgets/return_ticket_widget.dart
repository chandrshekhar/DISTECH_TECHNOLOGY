import 'package:distech_technology/Commons/app_colors.dart';
import 'package:distech_technology/Commons/app_sizes.dart';
import 'package:distech_technology/Controller/Ticket%20Controller/sold_ticket_controller.dart';
import 'package:distech_technology/Controller/Timer%20Controller/timer_controller.dart';
import 'package:distech_technology/Widgets/paginatiuon_custom_footer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../Controller/Return Ticket Controller/return_ticket.dart';

class ReturnTicketListWidget extends StatefulWidget {
  final String date;
  bool dashBoard;
  ReturnTicketListWidget(
      {super.key, required this.date, this.dashBoard = true});

  @override
  State<ReturnTicketListWidget> createState() => _ReturnTicketListWidgetState();
}

class _ReturnTicketListWidgetState extends State<ReturnTicketListWidget> {
  final getMyreturnController = Get.put(GetMyReturnController());
  final soldTicketzcontroller = Get.put(SoldTicketController());
  final timerController = Get.put(TimerController());
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
            return Container(
              color: (index % 2 == 0) ? AppColors.white : AppColors.primaryBg,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.kDefaultPadding,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        "${index + 1}",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Text(
                          e.ticketId.toString(),
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.bodyMedium,
                        )),
                    Obx(() => Checkbox(
                          value: getMyreturnController
                                  .checkBoxForselectTicket[e.sId] ??
                              false,
                          onChanged: (v) {
                            getMyreturnController.checkedBoxClickedOnReturn(
                                e.sId!, v!);
                            if (v == true) {
                              getMyreturnController.selectedListForReturn
                                  .add(e.sId!);
                            } else {
                              getMyreturnController.selectedListForReturn
                                  .remove(e.sId);
                              ;
                            }
                          },
                        )),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
