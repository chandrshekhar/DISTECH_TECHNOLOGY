import 'package:distech_technology/Commons/app_colors.dart';
import 'package:distech_technology/Commons/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/sale_tickets_controller.dart';

class AddedTicketListWidget extends StatelessWidget {
  AddedTicketListWidget({super.key});

  final saleTicketController = Get.put(SaleTicketsController());

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: saleTicketController.successReturnTicketList.length,
        itemBuilder: (context, index) {
          var data = saleTicketController.successReturnTicketList[index];
          return Container(
            padding:
                EdgeInsets.symmetric(vertical: AppSizes.kDefaultPadding / 1.5),
            color: (index % 2 == 0) ? AppColors.white : AppColors.primaryBg,
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppSizes.kDefaultPadding),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      data.fromLetter.toString(),
                      textAlign: TextAlign.start,
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      data.toLetter.toString(),
                      textAlign: TextAlign.start,
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      data.fromNumber.toString().padLeft(5, '0'),
                      textAlign: TextAlign.start,
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Text(
                        data.toNumber.toString(),
                        style: const TextStyle(color: Colors.blue),
                      )),
                  InkWell(
                    onTap: () {
                      saleTicketController.removeValidateReturnTicket(index);
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 10,
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
