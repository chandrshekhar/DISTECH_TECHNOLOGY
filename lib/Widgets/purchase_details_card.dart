import 'package:flutter/material.dart';

import '../Commons/app_colors.dart';
import '../Commons/app_sizes.dart';

class PurchaseDetilsCardWidget extends StatefulWidget {
  final int itemIndex;
  final String ticketId;
  const PurchaseDetilsCardWidget({super.key, required this.itemIndex, required this.ticketId});

  @override
  State<PurchaseDetilsCardWidget> createState() =>
      _PurchaseDetilsCardWidgetState();
}

class _PurchaseDetilsCardWidgetState extends State<PurchaseDetilsCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(vertical: AppSizes.kDefaultPadding / 1.5),
      color:
          (widget.itemIndex % 2 == 0) ? AppColors.white : AppColors.primaryBg,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppSizes.kDefaultPadding),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                "${widget.itemIndex + 1}",
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Expanded(
                flex: 2,
                child: Text(
                  widget.ticketId,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyMedium,
                )),
            // Expanded(
            //     flex: 2,
            //     child: Text(
            //       ticketItemModel.sEM.toString(),
            //       textAlign: TextAlign.center,
            //       style: Theme.of(context).textTheme.bodyMedium,
            //     )),
            // Expanded(
            //     // flex: 1,
            //     child: Align(
            //   alignment: Alignment.centerRight,
            //   child: SizedBox(width: 10, height: 10, child: child),
            // )),
          ],
        ),
      ),
    );
  }
}
