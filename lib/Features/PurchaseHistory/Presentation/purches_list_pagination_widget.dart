import 'package:distech_technology/Commons/app_colors.dart';
import 'package:distech_technology/Features/PurchaseHistory/Presentation/purchases_details_screen.dart';
import 'package:distech_technology/Widgets/paginatiuon_custom_footer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../Controller/Purchaes Controller/purchaes_history_controller.dart';
import '../widget/purchase_history_card.dart';

class PurchesHistoryTicketWidget extends StatefulWidget {
  PurchesHistoryTicketWidget({super.key, required this.dateTime});

  DateTime dateTime;
  @override
  State<PurchesHistoryTicketWidget> createState() =>
      _PurchesHistoryTicketWidgetState();
}

class _PurchesHistoryTicketWidgetState
    extends State<PurchesHistoryTicketWidget> {
  final purchaseController = Get.put(PurchaseController());
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  @override
  Widget build(BuildContext context) {
    return RawScrollbar(
      thumbColor: AppColors.primary,
      thickness: 3,
      child: SmartRefresher(
        controller: refreshController,
        enablePullDown: false,
        enablePullUp: true,
        onRefresh: () async {
          refreshController.loadComplete();
        },
        onLoading: () async {
          purchaseController.limit.value += 30;
          await purchaseController.getAllPurchaesTicket();
          refreshController.loadComplete();
        },
        footer: const CustomFooterWidget(),
        child: ListView.builder(
          itemCount: purchaseController.puchaseList.length,
          itemBuilder: (context, index) {
            var item = purchaseController.puchaseList[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => PurchaesDetailsScreen(
                              dateTime: widget.dateTime,
                              orderID: item.sId.toString(),
                            )));
              },
              child: PurchaseHistoryTicketListItem(
                  ticket:
                      "${item.fromTicket}${item.fromNumber} - ${item.toTicket}${item.toNumber}",
                  quantity: item.count!.toInt(),
                  seller: item.seller!.fullName ?? "",
                  itemIndex: index),
            );
          },
        ),
      ),
    );
  }
}
