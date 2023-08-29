import 'package:distech_technology/Commons/app_icons.dart';
import 'package:distech_technology/Controller/Purchaes%20Controller/purchaes_history_controller.dart';
import 'package:distech_technology/Features/PurchaseHistory/Presentation/purchases_details_screen.dart';
import 'package:distech_technology/Features/PurchaseHistory/widget/purchase_history_card.dart';
import 'package:distech_technology/Widgets/custom_text_field.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Commons/app_colors.dart';
import '../../../Commons/app_sizes.dart';
import '../../../Utils/date_time_format.dart';
import '../../../Widgets/custom_divider.dart';
import '../../SoldTicket/Models/ticket_item_model.dart';
import '../../SoldTicket/Widgets/ticket_list_item.dart';
import '../../../Utils/app_helper.dart';

class PurchaseHistoryScreen extends StatefulWidget {
  const PurchaseHistoryScreen({Key? key}) : super(key: key);

  @override
  State<PurchaseHistoryScreen> createState() => _PurchaseHistoryScreenState();
}

class _PurchaseHistoryScreenState extends State<PurchaseHistoryScreen> {
  //Variable Declarations
  final TextEditingController _searchController = TextEditingController();
  final purchaesController = Get.put(PurchaseController());
  DateTime selectedDate = DateTime.now();
  String dateFormat = '';

  // Open date picker dialog and select date from calender view
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
        var formatedDate = formatDate(date: picked, formatType: "yyyy-MM-dd");
        purchaesController.getAllPurchaesTicket(dateTime: formatedDate);
        dateFormat = formatedDate;
      });
    }
  }

  @override
  void initState() {
    // searchedList = ticketItemList;
    super.initState();
    purchaesController.getAllPurchaesTicket();
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
          padding: const EdgeInsets.all(AppSizes.kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: AppSizes.kDefaultPadding,
              ),
              Text(
                'Purchase History',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.w400),
              ),
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
                        // filterSearch(value!);
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
                height: AppSizes.kDefaultPadding * 1.2,
              ),
              Text(
                'Purchase History on ${AppHelper.formatDate(selectedDate.toLocal())}',
                style: Theme.of(context).textTheme.bodyMedium,
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
                                    MediaQuery.of(context).size.height * 0.4,
                              ),
                              width: MediaQuery.of(context).size.width,
                              child: Obx(() {
                                if (purchaesController.isPurchaLoading.value ==
                                    true) {
                                  return const Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  );
                                } else if (purchaesController
                                    .puchaseList.isEmpty) {
                                  return const Center(
                                    child: Text("No tickets found"),
                                  );
                                } else {
                                  return RawScrollbar(
                                    thumbColor: AppColors.primary,
                                    thickness: 3,
                                    radius: const Radius.circular(
                                        AppSizes.cardCornerRadius),
                                    child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        physics: const BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: purchaesController
                                            .puchaseList.length,
                                        itemBuilder: ((context, index) {
                                          var item = purchaesController
                                              .puchaseList[index];
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          PurchaesDetailsScreen(
                                                            dateTime:
                                                                dateFormat,
                                                            orderID: item
                                                                .sId
                                                                .toString(),
                                                          )));
                                            },
                                            child: PurchaseHistoryTicketListItem(
                                                ticketItemModel: TicketItemModel(
                                                    sem:
                                                        item.seller!.fullName ??
                                                            "",
                                                    slNo:
                                                        "${item.fromTicket } - ${item.toTicket}",
                                                    ticketNo:
                                                        item.count.toString()),
                                                itemIndex: index),
                                          );
                                        })),
                                  );
                                }
                              })))
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
