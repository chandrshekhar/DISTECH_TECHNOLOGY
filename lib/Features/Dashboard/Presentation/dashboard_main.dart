import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Commons/app_colors.dart';
import 'package:distech_technology/Commons/app_icons.dart';
import 'package:distech_technology/Commons/app_sizes.dart';
import 'package:distech_technology/Controller/Ticket%20Controller/sold_ticket_controller.dart';
import 'package:distech_technology/Controller/Ticket%20Controller/sold_ticket_list_controller.dart';
import 'package:distech_technology/Features/Sale%20Tickets/Controller/sale_tickets_controller.dart';
import 'package:distech_technology/Features/Sale%20Tickets/Widgets/add_ticket_list-widget.dart';
import 'package:distech_technology/Widgets/full_button.dart';
import 'package:distech_technology/Widgets/heade_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../Controller/Timer Controller/timer_controller.dart';
import '../../Sale Tickets/Widgets/scanner_card.dart';
import '../../Vew Prizes/Controller/prize_controller.dart';

class DashboardMainScreen extends StatefulWidget {
  const DashboardMainScreen({
    super.key,
  });

  @override
  State<DashboardMainScreen> createState() => _DashboardMainScreenState();
}

class _DashboardMainScreenState extends State<DashboardMainScreen> {
  ScrollController? controller = ScrollController();
  final soldTicketController = Get.put(SoldTicketController());
  final getMyDashboardController = Get.put(PrizesController());
  final timerController = Get.put(TimerController());
  final soldTicketListController = Get.put(SoldTicketListController());
  final saleTicketController = Get.put(SaleTicketsController());
  @override
  void initState() {
    getMyDashboardController.isPopupShowing.value == true
        ? null
        : getAlerttDialog();
    getMyDashboardController.getMydashboard();
    super.initState();
  }

