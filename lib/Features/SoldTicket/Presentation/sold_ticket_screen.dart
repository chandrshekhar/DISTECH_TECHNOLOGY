import 'dart:async';

import 'package:distech_technology/Controller/Ticket%20Controller/sold_ticket_list_controller.dart';
import 'package:distech_technology/Features/SoldTicket/Presentation/sold_ticket_list_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Commons/app_colors.dart';
import '../../../Commons/app_sizes.dart';
import '../../../Widgets/custom_text_field.dart';

class SoldTicketScreen extends StatefulWidget {
  const SoldTicketScreen({Key? key}) : super(key: key);

  @override
  State<SoldTicketScreen> createState() => _SoldTicketScreenState();
}

class _SoldTicketScreenState extends State<SoldTicketScreen> {
  final soldTicketListController = Get.put(SoldTicketListController());
  //Variable Declarations

  @override
  void initState() {
    super.initState();
    soldTicketListController.limit.value = 10;
    soldTicketListController.getSoldTicketList();
    soldTicketListController.searchText.value = '';
    soldTicketListController.semNumber.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //Hide the onscreen keyboard on outside touch.
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Padding(
        padding: EdgeInsets.all(AppSizes.kDefaultPadding),
        child: SingleChildScrollView(
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
                          '${context.tr('allSoldTicket')} (${soldTicketListController.soldTicketCont})',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontWeight: FontWeight.w400),
                        ).tr(),
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
                      controller:
                          soldTicketListController.searchController.value,
                      hintText: 'Search',
                      prefixIcon: const Icon(
                        EvaIcons.searchOutline,
                        color: AppColors.primary,
                        size: 20,
                      ),
                      onChanged: (value) async {
                        if (soldTicketListController
                            .soldTicketList.isNotEmpty) {
                          if (value.toString().isNotEmpty) {
                            soldTicketListController.searchTextSave(value);
                          } else {
                            soldTicketListController.searchText("");
                          }
                          Timer(const Duration(milliseconds: 1000), () {
                            soldTicketListController.getSoldTicketList(
                                date:
                                    soldTicketListController.formatedDate.value,
                                search:
                                    soldTicketListController.searchText.value,
                                semNumber:
                                    soldTicketListController.semNumber.value);
                          });
                        }
                      },
                      maxLines: 1,
                      minLines: 1,
                      isBorder: false,
                    ),
                  ),
                  SizedBox(
                    width: AppSizes.kDefaultPadding,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (soldTicketListController
                          .selectedSoldTicket.isNotEmpty) {
                        soldTicketListController.revertSoldTicket();
                      }
                    },
                    child: Container(
                        padding: EdgeInsets.all(AppSizes.kDefaultPadding / 1.5),
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
                ],
              ),
              SizedBox(
                height: AppSizes.kDefaultPadding,
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
                        padding: EdgeInsets.symmetric(
                            horizontal: AppSizes.kDefaultPadding / 2,
                            vertical: AppSizes.kDefaultPadding),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'S.N',
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
                                flex: 3,
                                child: Text(
                                  'From Ticket - To Ticket',
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
                                'Count',
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
                                flex: 1,
                                child: SizedBox(
                                  height: 10,
                                  child: Obx(() => Checkbox(
                                        value: soldTicketListController
                                            .isAllSoldTicketSelected.value,
                                        onChanged: (value) {
                                          if (soldTicketListController
                                              .soldTicketList.isNotEmpty) {
                                            soldTicketListController
                                                .isAllSoldTicketSelected
                                                .value = value!;
                                            for (var element
                                                in soldTicketListController
                                                    .soldTicketList) {
                                              soldTicketListController
                                                  .checkedBoxClicked(
                                                      element.sId!, value);
                                            }
                                          }
                                        },
                                      )),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.36,
                          child: Obx(
                            () => soldTicketListController
                                    .soldTicketList.isNotEmpty
                                ? SoldTicketsListWidget(
                                    date: soldTicketListController
                                        .formatedDate.value,
                                  )
                                : soldTicketListController
                                            .isSoldListLoading.value ==
                                        true
                                    ? const Center(
                                        child: CircularProgressIndicator
                                            .adaptive(),
                                      )
                                    : Center(
                                        child:
                                            const Text("noTicketsFound").tr()),
                          ))
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
