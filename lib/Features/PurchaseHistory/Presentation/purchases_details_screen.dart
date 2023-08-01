import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Controller/Ticket%20Controller/sold_ticket_controller.dart';
import 'package:distech_technology/Widgets/filter_dialog.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Commons/app_colors.dart';
import '../../../Commons/app_icons.dart';
import '../../../Commons/app_sizes.dart';
import '../../../Widgets/custom_divider.dart';
import '../../../Widgets/custom_text_field.dart';
import '../../../Widgets/full_button.dart';
import '../../SoldTicket/Widgets/ticket_list_item.dart';

class PurchaesDetailsScreen extends StatefulWidget {
  final String qrcodeId;
  const PurchaesDetailsScreen({Key? key, required this.qrcodeId})
      : super(key: key);
  @override
  State<PurchaesDetailsScreen> createState() => _PurchaesDetailsScreenState();
}

class _PurchaesDetailsScreenState extends State<PurchaesDetailsScreen> {
  //Variable Declarations
  final TextEditingController _searchController = TextEditingController();
  bool isSelected = false;
  final soldTicketController = Get.put(SoldTicketController());

  @override
  void initState() {
    // searchedList = ticketItemList;
    soldTicketController.getAllTicket(search: widget.qrcodeId);
    soldTicketController.searchText.value = '';
    soldTicketController.semNumber.value = 0;
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    soldTicketController.getAllTicket(search: widget.qrcodeId);
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: GestureDetector(
          onTap: () {
            //Hide the onscreen keyboard on outside touch.
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: AppSizes.kDefaultPadding,
                  ),
                  Obx(() => Text(
                        'My All Ticket (${soldTicketController.allTicketList.length})',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontWeight: FontWeight.w400),
                      )),
                  const SizedBox(
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
                                semNumber:
                                    soldTicketController.semNumber.value);
                          },
                          maxLines: 1,
                          minLines: 1,
                          isBorder: false,
                        ),
                      ),
                      const SizedBox(
                        width: AppSizes.kDefaultPadding / 1.5,
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const AlertDialog(
                                    content: FilterDialog(),
                                  );
                                });
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
                              AppIcons.filterIcon,
                              width: 25,
                              height: 25,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: AppSizes.kDefaultPadding * 1.2,
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      Obx(() => Text(
                            '${soldTicketController.selectedSoldTicket.length.toString()} item Selected',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w500),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: AppSizes.kDefaultPadding / 1.5,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.35,
                        ),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              AppSizes.cardCornerRadius / 2),
                          border: Border.all(color: AppColors.bg),
                        ),
                        child: Container(
                          color: AppColors.primaryBg,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(
                                    AppSizes.kDefaultPadding),
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
                                        flex: 3,
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
                                        child: Text(
                                          'SEM',
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
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: SizedBox(
                                            width: 10,
                                            height: 10,
                                            child: Checkbox(
                                              value: isSelected,
                                              onChanged: (bool? value) {},
                                            ),
                                          ),
                                        )),
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
                                child: Obx(() {
                                  if (soldTicketController
                                          .isAllTicketLoading.value ==
                                      true) {
                                    return const Center(
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    );
                                  } else {
                                    return Scrollbar(
                                      child: soldTicketController
                                              .allTicketList.isNotEmpty
                                          ? ListView.builder(
                                              padding: EdgeInsets.zero,
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              itemCount: soldTicketController
                                                  .allTicketList.length,
                                              itemBuilder: ((context, index) {
                                                var e = soldTicketController
                                                    .allTicketList[index];
                                                return TicketListItemWithCheckbox(
                                                  isSelectedIndex: isSelected,
                                                  ticketItemModel:
                                                      soldTicketController
                                                          .allTicketList[index],
                                                  itemIndex: index,
                                                  child: Checkbox(
                                                    value: soldTicketController
                                                            .checkBoxForAuthor[
                                                        e.sId],
                                                    onChanged: (value) {
                                                      soldTicketController
                                                          .checkedBoxClicked(
                                                              e.sId.toString(),
                                                              value!);
                                                      setState(() {});
                                                    },
                                                  ),
                                                );
                                              }))
                                          : Text(
                                              'No Ticket Found!',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w400),
                                            ),
                                    );
                                  }
                                }),
                              ),
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
                            FullButton(
                              label: 'Mark sold',
                              onPressed: () async {
                                if (soldTicketController
                                    .selectedSoldTicket.isNotEmpty) {
                                  var res = await ApiProvider().soldTciket(
                                      soldTicketController.selectedSoldTicket);
                                  Get.snackbar("Successful", res['message'],
                                      backgroundColor: AppColors.white,
                                      colorText: Colors.green,
                                      isDismissible: true,
                                      snackPosition: SnackPosition.BOTTOM);
                                  soldTicketController.selectedSoldTicket
                                      .clear();
                                  await soldTicketController.getAllTicket();
                                } else {
                                  Get.snackbar("Not response",
                                      "Your are not selected any ticket for mark as sold",
                                      backgroundColor: AppColors.black,
                                      colorText: Colors.white,
                                      isDismissible: true,
                                      snackPosition: SnackPosition.BOTTOM);
                                }
                              },
                            ),
                            const SizedBox(
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
