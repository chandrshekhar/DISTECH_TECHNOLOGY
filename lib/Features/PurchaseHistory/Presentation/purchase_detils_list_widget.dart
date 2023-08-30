import 'package:distech_technology/Commons/app_colors.dart';
import 'package:distech_technology/Commons/app_sizes.dart';
import 'package:distech_technology/Widgets/paginatiuon_custom_footer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../Controller/Purchaes Controller/purchaes_history_controller.dart';
import '../../../Widgets/purchase_details_card.dart';

class PurchaseDetailsListWidget extends StatefulWidget {
  final String orderId;
  const PurchaseDetailsListWidget({super.key, required this.orderId});

  @override
  State<PurchaseDetailsListWidget> createState() =>
      _PurchaseDetailsListWidgetState();
}

class _PurchaseDetailsListWidgetState extends State<PurchaseDetailsListWidget> {
  final purchaseDetailsController = Get.put(PurchaseController());
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  @override
  Widget build(BuildContext context) {
    return RawScrollbar(
      thickness: 3,
      thumbColor: AppColors.primary,
      radius: const Radius.circular(AppSizes.cardCornerRadius),
      child: SmartRefresher(
        controller: refreshController,
        enablePullDown: false,
        enablePullUp: true,
        onRefresh: () {
          refreshController.loadComplete();
        },
        onLoading: () async {
          purchaseDetailsController.purDetLimit.value += 40;
          await purchaseDetailsController.getAllPurchaesTicketDetails(
              orderID: widget.orderId);
          refreshController.loadComplete();
        },
        footer: const CustomFooterWidget(),
        child: ListView.builder(
          itemCount:
              purchaseDetailsController.purchaseHistoryDetailsList.length,
          itemBuilder: (context, index) {
            var item =
                purchaseDetailsController.purchaseHistoryDetailsList[index];
            return PurchaseDetilsCardWidget(
              itemIndex: index,
              ticketId: item.ticketId ?? "",
            );
          },
        ),
      ),
    );
  }
}
