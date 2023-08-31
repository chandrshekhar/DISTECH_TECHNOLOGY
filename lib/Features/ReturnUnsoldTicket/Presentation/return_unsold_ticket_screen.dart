import 'package:distech_technology/Commons/app_colors.dart';
import 'package:distech_technology/Controller/Ticket%20Controller/sold_ticket_controller.dart';
import 'package:distech_technology/Controller/Timer%20Controller/timer_controller.dart';
import 'package:distech_technology/Features/Dashboard/Presentation/drop_down.dart';
import 'package:distech_technology/Widgets/full_button.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../Api/api_provider.dart';
import '../../../Commons/app_icons.dart';
import '../../../Commons/app_sizes.dart';
import '../../../Controller/Return Ticket Controller/return_ticket.dart';
import '../../../Utils/date_time_format.dart';
import '../../../Widgets/custom_divider.dart';
import '../../../Widgets/custom_text_field.dart';
import '../../Dashboard/Presentation/dashboard_list.dart';

class ReturnUnsoldTicket extends StatefulWidget {
  const ReturnUnsoldTicket({Key? key}) : super(key: key);
  @override
  State<ReturnUnsoldTicket> createState() => _ReturnUnsoldTicketState();
}

class _ReturnUnsoldTicketState extends State<ReturnUnsoldTicket> {
  final soldTicketController = Get.put(SoldTicketController());
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  DateTime selectedDate = DateTime.now();
  String? formatedDate;
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
        soldTicketzcontroller.getAllTicket(
            date: formatedDate,
            semNumber: soldTicketzcontroller.semNumber.value,
            search: soldTicketzcontroller.searchText.value);
        getMyreturnController.getAllReturnTicket(dateTime: formatedDate);
      });
    }
  }

  bool countLimit(bool selectedValue) {
    if (((getMyreturnController.returnCount.value -
                    soldTicketzcontroller.selectedSoldTicket.length) <=
                0 ||
            timerController.countdown.value == "0:00:00") &&
        selectedValue == true) {
      return false;
    }
    return true;
  }

  final soldTicketzcontroller = Get.put(SoldTicketController());
  final timerController = Get.put(TimerController());
  //Variable Declarations
  final TextEditingController _searchController = TextEditingController();
  bool isSelected = false;
  final getMyreturnController = Get.put(GetMyReturnController());
  @override
  void initState() {
    super.initState();
    soldTicketzcontroller.selectedSoldTicket.clear();
    soldTicketzcontroller.getAllTicket();
    soldTicketzcontroller.searchText.value = '';
    soldTicketzcontroller.semNumber.value = 0;
    getMyreturnController.getAllReturnTicket();
    soldTicketController.dropDownValue.value = 10;
    soldTicketzcontroller.limit.value = 10;
  }

  @override
  void dispose() {
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
          padding: const EdgeInsets.all(AppSizes.kDefaultPadding),
          child: Column(
            children: [
              const SizedBox(
                height: AppSizes.kDefaultPadding,
              ),
              Container(
                height: AppSizes.buttonHeight,
                decoration: BoxDecoration(
                  color: AppColors.primaryBg,
                  borderRadius:
                      BorderRadius.circular(AppSizes.cardCornerRadius / 2),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 6,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.kDefaultPadding / 2),
                        child: Text(
                          'You can return 5% of your total unsold tickets',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontWeight: FontWeight.w400, fontSize: 14),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.center,
                        height: AppSizes.buttonHeight,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(
                              AppSizes.cardCornerRadius / 2),
                        ),
                        child: Obx(() {
                          if (getMyreturnController
                              .isReturnTicketLoading.value) {
                            return const Center(
                                child: CircularProgressIndicator.adaptive());
                          }

                          return Text(
                              "${getMyreturnController.returnCount.value - soldTicketzcontroller.selectedSoldTicket.length}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.white));
                        }),
                      ),
                    ),
                    const SizedBox(width: 10),
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
              ),
              const SizedBox(
                height: AppSizes.kDefaultPadding * 1.2,
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
                          soldTicketzcontroller.searchTextSave(value);
                        } else {
                          soldTicketzcontroller.searchText("");
                        }
                        soldTicketzcontroller.getAllTicket(
                            search: soldTicketzcontroller.searchText.value,
                            semNumber: soldTicketzcontroller.semNumber.value,
                            date: formatedDate);
                      },
                      maxLines: 1,
                      minLines: 1,
                      isBorder: false,
                    ),
                  ),
                  const SizedBox(
                    width: AppSizes.kDefaultPadding / 1.5,
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
                  //                 selectedDate: formatedDate!,
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
                        padding: const EdgeInsets.all(
                            AppSizes.kDefaultPadding / 1.5),
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
                height: AppSizes.kDefaultPadding,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.36,
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppSizes.kDefaultPadding),
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
                                  flex: 2,
                                  child: Transform.scale(
                                    scale: 1.3,
                                    child: Obx(() => Checkbox(
                                          value: (timerController
                                                      .countdown.value ==
                                                  "0:00:00")
                                              ? false
                                              : soldTicketController
                                                  .isAllSelect.value,
                                          onChanged: (value) {
                                            setState(() {});
                                            soldTicketController
                                                .isAllSelect.value = value!;
                                            if (value == true &&
                                                (timerController
                                                        .countdown.value !=
                                                    "0:00:00")) {
                                              for (int i = 0;
                                                  i <
                                                      getMyreturnController
                                                          .returnCount.value;
                                                  i++) {
                                                soldTicketController
                                                    .checkedBoxClicked(
                                                        soldTicketController
                                                            .allTicketList[i]
                                                            .sId!,
                                                        true);
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
                                          },
                                        )),
                                  ),
                                ),
                                // Expanded(
                                //     flex: 1,
                                //     child: Align(
                                //       alignment: Alignment.centerRight,
                                //       child: SizedBox(
                                //         width: 10,
                                //         height: 10,
                                //         child: Checkbox(
                                //           value: isSelected,
                                //           onChanged: (bool? value) {
                                //             setState(() {
                                //               isSelected = value!;
                                //             });
                                //           },
                                //         ),
                                //       ),
                                //     )),
                              ],
                            ),
                          ),
                          const CustomDivider(),
                          Container(
                            constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.28,
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: Obx(() =>
                                soldTicketController.allTicketList.isNotEmpty
                                    ? DashboardListWidget(
                                        date: formatedDate ?? "",
                                        isSelected: isSelected,
                                        dashBoard: false,
                                      )
                                    : soldTicketController
                                                .isAllTicketLoading.value ==
                                            true
                                        ? const Center(
                                            child: CircularProgressIndicator
                                                .adaptive(),
                                          )
                                        : const Center(
                                            child: Text("No tickets found"))),
                          )
                        ],
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: AppSizes.kDefaultPadding * 1.2,
                        ),
                        Obx(() => FullButton(
                              label: 'Return Unsold',
                              onPressed: (soldTicketzcontroller
                                          .selectedSoldTicket.isEmpty ||
                                      timerController.countdown.value ==
                                          "0:00:00")
                                  ? () {}
                                  : () async {
                                      if (soldTicketzcontroller
                                          .selectedSoldTicket.isNotEmpty) {
                                        var res = await ApiProvider()
                                            .retunTicketUnsold(
                                                soldTicketzcontroller
                                                    .selectedSoldTicket,
                                                formatedDate!);
                                        await getMyreturnController
                                            .getAllReturnTicket(
                                                dateTime: formatedDate);
                                        Get.snackbar(
                                            "Successful", res['message'],
                                            backgroundColor: AppColors.white,
                                            colorText: Colors.green,
                                            isDismissible: true,
                                            snackPosition:
                                                SnackPosition.BOTTOM);
                                        _searchController.clear();
                                        soldTicketzcontroller.selectedSoldTicket
                                            .clear();

                                        await soldTicketzcontroller
                                            .getAllTicket(date: formatedDate);
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
                              bgColor: (soldTicketzcontroller
                                          .selectedSoldTicket.isEmpty ||
                                      timerController.countdown.value ==
                                          "0:00:00")
                                  ? AppColors.lightGrey
                                  : AppColors.secondary,
                            )),
                        const SizedBox(
                          height: AppSizes.kDefaultPadding * 1.2,
                        ),
                        Text(
                          '** You can return 5% of your total unsold tickets',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: AppColors.secondary),
                        ),
                        const SizedBox(height: 5)
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
  }
}
