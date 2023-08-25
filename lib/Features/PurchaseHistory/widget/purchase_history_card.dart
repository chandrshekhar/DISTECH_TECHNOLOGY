import 'package:distech_technology/Commons/app_colors.dart';
import 'package:distech_technology/Commons/app_sizes.dart';
import 'package:distech_technology/Features/SoldTicket/Models/ticket_item_model.dart';
import 'package:flutter/material.dart';

class PurchaseHistoryTicketListItem extends StatelessWidget {
  final TicketItemModel ticketItemModel;
  final int itemIndex;
  const PurchaseHistoryTicketListItem({Key? key, required this.ticketItemModel, required this.itemIndex})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.kDefaultPadding / 1.5),
      color: (itemIndex % 2 == 0) ? AppColors.white : AppColors.primaryBg,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.kDefaultPadding),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                ticketItemModel.slNo.toString(),
                textAlign: TextAlign.start,
                style: const TextStyle(color: Colors.blue),
              ),
            ),
            Expanded(
                flex: 1,
                child: Text(
                  ticketItemModel.ticketNo.toString(),
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyMedium,
                )),
            Expanded(
                flex: 1,
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