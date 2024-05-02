import 'package:distech_technology/Controller/Purchaes%20Controller/purchaes_history_controller.dart';
import 'package:distech_technology/Features/PurchaseHistory/Presentation/purches_list_pagination_widget.dart';
import 'package:distech_technology/Widgets/custom_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Commons/app_colors.dart';
import '../../../Commons/app_sizes.dart';
import '../../../Widgets/custom_divider.dart';

class PurchaseHistoryScreen extends StatefulWidget {
  const PurchaseHistoryScreen({Key? key}) : super(key: key);

  @override
  State<PurchaseHistoryScreen> createState() => _PurchaseHistoryScreenState();
}

class _PurchaseHistoryScreenState extends State<PurchaseHistoryScreen> {
  //Variable Declarations
  final TextEditingController _searchController = TextEditingController();
  final purchaesController = Get.put(PurchaseController());
  @override
  void initState() {
    // searchedList = ticketItemList;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      purchaesController.limit.value = 100;
      // purchaesController.dateEditngController.value.text =
      //     formateDateddMMyyyy(DateTime.now());
      purchaesController.getAllPurchaesTicket();
    });
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
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Obx(() => Expanded(
                        child: Text(
                          "${context.tr("purchasedTickets")}  (${purchaesController.countPurchaesTickets})",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: CustomTextField(
                        height: MediaQuery.of(context).size.height * 0.06,
                        readOnly: true,
                        onTap: () async {
                          purchaesController.selectDate(context);
                        },
                        controller:
                            purchaesController.dateEditngController.value,
                        suffixIcon: const Icon(Icons.date_range),
                      )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: CustomTextField(
                      controller: _searchController,
                      height: MediaQuery.of(context).size.height * 0.06,
                      hintText: 'Search',
                      prefixIcon: const Icon(
                        EvaIcons.searchOutline,
                        color: AppColors.primary,
                        size: 20,
                      ),
                      onChanged: (value) {
                        purchaesController.setSearchText(value);

                        purchaesController.getAllPurchaesTicket();
                      },
                      maxLines: 1,
                      minLines: 1,
                      isBorder: false,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
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
                                'From ticket - To Ticket',
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
                                child: Text(
                                  'Quantity',
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
                                  'Seller',
                                  textAlign: TextAlign.end,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: AppColors.darkGrey
                                              .withOpacity(0.8),
                                          fontWeight: FontWeight.w500),
                                )),
                          ],
                        ),
                      ),
                      const CustomDivider(),
                      SafeArea(
                          bottom: false,
                          child: Container(
                              constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height * 0.40,
                              ),
                              width: MediaQuery.of(context).size.width,
                              child: Obx(() => purchaesController
                                      .isPurchaLoading.value
                                  ? const Center(
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    )
                                  : purchaesController.puchaseList.isNotEmpty
                                      ? const PurchesHistoryTicketWidget()
                                      : purchaesController
                                                  .isPurchaLoading.value ==
                                              true
                                          ? const Center(
                                              child: CircularProgressIndicator
                                                  .adaptive(),
                                            )
                                          : Center(
                                              child:
                                                  const Text("noTicketsFound")
                                                      .tr(),
                                            ))))
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
