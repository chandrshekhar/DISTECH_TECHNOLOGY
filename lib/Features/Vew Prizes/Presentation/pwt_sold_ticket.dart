import 'package:distech_technology/Commons/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/date_time_format.dart';
import '../../../Widgets/custom_text_field.dart';
import '../Controller/prize_controller.dart';
import '../Widgets/pwt_tickets-table.dart';

class PwtSoldScreen extends StatefulWidget {
  const PwtSoldScreen({super.key});

  @override
  State<PwtSoldScreen> createState() => _PwtSoldScreenState();
}

class _PwtSoldScreenState extends State<PwtSoldScreen> {
  final prizeController = Get.put(PrizesController());

  @override
  void initState() {
    prizeController.getPwtList(pwtStatus: "Sold");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
            vertical: MediaQuery.of(context).size.width * 0.03),
        child: Column(
          children: [
            CustomTextField(
              height: MediaQuery.of(context).size.height * 0.05,
              readOnly: true,
              onTap: () async {
                prizeController.pwtDateController.text =
                    await selectDate(context) ?? "";
                prizeController.getPwtList(pwtStatus: "Sold");
              },
              controller: prizeController.pwtDateController,
              prefixIcon: const Icon(Icons.date_range),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.02,
            ),
            const Text(
              "PWT Sold",
              style: TextStyle(fontSize: 18, color: AppColors.lightGrey),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.02,
            ),
            Expanded(
              child: PwtDataTable(
                prizesController: prizeController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