  getAlerttDialog() async {
    await Future.delayed(const Duration(microseconds: 1000), () {
      AwesomeDialog(
              context: context,
              dialogType: DialogType.info,
              animType: AnimType.bottomSlide,
              dismissOnTouchOutside: false,
              body: Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
                child: Obx(() => timerController.drawModel.value.data != null &&
                        timerController.drawModel.value.data!.isNotEmpty
                    ? Column(
                        children: List.generate(
                          timerController.drawModel.value.data!.length,
                          (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: ListTile(
                              selected: true,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: const BorderSide(
                                      color: AppColors.primary)),
                              onTap: () {
                                timerController.intialSlot.value =
                                    timerController.drawModel.value.data?[index]
                                            .name ??
                                        "";
                                timerController.slotId.value = timerController
                                        .drawModel.value.data?[index].sId ??
                                    "";
                                timerController.getServerTime();
                                soldTicketController.getAllTicket();
                                soldTicketListController.getSoldTicketList();
                                getMyDashboardController.getMydashboard();
                                Navigator.pop(context);
                              },
                              title: Text(
                                timerController
                                        .drawModel.value.data?[index].name ??
                                    "".toString(),
                                style: const TextStyle(
                                    color: AppColors.primary, fontSize: 25),
                              ),
                            ),
                          ),
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator.adaptive())),
              ),
              titleTextStyle: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.w600, fontSize: 16))
          .show();
      getMyDashboardController.isPopupShowing.value = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        controller: controller,
        child: Obx(
          () => soldTicketController.isAllTicketLoading.value == true
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.3),
                    child: const CircularProgressIndicator.adaptive(),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Expanded(
                          //   child: Text(
                          //     'Total (${soldTicketController.allticketCount})',
                          //     style: Theme.of(context)
                          //         .textTheme
                          //         .headlineSmall!
                          //         .copyWith(
                          //             fontWeight: FontWeight.w400,
                          //             fontSize: 18),
                          //   ),
                          // ),
                          InkWell(
                            onTap: () async {
                              getMyDashboardController
                                  .selectDateForCheckPrizes(context);
                            },
                            child: Container(
                              padding:
                                  EdgeInsets.all(AppSizes.kDefaultPadding / 2),
                              height: AppSizes.buttonHeight,
                              // width: AppSizes.button * 3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      AppSizes.cardCornerRadius / 2),
                                  border: Border.all(color: AppColors.bg)),
                              child: Image.asset(
                                AppIcons.calenderIcon,
                                width: 25,
                                height: 25,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                    priceCard(
                        value: getMyDashboardController.getModeldashBoard.value
                                .userTicketCounts?.ticketsCount?.sold
                                .toString() ??
                            "0",
                        date: soldTicketController.formatedDate.toString(),
                        title: "Sold Tickets",
                        color: const Color(0xFF29C57F),
                        imagePath: AppIcons.prize),
                    priceCard(
                        value: getMyDashboardController.getModeldashBoard.value
                                .userTicketCounts?.ticketsCount?.returned
                                .toString() ??
                            "0",
                        date: soldTicketController.formatedDate.toString(),
                        title: "Unsold Tickets",
                        color: const Color(0xFFFF2E17),
                        imagePath: AppIcons.soldTicket),
                    priceCard(
                        value: getMyDashboardController.getModeldashBoard.value
                                .userTicketCounts?.ticketsCount?.total.toString() ??
                            "0",
                        date: soldTicketController.formatedDate.toString(),
                        title: "Purchase Tickets",
                        color: const Color(0xFFFFBF1C),
                        imagePath: AppIcons.soldTicket),
                    Text(
                      'Scan and Sale',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              height: 2),
                    ),
                    const SizedBox(height: 10),
                    scanCode(context),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppSizes.cardCornerRadius / 2),
                        border: Border.all(color: AppColors.bg),
                      ),
                      child: Container(
                        color: AppColors.primaryBg,
                        child: Column(
                          children: [
                            const HeaderListWidget(),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.36,
                              child: AddedTicketListWidget(),
                            )
                          ],
                        ),
                      ),
                    ),
                    Obx(() => FullButton(
                          label: 'Mark sold',
                          bgColor: saleTicketController
                                  .successReturnTicketList.isEmpty
                              ? AppColors.lightGrey
                              : AppColors.primary,
                          onPressed: saleTicketController
                                  .successReturnTicketList.isEmpty
                              ? () {}
                              : () async {
                                  if (saleTicketController
                                      .successReturnTicketList.isNotEmpty) {
                                    var res = await ApiProvider().soldTciket(
                                        saleTicketController
                                            .successReturnTicketList,
                                        timerController.slotId.value);
                                    log("pandey---> ${res.toString()}");
                                    if (res['success'] &&
                                        res['successList'].length > 0) {
                                      Get.snackbar(
                                          "Successful",
                                          res['successList'][0]['message']
                                              .toString(),
                                          backgroundColor: AppColors.white,
                                          colorText: Colors.green,
                                          isDismissible: true,
                                          snackPosition: SnackPosition.TOP);
                                      saleTicketController
                                          .successReturnTicketList
                                          .clear();
                                    } else {
                                      Get.snackbar(
                                          "Error!",
                                          res['failedList'][0]["message"]
                                              .toString(),
                                          backgroundColor: AppColors.white,
                                          colorText: Colors.red,
                                          isDismissible: true,
                                          snackPosition: SnackPosition.TOP);
                                    }

                                    await soldTicketController.getAllTicket(
                                      date: soldTicketController
                                          .formatedDate.value,
                                    );
                                    soldTicketController.limit.value =
                                        soldTicketController.limit.value;
                                    soldTicketController.selectedSoldTicket
                                        .clear();
                                  } else {
                                    Get.snackbar("Not response",
                                        "Your are not selected any ticket for mark as sold",
                                        backgroundColor: AppColors.black,
                                        colorText: Colors.white,
                                        isDismissible: true,
                                        snackPosition: SnackPosition.BOTTOM);
                                  }
                                },
                        )),
                  ],
                ),
        ),
      ),
    );
  }

  Widget scanCode(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Expanded(
                  child: ScannerCardWidget(
                    onTap: () async {
                      saleTicketController.scanBarCode(true);
                    },
                    title: "From Tickets",
                    subTitle: saleTicketController.fromTickets.value,
                  ),
                )),
            const SizedBox(width: 10),
            Obx(() => Expanded(
                  child: ScannerCardWidget(
                    onTap: () {
                      saleTicketController.scanBarCode(false);
                    },
                    title: "To Tickets",
                    subTitle: saleTicketController.toTickets.value,
                  ),
                )),
            const SizedBox(width: 5),
            Obx(
              () => InkWell(
                onTap: saleTicketController.fromTickets.value.isNotEmpty &&
                        saleTicketController.toTickets.value.isNotEmpty
                    ? () {
                        saleTicketController.validateSalesTickets(
                          slotId: timerController.slotId.value,
                          fromNumber: int.parse(saleTicketController
                              .fromTickets.value
                              .substring(2, 7)),
                          toNumber: int.parse(saleTicketController
                              .toTickets.value
                              .substring(2, 7)),
                          fromLetter1:
                              saleTicketController.fromTickets.value[0],
                          fromLetter2:
                              saleTicketController.fromTickets.value[1],
                          toLetter1: saleTicketController.toTickets.value[0],
                          toLetter2: saleTicketController.toTickets.value[1],
                        );
                      }
                    : null,
                child: Container(
                    margin: const EdgeInsets.only(right: 2),
                    width: AppSizes.buttonHeight,
                    height: MediaQuery.of(context).size.height * 0.055,
                    decoration: BoxDecoration(
                        color: saleTicketController
                                    .fromTickets.value.isNotEmpty &&
                                saleTicketController.toTickets.value.isNotEmpty
                            ? AppColors.primary
                            : AppColors.lightGrey,
                        borderRadius: BorderRadius.circular(
                            AppSizes.cardCornerRadius / 2),
                        border: Border.all(color: AppColors.bg)),
                    child: saleTicketController.isTicketValidating == true
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : const Icon(
                            Icons.add,
                            size: 20,
                            color: Colors.white,
                          )),
              ),
            )
          ],
        ),
        // manulField(context)
      ],
    );
  }

  Widget priceCard({
    required String value,
    String? date,
    String? title,
    required Color color,
    required String imagePath,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            imagePath,
            color: AppColors.white,
            height: 30,
            width: 30,
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: 0.5,
              height: 35,
              color: Colors.white),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "$title   ${date ?? ""}",
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
              const SizedBox(height: 5),
              Text(
                value,
                style: const TextStyle(
                    fontSize: 18,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget customTileCard(
  //     {String? title,
  //     required String subTitle,
  //     void Function()? onTap,
  //     String? icon}) {
  //   return Container(
  //     padding: EdgeInsets.all(AppSizes.cardCornerRadius),
  //     margin: const EdgeInsets.only(bottom: 7),
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius / 2),
  //         border: Border.all(color: AppColors.bg)),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Text.rich(
  //           TextSpan(
  //             children: [
  //               TextSpan(
  //                   text: '$title ',
  //                   style: const TextStyle(
  //                     fontSize: 16,
  //                   )),
  //               TextSpan(
  //                 text: subTitle.isNotEmpty ? "($subTitle)" : '',
  //                 style: const TextStyle(
  //                     fontWeight: FontWeight.w500, fontSize: 16),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Obx(() => newClaimController.fromTicketScaning.value ||
  //                 newClaimController.toTicketScaing.value
  //             ? const Center(
  //                 child: SizedBox(
  //                     height: 20,
  //                     width: 20,
  //                     child: CircularProgressIndicator.adaptive()),
  //               )
  //             : InkWell(
  //                 onTap: onTap,
  //                 child: Image.asset(
  //                   icon ?? "assets/icons/barcode-scanner.png",
  //                   width: 25,
  //                   height: 25,
  //                 ),
  //               )),
  //       ],
  //     ),
  //   );
  // }

  // Widget customTicketCard(ClaimModel claimModel) {
  //   return Container(
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(10), color: AppColors.primaryBg),
  //     margin: const EdgeInsets.symmetric(vertical: 5),
  //     padding: const EdgeInsets.all(10),
  //     child: Column(
  //       children: [
  //         Row(
  //           children: [
  //             Expanded(
  //               child: Text.rich(
  //                 TextSpan(
  //                   children: [
  //                     const TextSpan(
  //                       text: "From Ticket\n",
  //                       style: TextStyle(fontWeight: FontWeight.bold),
  //                     ),
  //                     TextSpan(
  //                       text: claimModel.fromTicket,
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             Expanded(
  //               child: Text.rich(
  //                 TextSpan(
  //                   children: [
  //                     const TextSpan(
  //                       text: "To Ticket\n",
  //                       style: TextStyle(fontWeight: FontWeight.bold),
  //                     ),
  //                     TextSpan(
  //                       text: claimModel.toTicket,
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         const SizedBox(
  //           height: 5,
  //         ),
  //         Row(
  //           children: [
  //             Expanded(
  //               child: Text.rich(
  //                 TextSpan(
  //                   children: [
  //                     const TextSpan(
  //                       text: "Total Ticket\n",
  //                       style: TextStyle(fontWeight: FontWeight.bold),
  //                     ),
  //                     TextSpan(
  //                       text: claimModel.totalTicket.toString(),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             Expanded(
  //               child: Text.rich(
  //                 TextSpan(
  //                   children: [
  //                     const TextSpan(
  //                       text: "Total Amount\n",
  //                       style: TextStyle(fontWeight: FontWeight.bold),
  //                     ),
  //                     TextSpan(
  //                       text: claimModel.totalAmount.toString(),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
