import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Controller/Ticket%20Controller/sold_ticket_controller.dart';
import 'package:distech_technology/Controller/Timer%20Controller/timer_controller.dart';
import 'package:distech_technology/Features/ReturnUnsoldTicket/widgets/return_ticket_widget.dart';
import 'package:distech_technology/Widgets/full_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../Commons/app_colors.dart';
import '../../../Commons/app_icons.dart';
import '../../../Commons/app_sizes.dart';
import '../../../Controller/Return Ticket Controller/return_ticket.dart';
import '../../../Widgets/custom_divider.dart';

class ReturnAllTicketsScreen extends StatefulWidget {
  const ReturnAllTicketsScreen({Key? key}) : super(key: key);
  @override
  State<ReturnAllTicketsScreen> createState() => _ReturnAllTicketsScreenState();
}

class _ReturnAllTicketsScreenState extends State<ReturnAllTicketsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final soldTicketController = Get.put(SoldTicketController());
  final timerController = Get.put(TimerController());
  final getMyreturnController = Get.put(GetMyReturnController());

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //Hide the onscreen keyboard on outside touch.
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My All Ticket (${soldTicketController.allticketCount.value})',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontWeight: FontWeight.w400, fontSize: 18),
                  ),
                  InkWell(
                    onTap: () {
                      getMyreturnController.selectDate(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(AppSizes.kDefaultPadding / 2),
                      height: AppSizes.buttonHeight,
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
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.5,
                ),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(AppSizes.cardCornerRadius / 2),
                  border: Border.all(color: AppColors.bg),
                ),
                child: Container(
                  color: AppColors.primaryBg,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.kDefaultPadding,
                        ),
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
                                        color:
                                            AppColors.darkGrey.withOpacity(0.8),
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
                                          color: AppColors.darkGrey
                                              .withOpacity(0.8),
                                          fontWeight: FontWeight.w500),
                                )),
                            // Expanded(
                            //     flex: 1,
                            //     child: Text(
                            //       'Bar Code',
                            //       textAlign: TextAlign.start,
                            //       style: Theme.of(context)
                            //           .textTheme
                            //           .bodyMedium!
                            //           .copyWith(
                            //               color: AppColors.darkGrey
                            //                   .withOpacity(0.8),
                            //               fontWeight: FontWeight.w500),
                            //     )),
                            Transform.scale(
                              scale: 1.3,
                              child: Obx(() => Checkbox(
                                    value: getMyreturnController
                                        .isAllTicketSelected.value,
                                    onChanged: (value) {
                                      if (timerController.countdown.value !=
                                              "0:00:00" &&
                                          soldTicketController
                                              .allTicketList.isNotEmpty) {
                                        getMyreturnController
                                            .isAllTicketSelected.value = value!;
                                        if (value == true) {
                                          for (var element
                                              in soldTicketController
                                                  .allTicketList) {
                                            getMyreturnController
                                                .checkedBoxClickedOnReturn(
                                                    element.sId!, true);
                                            getMyreturnController
                                                .selectedListForReturn
                                                .add(element.sId!);
                                          }
                                        } else {
                                          for (var element
                                              in soldTicketController
                                                  .allTicketList) {
                                            getMyreturnController
                                                .checkedBoxClickedOnReturn(
                                                    element.sId!, false);
                                            getMyreturnController
                                                .selectedListForReturn
                                                .clear();
                                          }
                                        }
                                      }
                                    },
                                  )),
                            ),
                          ],
                        ),
                      ),
                      const CustomDivider(),
                      Container(
                        alignment: Alignment.center,
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.43,
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Obx(() => soldTicketController
                                .allTicketList.isNotEmpty
                            ? ReturnTicketListWidget(
                                date: soldTicketController.formatedDate.value,
                              )
                            : soldTicketController.isAllTicketLoading.value ==
                                    true
                                ? const Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  )
                                : const Text(
                                    "No tickets found",
                                    style: TextStyle(fontSize: 15),
                                  )),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: AppSizes.kDefaultPadding),
              SafeArea(
                child: Obx(() => FullButton(
                      label: 'Return Unsold',
                      onPressed: (getMyreturnController
                                  .selectedListForReturn.isEmpty ||
                              timerController.countdown.value == "0:00:00")
                          ? () {}
                          : () async {
                              if (getMyreturnController
                                  .selectedListForReturn.isNotEmpty) {
                                var res = await ApiProvider().retunTicketList(
                                    getMyreturnController.selectedListForReturn,
                                    getMyreturnController.formatedDate.value,
                                    timerController.slotId.value);
                                if (res['success'] == true) {
                                  await getMyreturnController
                                      .getAllReturnTicket(
                                          dateTime: getMyreturnController
                                              .formatedDate.value);
                                  Get.snackbar("Successful", res['message'],
                                      backgroundColor: AppColors.white,
                                      colorText: Colors.green,
                                      isDismissible: true,
                                      snackPosition: SnackPosition.TOP);
                                  getMyreturnController.clearText();
                                  getMyreturnController.validateTicketsList
                                      .clear();
                                  getMyreturnController
                                      .isAllTicketSelected.value = false;
                                  getMyreturnController.selectedListForReturn
                                      .clear();

                                  await soldTicketController.getAllTicket(
                                      date: getMyreturnController
                                          .formatedDate.value);
                                } else {
                                  Get.snackbar("Error", "res.error".toString(),
                                      backgroundColor: AppColors.black,
                                      colorText: Colors.white,
                                      isDismissible: true,
                                      snackPosition: SnackPosition.TOP);
                                }
                              }
                            },
                      bgColor: (getMyreturnController
                                  .selectedListForReturn.isEmpty ||
                              timerController.countdown.value == "0:00:00")
                          ? AppColors.lightGrey
                          : AppColors.secondary,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
