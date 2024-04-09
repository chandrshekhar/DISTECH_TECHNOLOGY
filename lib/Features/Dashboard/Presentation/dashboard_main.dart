import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:distech_technology/Api/urls.dart';
import 'package:distech_technology/Commons/app_colors.dart';
import 'package:distech_technology/Commons/app_icons.dart';
import 'package:distech_technology/Controller/Ticket%20Controller/sold_ticket_controller.dart';
import 'package:distech_technology/Controller/Ticket%20Controller/sold_ticket_list_controller.dart';
import 'package:distech_technology/Controller/Timer%20Controller/app_strate_controller.dart';
import 'package:distech_technology/Features/Result/Presentation/result_screen.dart';
import 'package:distech_technology/Features/Sale%20Tickets/Controller/sale_tickets_controller.dart';
import 'package:distech_technology/Utils/date_time_format.dart';
import 'package:distech_technology/Widgets/custom_text_field.dart';
import 'package:distech_technology/Widgets/full_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../Controller/Timer Controller/timer_controller.dart';
import '../../Vew Prizes/Controller/prize_controller.dart';
import '../../Vew Prizes/Presentation/pwt_sold_ticket.dart';

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
  final appStateController = Get.put(AppStateController());
  final prizeController = Get.put(PrizesController());
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
        title: "Select Draw Slot",
        desc: 'This is a description.',
        body: Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
          child: Obx(() => timerController.drawModel.value.data != null &&
                  timerController.drawModel.value.data!.isNotEmpty
              ? Column(
                  children: [
                    const Text(
                      "Select Draw Slot",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: List.generate(
                        timerController.drawModel.value.data!.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: ListTile(
                            selected: true,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side:
                                    const BorderSide(color: AppColors.primary)),
                            onTap: () {
                              timerController.intialSlot.value = timerController
                                      .drawModel.value.data?[index].name ??
                                  "";
                              timerController.slotId.value = timerController
                                      .drawModel.value.data?[index].sId ??
                                  "";
                              timerController.getServerTime();
                              // soldTicketController.getAllTicket();
                              // soldTicketListController.getSoldTicketList();
                              getMyDashboardController.getMydashboard();
                              appStateController
                                  .callAppState(Urls.setActiveState);
                              Navigator.pop(context);
                            },
                            title: Text(
                              " ${timerController.drawModel.value.data?[index].name} (${formatTime(timerController.drawModel.value.data?[index].drawTime ?? "")})",
                              style: const TextStyle(
                                  color: AppColors.primary, fontSize: 17),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : const Center(child: CircularProgressIndicator.adaptive())),
        ),
      ).show();
      getMyDashboardController.isPopupShowing.value = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // prizeController.selectDateForCheckPrizes(context);
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
                          Expanded(
                            child: Text(
                              'Selected Date',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: CustomTextField(
                              height: MediaQuery.of(context).size.height * 0.06,
                              readOnly: true,
                              onTap: () async {
                                getMyDashboardController
                                    .selectDateForCheckPrizes(context);
                              },
                              controller:
                                  prizeController.pwtDateController.value,
                              suffixIcon: const Icon(Icons.date_range),
                            ),
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
                                .userTicketCounts?.ticketsCount?.total
                                .toString() ??
                            "0",
                        date: soldTicketController.formatedDate.toString(),
                        title: "Purchased Tickets",
                        color: const Color(0xFFFFBF1C),
                        imagePath: AppIcons.soldTicket),
                    // scanCode(context),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(
                    //         AppSizes.cardCornerRadius / 2),
                    //     border: Border.all(color: AppColors.bg),
                    //   ),
                    //   child: Container(
                    //     color: AppColors.primaryBg,
                    //     child: Column(
                    //       children: [
                    //         // const HeaderListWidget(),
                    //         SizedBox(
                    //           width: MediaQuery.of(context).size.width,
                    //           height: MediaQuery.of(context).size.height * 0.36,
                    //           // child: AddedTicketListWidget(),
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Row(
                      children: [
                        Expanded(
                          child: FullButton(
                              label: "View My Prize",
                              bgColor: AppColors.primary,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PwtSoldScreen(
                                              isComminFromDashboard: true,
                                            )));
                              }),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: FullButton(
                            label: 'Result',
                            bgColor: AppColors.primary,
                            onPressed: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ResultScreen(
                                            isComminFromDashboard: true,
                                          )));
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
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
}



/*   if (saleTicketController
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
                                  } */