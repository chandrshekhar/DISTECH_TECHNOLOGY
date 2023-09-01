
import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Controller/Ticket%20Controller/sold_ticket_controller.dart';
import 'package:distech_technology/Features/Dashboard/Presentation/dashboard_list.dart';
import 'package:distech_technology/Features/Dashboard/Presentation/drop_down.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../Commons/app_colors.dart';
import '../../../Commons/app_icons.dart';
import '../../../Commons/app_sizes.dart';
import '../../../Utils/date_time_format.dart';
import '../../../Widgets/custom_divider.dart';
import '../../../Widgets/custom_text_field.dart';
import '../../../Widgets/full_button.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  //Variable Declarations
  DateTime selectedDate = DateTime.now();
  String formatedDate = '';
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(3000, 8),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        formatedDate = formatDate(date: picked, formatType: "yyyy-MM-dd");
        soldTicketController.getAllTicket(
            date: formatedDate,
            semNumber: soldTicketController.semNumber.value);
      });
    }
  }

  final TextEditingController _searchController = TextEditingController();
  bool isSelected = false;
  final soldTicketController = Get.put(SoldTicketController());
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
              Row(
                children: [
                  Obx(() => Text(
                        'My All Ticket (${soldTicketController.allticketCount.value})',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontWeight: FontWeight.w400),
                      )),
                  const Spacer(),
                  AppDropDown(
                      onChanged: (value) async {
                        soldTicketController.limit.value = value;
                        soldTicketController.dropDownValue.value = value;
                        await soldTicketController.getAllTicket(
                            date: formatedDate,
                            search: soldTicketController.searchText.value,
                            semNumber: soldTicketController.semNumber.value);
                      },
                      list: soldTicketController.selectedValueList)
                ],
              ),
              SizedBox(
                height: AppSizes.kDefaultPadding,
              ),
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
                        soldTicketController.getAllTicket(
                            search: soldTicketController.searchText.value,
                            semNumber: soldTicketController.semNumber.value,
                            date: formatedDate);
                      },
                      maxLines: 1,
                      minLines: 1,
                      isBorder: false,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  // Expanded(
                  //   flex: 1,
                  //   child: InkWell(
                  //     onTap: () {
                  //       showDialog(
                  //           context: context,
                  //           builder: (context) {
                  //             return AlertDialog(
                  //               content: FilterDialog(
                  //                 selectedDate: formatedDate,
                  //               ),
                  //             );
                  //           });
                  //     },
                  //     child: Container(
                  //       padding: const EdgeInsets.all(
                  //           AppSizes.kDefaultPadding / 1.5),
                  //       height: AppSizes.buttonHeight + 4,
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(
                  //               AppSizes.cardCornerRadius / 2),
                  //           border: Border.all(color: AppColors.bg)),
                  //       child: Image.asset(
                  //         AppIcons.filterIcon,
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
                        _selectDate(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(AppSizes.kDefaultPadding / 1.5),
                        height: AppSizes.buttonHeight + 4,
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
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const Spacer(),
                  Obx(() => Text(
                        '${soldTicketController.selectedSoldTicket.length.toString()} item Selected',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500),
                      )),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.37,
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
                                vertical: 5),
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
                                    flex: 1,
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
                                Expanded(
                                  flex: 1,
                                  child: Transform.scale(
                                    scale: 1.3,
                                    child: Obx(() => Checkbox(
                                          value: soldTicketController
                                              .isAllSelect.value,
                                          onChanged: (value) {
                                            soldTicketController
                                                .isAllSelect.value = value!;
                                            if (value == true) {
                                              for (var element
                                                  in soldTicketController
                                                      .allTicketList) {
                                                soldTicketController
                                                    .checkedBoxClicked(
                                                        element.sId!, true);
                                              }
                                            } else {
                                              for (var element
                                                  in soldTicketController
                                                      .allTicketList) {
                                                soldTicketController
                                                    .checkedBoxClicked(
                                                        element.sId!, false);
                                              }
                                            }
                                            setState(() {});
                                          },
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const CustomDivider(),
                          Container(
                            alignment: Alignment.center,
                            constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.27,
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: Obx(() =>
                                soldTicketController.allTicketList.isNotEmpty
                                    ? DashboardListWidget(
                                        date: formatedDate,
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
                  SafeArea(
                    child: Column(
                      children: [
                        SizedBox(
                          height: AppSizes.kDefaultPadding * 1.2,
                        ),
                        Obx(() => FullButton(
                              label: 'Mark sold',
                              bgColor: soldTicketController
                                      .selectedSoldTicket.isEmpty
                                  ? AppColors.lightGrey
                                  : AppColors.primary,
                              onPressed: soldTicketController
                                      .selectedSoldTicket.isEmpty
                                  ? () {}
                                  : () async {
                                      if (soldTicketController
                                          .selectedSoldTicket.isNotEmpty) {
                                        var res =
                                            await ApiProvider().soldTciket(
                                          soldTicketController
                                              .selectedSoldTicket,
                                          formatedDate,
                                        );

                                        Get.snackbar(
                                            "Successful", res['message'],
                                            backgroundColor: AppColors.white,
                                            colorText: Colors.green,
                                            isDismissible: true,
                                            snackPosition:
                                                SnackPosition.BOTTOM);
                                        await soldTicketController.getAllTicket(
                                          date: formatedDate,
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
                                            snackPosition:
                                                SnackPosition.BOTTOM);
                                      }
                                    },
                            )),
                        SizedBox(
                          height: AppSizes.kDefaultPadding * 1.2,
                        ),
                        Text(
                          "** Once you mark as a sold it can't be modified later",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: AppColors.secondary),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
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
