import 'package:distech_technology/Controller/Timer%20Controller/timer_controller.dart';
import 'package:distech_technology/Features/Profile/Presentation/profile_screen.dart';
import 'package:distech_technology/Features/PurchaseHistory/Presentation/purchase_detils_list_widget.dart';
import 'package:distech_technology/Utils/app_helper.dart';
import 'package:distech_technology/Utils/date_time_format.dart';
import 'package:distech_technology/Widgets/custom_app_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Commons/app_colors.dart';
import '../../../Commons/app_sizes.dart';
import '../../../Controller/Purchaes Controller/purchaes_history_controller.dart';
import '../../../Widgets/custom_divider.dart';
import '../../../Widgets/custom_text_field.dart';

class PurchaesDetailsScreen extends StatefulWidget {
  final String orderID;
  final DateTime dateTime;
  const PurchaesDetailsScreen(
      {Key? key, required this.orderID, required this.dateTime})
      : super(key: key);
  @override
  State<PurchaesDetailsScreen> createState() => _PurchaesDetailsScreenState();
}

class _PurchaesDetailsScreenState extends State<PurchaesDetailsScreen> {
  //Variable Declarations
  final TextEditingController _searchController = TextEditingController();
  bool isSelected = false;
  // final soldTicketController = Get.put(SoldTicketController());

  final purchaseHistoryTicketController = Get.put(PurchaseController());
  final timerController = Get.put(TimerController());

  @override
  void initState() {
    super.initState();
    purchaseHistoryTicketController.purchaseHistoryDetailsList.clear();
    purchaseHistoryTicketController.purDetLimit.value = 40;
    purchaseHistoryTicketController.getAllPurchaesTicketDetails(
        orderID: widget.orderID);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Purchase Detail ${formateDateddMMyyyy(widget.dateTime)}",
        autoImplyLeading: false,
        leadingIcon: EvaIcons.arrowIosBack,
        leadingIconPressed: () => Navigator.pop(context),
        actions: [
          GestureDetector(
            onTap: () => context.push(const ProfileScreen()),
            child: Padding(
              padding: EdgeInsets.only(right: AppSizes.kDefaultPadding),
              child: const CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.white,
                foregroundImage: NetworkImage(
                  'https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg?w=2000',
                ),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: GestureDetector(
          onTap: () {
            //Hide the onscreen keyboard on outside touch.
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Padding(
            padding: EdgeInsets.all(AppSizes.kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Obx(() => Text(
                //       'My All Ticket (${soldTicketController.allTicketList.length})',
                //       style: Theme.of(context)
                //           .textTheme
                //           .headlineSmall!
                //           .copyWith(fontWeight: FontWeight.w400),
                //     )),
                // const SizedBox(
                //   height: AppSizes.kDefaultPadding,
                // ),
                CustomTextField(
                  controller: _searchController,
                  hintText: 'Search',
                  prefixIcon: const Icon(
                    EvaIcons.searchOutline,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  onChanged: (value) {
                    // if (value.toString().isNotEmpty) {
                    //   soldTicketController.searchTextSave(value);
                    // } else {
                    //   soldTicketController.searchText("");
                    // }
                    // soldTicketController.getAllTicket(
                    //     search: soldTicketController.searchText.value,
                    //     semNumber: soldTicketController.semNumber.value);
                  },
                  maxLines: 1,
                  minLines: 1,
                  isBorder: false,
                ),
                SizedBox(
                  height: AppSizes.kDefaultPadding / 1.5,
                ),
                Container(
                  color: AppColors.primaryBg,
                  child: Padding(
                    padding: EdgeInsets.all(AppSizes.kDefaultPadding),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'SL No',
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: AppColors.darkGrey.withOpacity(0.8),
                                    fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: Text(
                              'Ticket No',
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color:
                                          AppColors.darkGrey.withOpacity(0.8),
                                      fontWeight: FontWeight.w500),
                            )),

                        // Expanded(
                        //     flex: 2,
                        //     child: Text(
                        //       'SEM',
                        //       textAlign: TextAlign.center,
                        //       style: Theme.of(context)
                        //           .textTheme
                        //           .bodyMedium!
                        //           .copyWith(
                        //               color: AppColors.darkGrey
                        //                   .withOpacity(0.8),
                        //               fontWeight: FontWeight.w500),
                        //     )),
                      ],
                    ),
                  ),
                ),
                const CustomDivider(),
                Obx(() => purchaseHistoryTicketController
                        .purchaseHistoryDetailsList.isNotEmpty
                    ? Expanded(
                        child: PurchaseDetailsListWidget(
                          orderId: widget.orderID,
                        ),
                      )
                    : purchaseHistoryTicketController
                                .isPurchaseDetailsLoading.value ==
                            true
                        ? Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.35),
                            child: const Center(
                                child: CircularProgressIndicator.adaptive()),
                          )
                        : Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.35),
                            child:
                                const Center(child: Text("No tickets found")),
                          )),
              ],
            ),
          ),
        ),
      ),
    );
    //   Column(
    //   children: [
    //     const SizedBox(
    //       height: AppSizes.kDefaultPadding * 2,
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.symmetric(
    //           horizontal: AppSizes.kDefaultPadding),
    //       child: Column(
    //         children: [
    //           FullButton(label: 'View All Ticket', onPressed: () {}),
    //           const SizedBox(
    //             height: AppSizes.kDefaultPadding,
    //           ),
    //           FullButton(label: 'View Purchase History', onPressed: () {}),
    //           const SizedBox(
    //             height: AppSizes.kDefaultPadding,
    //           ),
    //           FullButton(label: 'View Sold Ticket', onPressed: () {}),
    //           const SizedBox(
    //             height: AppSizes.kDefaultPadding,
    //           ),
    //           FullButton(
    //               label: 'Return Unsold Ticket',
    //               bgColor: AppColors.secondary,
    //               onPressed: () {}),
    //         ],
    //       ),
    //     )
    //   ],
    // );
  }
}
