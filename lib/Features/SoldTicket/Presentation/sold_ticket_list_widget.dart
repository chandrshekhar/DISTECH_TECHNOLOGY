import 'package:distech_technology/Commons/app_colors.dart';
import 'package:distech_technology/Controller/Ticket%20Controller/sold_ticket_list_controller.dart';
import 'package:distech_technology/Widgets/paginatiuon_custom_footer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../Commons/app_sizes.dart';
import '../Widgets/ticket_list_item.dart';

class SoldTicketsListWidget extends StatefulWidget {
  final String date;
  const SoldTicketsListWidget({super.key, required this.date});

  @override
  State<SoldTicketsListWidget> createState() => _SoldTicketsListWidgetState();
}

class _SoldTicketsListWidgetState extends State<SoldTicketsListWidget> {
  final soldTicketListController = Get.put(SoldTicketListController());
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    return RawScrollbar(
      thumbColor: AppColors.primary,
      thickness: 3,
      radius:  Radius.circular(AppSizes.cardCornerRadius),
      child: SmartRefresher(
        controller: refreshController,
        enablePullDown: false,
        enablePullUp: true,
        onRefresh: () {
          // soldTicketController.getAllTicket(date: formatedDate);
          refreshController.refreshCompleted();
        },
        onLoading: () async {
          soldTicketListController.limit.value += 10;
          await soldTicketListController.getSoldTicketList(
              date: widget.date,
              search: soldTicketListController.searchText.value,
              semNumber: soldTicketListController.semNumber.value);
          refreshController.loadComplete();
        },
        footer: const CustomFooterWidget(),
        child: ListView.builder(
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            itemCount: soldTicketListController.soldTicketList.length,
            itemBuilder: ((context, index) {
              var item = soldTicketListController.soldTicketList[index];
              return TicketListItem(
                  ticketId: item.ticketId ?? "", itemIndex: index);
            })),
      ),
    );
  }
}
