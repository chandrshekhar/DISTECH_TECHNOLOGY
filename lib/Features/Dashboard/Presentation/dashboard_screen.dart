import 'dart:async';

import 'package:distech_technology/Controller/Ticket%20Controller/sold_ticket_controller.dart';
import 'package:distech_technology/Controller/Timer%20Controller/timer_controller.dart';
import 'package:distech_technology/Features/Dashboard/Presentation/dashboard_list.dart';
import 'package:distech_technology/Features/Dashboard/Presentation/drop_down.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../Commons/app_colors.dart';
import '../../../Commons/app_icons.dart';
import '../../../Commons/app_sizes.dart';
import '../../../Widgets/custom_divider.dart';
import '../../../Widgets/custom_text_field.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool isSelected = false;
  final soldTicketController = Get.put(SoldTicketController());
  final timerController = Get.put(TimerController());

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  @override
  void initState() {
    // searchedList = ticketItemList;
    soldTicketController.selectedSoldTicket.clear();
    soldTicketController.searchText.value = '';
    soldTicketController.semNumber.value = 0;
    soldTicketController.limit.value = 10;
    soldTicketController.dropDownValue.value = 10;
    soldTicketController.getAllTicket();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
              // SizedBox(
              //   height: AppSizes.kDefaultPadding,
              // ),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 3,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text:
                                '${soldTicketController.allticketCount.value}\n',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Available Tickets to Sell ',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                              ),
                            ],
                          ),
                        )
                        // child: Text(
                        //   '${soldTicketController.allticketCount.value}\nAvailable Tickets to Sell ',
                        //   textAlign: TextAlign.center,
                        //   style: Theme.of(context)
                        //       .textTheme
                        //       .headlineSmall!
                        //       .copyWith(
                        //           fontWeight: FontWeight.w400, fontSize: 15),
                        // ),
                        ),
                    // Expanded(
                    //   flex: 1,
                    //   child: InkWell(
                    //     onTap: () {
                    //       if (soldTicketController.formatedDate.isNotEmpty) {
                    //         soldTicketController.scanBarcodeNormal(context);
                    //       } else {
                    //         Get.snackbar("Error!", "Please select date",
                    //             backgroundColor: Colors.red,
                    //             colorText: Colors.white,
                    //             isDismissible: true,
                    //             snackPosition: SnackPosition.BOTTOM);
                    //       }
                    //     },
                    //     child: Container(
                    //       padding: EdgeInsets.all(AppSizes.kDefaultPadding / 2),
                    //       height: AppSizes.buttonHeight,
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(
                    //               AppSizes.cardCornerRadius / 2),
                    //           border: Border.all(color: AppColors.bg)),
                    //       child: Image.asset(
                    //         AppIcons.barCode,
                    //         width: 25,
                    //         height: 25,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          soldTicketController.selectDate(context);
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
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: AppDropDown(
                          onChanged: (value) async {
                            soldTicketController.limit.value = value;
                            soldTicketController.dropDownValue.value = value;
                            await soldTicketController.getAllTicket(
                                date: soldTicketController.formatedDate.value,
                                search: soldTicketController.searchText.value,
                                semNumber:
                                    soldTicketController.semNumber.value);
                          },
                          list: soldTicketController.selectedValueList),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: CustomTextField(
                      controller: _searchController,
                      hintText: 'Search',
                      prefixIcon: const Icon(
                        EvaIcons.searchOutline,
                        color: AppColors.primary,
                        size: 20,
                      ),
                      onChanged: (value) {
                        if (value.toString().isNotEmpty) {
                          soldTicketController.searchTextSave(value);
                        } else {
                          soldTicketController.searchText("");
                        }
                        Timer(const Duration(milliseconds: 1000), () {
                          soldTicketController.getAllTicket(
                              search: soldTicketController.searchText.value,
                              semNumber: soldTicketController.semNumber.value,
                              date: soldTicketController.formatedDate.value);
                        });
                      },
                      maxLines: 1,
                      minLines: 1,
                      isBorder: false,
                    ),
                  ),
                ],
              ),
              // const SizedBox(
              //   height: 15,
              // ),
              // Row(
              //   children: [
              //     const Spacer(),
              //     Obx(() => Text(
              //           '${soldTicketController.selectedSoldTicket.length.toString()} item Selected',
              //           style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              //               color: AppColors.primary,
              //               fontWeight: FontWeight.w500),
              //         )),
              //   ],
              // ),
              const SizedBox(
                height: 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                                vertical: AppSizes.kDefaultPadding / 2),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'SL No',
                                    textAlign: TextAlign.start,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: AppColors.darkGrey
                                                .withOpacity(0.8),
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
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Status',
                                    textAlign: TextAlign.start,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: AppColors.darkGrey
                                                .withOpacity(0.8),
                                            fontWeight: FontWeight.w500),
                                  ),
                                ),

                                // Expanded(
                                //   flex: 1,
                                //   child: Transform.scale(
                                //     scale: 1.3,
                                //     child: Obx(() => Checkbox(
                                //           value: soldTicketController
                                //               .isAllSelect.value,
                                //           onChanged: (value) {
                                //             soldTicketController
                                //                 .isAllSelect.value = value!;
                                //             if (value == true) {
                                //               for (var element
                                //                   in soldTicketController
                                //                       .allTicketList) {
                                //                 soldTicketController
                                //                     .checkedBoxClicked(
                                //                         element.sId!, true);
                                //               }
                                //             } else {
                                //               for (var element
                                //                   in soldTicketController
                                //                       .allTicketList) {
                                //                 soldTicketController
                                //                     .checkedBoxClicked(
                                //                         element.sId!, false);
                                //               }
                                //             }
                                //             setState(() {});
                                //           },
                                //         )),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          const CustomDivider(),
                          Container(
                            alignment: Alignment.center,
                            constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.45,
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: Obx(() => soldTicketController
                                    .allTicketList.isNotEmpty
                                ? DashboardListWidget(
                                    date:
                                        soldTicketController.formatedDate.value,
                                    isSelected: isSelected,
                                  )
                                : soldTicketController
                                            .isAllTicketLoading.value ==
                                        true
                                    ? const Center(
                                        child: CircularProgressIndicator
                                            .adaptive(),
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
