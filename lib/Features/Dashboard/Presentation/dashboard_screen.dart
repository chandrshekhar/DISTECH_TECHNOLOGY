import 'package:distech_technology/Widgets/filter_dialog.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../../../Commons/app_colors.dart';
import '../../../Commons/app_icons.dart';
import '../../../Commons/app_sizes.dart';
import '../../../Widgets/custom_divider.dart';
import '../../../Widgets/custom_text_field.dart';
import '../../../Widgets/full_button.dart';
import '../../SoldTicket/Models/ticket_item_model.dart';
import '../../SoldTicket/Widgets/ticket_list_item.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  //Variable Declarations
  final TextEditingController _searchController = TextEditingController();
  bool isSelected = false;

  List<TicketItemModel> searchedList = [];

  // Filter List by TICKET NUMBER or Search list by SEM
  void filterSearch(String query) {
    setState(() {
      searchedList = ticketItemList
          .where((element) => element.ticketNo!
              .trim()
              .toLowerCase()
              .toString()
              .contains(query.trim().toLowerCase().toString()))
          .toList();
    });
  }

  // Filter List by SEM or Search list by SEM
  void filterSearchBySem(String query) {
    setState(() {
      searchedList = ticketItemList
          .where((element) =>
              element.sem.toString().contains(query.toLowerCase().toString()))
          .toList();
    });
  }

  @override
  void initState() {
    searchedList = ticketItemList;
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
          padding: const EdgeInsets.all(AppSizes.kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: AppSizes.kDefaultPadding,
              ),
              Text(
                'My All Ticket (1525)',
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
                      onChanged: (String? value) {
                        filterSearch(value!);
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
                  Text(
                    '01 item Selected',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.primary, fontWeight: FontWeight.w500),
                  ),
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
                      borderRadius:
                          BorderRadius.circular(AppSizes.cardCornerRadius / 2),
                      border: Border.all(color: AppColors.bg),
                    ),
                    child: Container(
                      color: AppColors.primaryBg,
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.all(AppSizes.kDefaultPadding),
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
                                          onChanged: (bool? value) {
                                            setState(() {
                                              isSelected = value!;
                                            });
                                          },
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
                                    MediaQuery.of(context).size.height * 0.28,
                              ),
                              width: MediaQuery.of(context).size.width,
                              child: Scrollbar(
                                child: searchedList.isNotEmpty
                                    ? ListView.builder(
                                        padding: EdgeInsets.zero,
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: searchedList.length,
                                        itemBuilder: ((context, index) {
                                          return TicketListItemWithCheckbox(
                                              ticketItemModel:
                                                  searchedList[index],
                                              itemIndex: index);
                                        }))
                                    : Text(
                                        'No Ticket Found!',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.w400),
                                      ),
                              ))
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
                          onPressed: () {},
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
