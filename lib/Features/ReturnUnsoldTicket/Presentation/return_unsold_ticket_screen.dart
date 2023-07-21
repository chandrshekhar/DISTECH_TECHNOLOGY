import 'package:distech_technology/Commons/app_colors.dart';
import 'package:distech_technology/Widgets/full_button.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../../../Commons/app_icons.dart';
import '../../../Commons/app_sizes.dart';
import '../../../Widgets/custom_divider.dart';
import '../../../Widgets/custom_text_field.dart';
import '../../../Widgets/filter_dialog.dart';
import '../../SoldTicket/Models/ticket_item_model.dart';
import '../../SoldTicket/Widgets/ticket_list_item.dart';

class ReturnUnsoldTicket extends StatefulWidget {
  const ReturnUnsoldTicket({Key? key}) : super(key: key);

  @override
  State<ReturnUnsoldTicket> createState() => _ReturnUnsoldTicketState();
}

class _ReturnUnsoldTicketState extends State<ReturnUnsoldTicket> {
  //Variable Declarations
  final TextEditingController _searchController = TextEditingController();
  bool isSelected = false;

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
                          'Sell 5% of your unsold tickets from the total purchase',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.w400),
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
                        child: Text('15',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.white)),
                      ),
                    )
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
                              constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height * 0.28,
                              ),
                              width: MediaQuery.of(context).size.width,
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
                                      return TicketListItemWithCheckbox(
                                          ticketItemModel:
                                              ticketItemList[index],
                                          itemIndex: index);
                                    })),
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
                          label: 'Return Unsold',
                          onPressed: () {},
                          bgColor: AppColors.secondary,
                        ),
                        const SizedBox(
                          height: AppSizes.kDefaultPadding * 1.2,
                        ),
                        Text(
                          '** You can unsold your 5% ticket of your total purchased ticket',
                          style: Theme.of(context).textTheme.bodyMedium,
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
  }
}
