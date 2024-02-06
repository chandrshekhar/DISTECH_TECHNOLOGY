import 'package:distech_technology/Commons/app_colors.dart';
import 'package:distech_technology/Commons/app_sizes.dart';
import 'package:flutter/material.dart';

class ReturnedTicketListItem extends StatelessWidget {
  final String fromTicket;
  final String toTicket;
  final int quantity;
  final Widget checkBox;

  final int itemIndex;
  const ReturnedTicketListItem(
      {Key? key,
      required this.fromTicket,
      required this.toTicket,
      required this.quantity,
      required this.itemIndex,
      required this.checkBox})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppSizes.kDefaultPadding / 1.5),
      color: (itemIndex % 2 != 0) ? AppColors.white : AppColors.primaryBg,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.kDefaultPadding),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                fromTicket,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Expanded(
                flex: 2,
                child: Text(
                  toTicket,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyMedium,
                )),
            Expanded(
                flex: 2,
                child: Text(
                  quantity.toString(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                )),
            Expanded(flex: 1, child: checkBox),
          ],
        ),
      ),
    );
  }
}
