import 'package:distech_technology/Features/SoldTicket/Models/ticket_item_model.dart';
import 'package:distech_technology/Features/SoldTicket/Widgets/ticket_list_item.dart';
import 'package:distech_technology/Widgets/custom_divider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../../../Commons/app_colors.dart';
import '../../../Commons/app_icons.dart';
import '../../../Commons/app_sizes.dart';
import '../../../Widgets/custom_text_field.dart';

class SoldTicketScreen extends StatefulWidget {
  const SoldTicketScreen({Key? key}) : super(key: key);

  @override
  State<SoldTicketScreen> createState() => _SoldTicketScreenState();
}

class _SoldTicketScreenState extends State<SoldTicketScreen> {
  //Variable Declarations
  final TextEditingController _searchController = TextEditingController();

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
                'All Sold Ticket (565)',
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
                      maxLines: 1,
                      minLines: 1,
                      isBorder: false,
                    ),
                  ),
                  const SizedBox(
                    width: AppSizes.kDefaultPadding,
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {},
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
                        child: Container(
                            constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.45,
                            ),
                            width: MediaQuery.of(context).size.width,
                            // height: MediaQuery.of(context).size.height * 0.45,
                            child: RawScrollbar(
                              thumbColor: AppColors.primary,
                              thickness: 3,
                              radius: const Radius.circular(
                                  AppSizes.cardCornerRadius),
                              child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: ticketItemList.length,
                                  itemBuilder: ((context, index) {
                                    return TicketListItem(
                                        ticketItemModel: ticketItemList[index],
                                        itemIndex: index);
                                  })),
                            )),
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
