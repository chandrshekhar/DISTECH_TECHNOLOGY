import 'package:distech_technology/Controller/Ticket%20Controller/sold_ticket_list_controller.dart';
import 'package:distech_technology/Features/SoldTicket/Presentation/sold_ticket_list_widget.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Commons/app_colors.dart';
import '../../../Commons/app_icons.dart';
import '../../../Commons/app_sizes.dart';
import '../../../Utils/date_time_format.dart';
import '../../../Widgets/custom_text_field.dart';

class SoldTicketScreen extends StatefulWidget {
  const SoldTicketScreen({Key? key}) : super(key: key);

  @override
  State<SoldTicketScreen> createState() => _SoldTicketScreenState();
}

class _SoldTicketScreenState extends State<SoldTicketScreen> {
  final soldTicketListController = Get.put(SoldTicketListController());
  //Variable Declarations
  final TextEditingController _searchController = TextEditingController();
  String formatedDate = '';
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
        formatedDate = formatDate(date: picked, formatType: "yyyy-MM-dd");
        soldTicketListController.getSoldTicketList(
          date: formatedDate,
          semNumber: soldTicketListController.semNumber.value,
        );
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
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
        padding: const EdgeInsets.all(AppSizes.kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: AppSizes.kDefaultPadding,
            ),
            Obx(() => Text(
                  'All Sold Ticket (${soldTicketListController.soldTicketCont})',
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
                    onChanged: (value) async {
                      if (value.toString().isNotEmpty) {
                        soldTicketListController.searchTextSave(value);
                      } else {
                        soldTicketListController.searchText("");
                      }
                      soldTicketListController.getSoldTicketList(
                          date: formatedDate,
                          search: soldTicketListController.searchText.value,
                          semNumber: soldTicketListController.semNumber.value);
                    },
                    maxLines: 1,
                    minLines: 1,
                    isBorder: false,
                  ),
                ),
                const SizedBox(
                  width: AppSizes.kDefaultPadding,
                ),
                // Expanded(
                //   flex: 1,
                //   child: GestureDetector(
                //     onTap: () {},
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
                // const SizedBox(
                //   width: 10,
                // ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Container(
                      padding:
                          const EdgeInsets.all(AppSizes.kDefaultPadding / 1.5),
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
                      padding: const EdgeInsets.all(AppSizes.kDefaultPadding),
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
                                        color:
                                            AppColors.darkGrey.withOpacity(0.8),
                                        fontWeight: FontWeight.w500),
                              )),
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
                    Container(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.41,
                        ),
                        width: MediaQuery.of(context).size.width,
                        // height: MediaQuery.of(context).size.height * 0.45,
                        child: Obx(
                          () => soldTicketListController
                                  .soldTicketList.isNotEmpty
                              ? SoldTicketsListWidget(
                                  date: formatedDate,
                                )
                              : soldTicketListController
                                          .isSoldListLoading.value ==
                                      true
                                  ? const Center(
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    )
                                  : const Center(
                                      child:  Text("No tickets found")),
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
