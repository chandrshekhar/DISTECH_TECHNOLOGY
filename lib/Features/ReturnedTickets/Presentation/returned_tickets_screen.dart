import 'dart:async';

import 'package:distech_technology/Features/ReturnedTickets/Widgets/return_ticket_card.dart';
import 'package:distech_technology/Widgets/custom_divider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Commons/app_colors.dart';
import '../../../Commons/app_sizes.dart';
import '../../../Controller/Return Ticket Controller/return_ticket.dart';
import '../../../Utils/date_time_format.dart';
import '../../../Widgets/custom_text_field.dart';

class ReturnedTicketScreen extends StatefulWidget {
  const ReturnedTicketScreen({Key? key}) : super(key: key);

  @override
  State<ReturnedTicketScreen> createState() => _ReturnedTicketScreenState();
}

class _ReturnedTicketScreenState extends State<ReturnedTicketScreen> {
  final getMyReturnController = Get.put(GetMyReturnController());

  //Variable Declarations
  final TextEditingController _searchController = TextEditingController();
  final dateEditingController =
      TextEditingController(text: formateDateddMMyyyy(DateTime.now()));
  // String formatedDate = '';
  DateTime selectedDate = DateTime.now();
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
        dateEditingController.text =
            formatDate(date: selectedDate, formatType: "dd-MM-yyyy");
        getMyReturnController.getAllReturnTicket(
          dateTime: formatDate(date: selectedDate, formatType: "yyyy-MM-dd"),
        );
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyReturnController.getAllReturnTicket(
        dateTime: formatDate(date: selectedDate, formatType: "yyyy-MM-dd"));
    // soldTicketListController.searchText.value = '';
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
              SizedBox(
                height: AppSizes.kDefaultPadding,
              ),
              Row(
                children: [
                  Obx(() => Expanded(
                        flex: 1,
                        child: Text(
                          '${context.tr("allReturnedTickets")} (${getMyReturnController.totalReturn.value})',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                          textAlign: TextAlign.center,
                        ).tr(),
                      )),
                  Expanded(
                      flex: 1,
                      child: CustomTextField(
                        height: MediaQuery.of(context).size.height * 0.06,
                        readOnly: true,
                        onTap: () async {
                          _selectDate(context);
                        },
                        controller: dateEditingController,
                        suffixIcon: const Icon(Icons.date_range),
                      )),
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
                      onChanged: (value) async {
                        Timer(const Duration(milliseconds: 5000), () {
                          if (value.toString().isNotEmpty) {
                            getMyReturnController.searchTextSave(value);
                          } else {
                            getMyReturnController.searchText("");
                          }
                          getMyReturnController.getAllReturnTicket(
                            dateTime: formatDate(
                                date: selectedDate, formatType: "yyyy-MM-dd"),
                            search: getMyReturnController.searchText.value,
                          );
                        });
                      },
                      maxLines: 1,
                      minLines: 1,
                      isBorder: false,
                    ),
                  ),
                  SizedBox(
                    width: AppSizes.kDefaultPadding,
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        getMyReturnController.deleteReturnedTicket();
                      },
                      child: Container(
                          padding:
                              EdgeInsets.all(AppSizes.kDefaultPadding / 1.5),
                          height: AppSizes.buttonHeight + 4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  AppSizes.cardCornerRadius / 2),
                              border: Border.all(color: AppColors.bg)),
                          child: const Icon(
                            Icons.delete,
                            color: AppColors.secondary,
                          )),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
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
                        padding: EdgeInsets.all(AppSizes.kDefaultPadding),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                'From Ticket',
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
                                  'To Ticket',
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
                                child: Text(
                                  'Count',
                                  textAlign: TextAlign.center,
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
                              child: Transform.scale(
                                scale: 1,
                                alignment: Alignment.center,
                                child: SizedBox(
                                  height: 10,
                                  width: 20,
                                  child: Obx(() => Checkbox(
                                      value: getMyReturnController
                                          .isAllReturnedTicketSelected.value,
                                      onChanged: (value) {
                                        getMyReturnController
                                            .isAllReturnedTicketSelected
                                            .value = value!;
                                        if (value == true) {
                                          for (var element
                                              in getMyReturnController
                                                  .returnTicketsList) {
                                            getMyReturnController
                                                .checkedBoxClicked(
                                                    element.sId!, true);
                                          }
                                        } else {
                                          for (var element
                                              in getMyReturnController
                                                  .returnTicketsList) {
                                            getMyReturnController
                                                .checkedBoxClicked(
                                                    element.sId!, false);
                                          }
                                        }
                                      })),
                                ),
                              ),
                            ),
                            // Expanded(
                            //     flex: 2,
                            //     child: Text(
                            //       'SEM',
                            //       textAlign: TextAlign.end,
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
                      const CustomDivider(),
                      SafeArea(
                        child: Container(
                            constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.40,
                            ),
                            width: MediaQuery.of(context).size.width,
                            // height: MediaQuery.of(context).size.height * 0.45,
                            child: Obx(() {
                              if (getMyReturnController
                                      .isReturnTicketLoading.value ==
                                  true) {
                                return const Center(
                                  child: CircularProgressIndicator.adaptive(),
                                );
                              } else if (getMyReturnController
                                  .returnTicketsList.isEmpty) {
                                return Center(
                                    child: const Text("noTicketsFound").tr());
                              } else {
                                return RawScrollbar(
                                  thumbColor: AppColors.primary,
                                  thickness: 3,
                                  radius: Radius.circular(
                                      AppSizes.cardCornerRadius),
                                  child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: getMyReturnController
                                          .returnTicketsList.length,
                                      itemBuilder: ((context, index) {
                                        var item = getMyReturnController
                                            .returnTicketsList[index];

                                        return ReturnedTicketListItem(
                                          itemIndex: index + 1,
                                          quantity: item.count ?? 0,
                                          fromTicket:
                                              "${item.fromLetter}${item.fromNumber}",
                                          toTicket:
                                              "${item.toLetter}${item.toNumber}",
                                          checkBox: Transform.scale(
                                            scale: 1,
                                            alignment: Alignment.center,
                                            child: Obx(() => SizedBox(
                                                  height: 15,
                                                  child: Checkbox(
                                                      value: getMyReturnController
                                                                  .checkBoxForAuthor[
                                                              item.sId] ??
                                                          false,
                                                      // value: false,
                                                      onChanged: (bool? value) {
                                                        getMyReturnController
                                                            .checkedBoxClicked(
                                                                item.sId
                                                                    .toString(),
                                                                value!);
                                                      }),
                                                )),
                                          ),
                                        );
                                        // return TicketListItem(
                                        //     ticketId: item.ticketId ?? "",
                                        //     itemIndex: index);
                                      })),
                                );
                              }
                            })),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
