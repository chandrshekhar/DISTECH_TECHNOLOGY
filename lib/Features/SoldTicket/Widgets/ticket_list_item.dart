import 'package:distech_technology/Features/Dashboard/model/all_tickets_model.dart';
import 'package:flutter/material.dart';

import '../../../Commons/app_colors.dart';
import '../../../Commons/app_sizes.dart';

class TicketListItem extends StatelessWidget {
  final String ticketId;
  final int itemIndex;
  final int count;
  final checkBox;
  const TicketListItem(
      {Key? key,
      required this.ticketId,
      required this.itemIndex,
      required this.checkBox,
      required this.count})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppSizes.kDefaultPadding / 1.5),
      color: (itemIndex % 2 == 0) ? AppColors.white : AppColors.primaryBg,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.kDefaultPadding / 2),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                "${itemIndex + 1}",
                textAlign: TextAlign.start,
                style: const TextStyle(color: Colors.blue),
              ),
            ),
            Expanded(
                flex: 3,
                child: Text(
                  ticketId,
                  style: Theme.of(context).textTheme.bodyMedium,
                )),
            Expanded(
                flex: 1,
                child: Text(
                  count.toString(),
                  style: Theme.of(context).textTheme.bodyMedium,
                )),
            Expanded(flex: 1, child: checkBox),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class TicketListItemWithCheckbox extends StatelessWidget {
  final int itemIndex;
  bool isSelectedIndex;
  Tickets ticketItemModel;

  TicketListItemWithCheckbox(
      {Key? key,
      required this.ticketItemModel,
      required this.itemIndex,
      this.isSelectedIndex = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: (itemIndex % 2 == 0) ? AppColors.white : AppColors.primaryBg,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppSizes.kDefaultPadding,
            vertical: AppSizes.kDefaultPadding / 2),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                "${itemIndex + 1}",
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Expanded(
                flex: 2,
                child: Text(
                  ticketItemModel.ticketId.toString(),
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyMedium,
                )),
            // Expanded(
            //     flex: 1,
            //     child: Text(
            //       ticketItemModel.sEM.toString(),
            //       textAlign: TextAlign.center,
            //       style: Theme.of(context).textTheme.bodyMedium,
            //     )),
            Expanded(
                flex: 1,
                child: Text(
                  ticketItemModel.status.toString(),
                )),
          ],
        ),
      ),
    );
  }
}
