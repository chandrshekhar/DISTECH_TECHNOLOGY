import 'package:distech_technology/Features/SoldTicket/Models/ticket_item_model.dart';
import 'package:flutter/material.dart';

import '../../../Commons/app_colors.dart';
import '../../../Commons/app_sizes.dart';

class TicketListItem extends StatelessWidget {
  final TicketItemModel ticketItemModel;
  final int itemIndex;

  const TicketListItem(
      {Key? key, required this.ticketItemModel, required this.itemIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(vertical: AppSizes.kDefaultPadding / 1.5),
      color: (itemIndex % 2 == 0) ? AppColors.white : AppColors.primaryBg,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppSizes.kDefaultPadding),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                ticketItemModel.slNo.toString(),
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Expanded(
                flex: 3,
                child: Text(
                  ticketItemModel.ticketNo.toString(),
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyMedium,
                )),
            Expanded(
                flex: 2,
                child: Text(
                  ticketItemModel.sem.toString(),
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.bodyMedium,
                )),
          ],
        ),
      ),
    );
  }
}

class TicketListItemWithCheckbox extends StatelessWidget {
  final TicketItemModel ticketItemModel;
  final int itemIndex;
  bool isSelectedIndex;

  TicketListItemWithCheckbox(
      {Key? key,
      required this.ticketItemModel,
      required this.itemIndex,
      this.isSelectedIndex = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(vertical: AppSizes.kDefaultPadding / 1.5),
      color: (itemIndex % 2 == 0) ? AppColors.white : AppColors.primaryBg,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppSizes.kDefaultPadding),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                ticketItemModel.slNo.toString(),
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Expanded(
                flex: 3,
                child: Text(
                  ticketItemModel.ticketNo.toString(),
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyMedium,
                )),
            Expanded(
                flex: 2,
                child: Text(
                  ticketItemModel.sem.toString(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                )),
            Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 10,
                    height: 10,
                    child: Checkbox(
                      value: isSelectedIndex,
                      onChanged: (bool? value) {
                        isSelectedIndex = value!;
                      },
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
