import 'package:distech_technology/Commons/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/date_time_format.dart';
import '../../../Widgets/custom_text_field.dart';
import '../Controller/prize_controller.dart';
import '../Widgets/pwt_tickets-table.dart';

class PwtSoldScreen extends StatefulWidget {
  PwtSoldScreen({super.key, this.isComminFromDashboard = false});
  bool isComminFromDashboard;

  @override
  State<PwtSoldScreen> createState() => _PwtSoldUnsoldScreenState();
}

class _PwtSoldUnsoldScreenState extends State<PwtSoldScreen> {
  final prizeController = Get.put(PrizesController());

  @override
  void initState() {
    prizeController.pwtDateController.value.text =
        formateDateddMMyyyy(DateTime.now());
    prizeController.getPwtList(pwtStatus: "Sold");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.isComminFromDashboard
              ? AppBar(
                  title: const Text("Sold PWT "),
                )
              : const SizedBox.shrink(),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: widget.isComminFromDashboard
                      ? const Text(
                          'selectedDate',
                          style: TextStyle(
                              fontSize: 18, color: AppColors.secondary),
                        ).tr()
                      : Text(
                          "${context.tr("sold")} PWT",
                          style: const TextStyle(
                              fontSize: 18, color: AppColors.secondary),
                        ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 1,
                  child: CustomTextField(
                    height: MediaQuery.of(context).size.height * 0.06,
                    readOnly: true,
                    onTap: () async {
                      var date = await selectDate(context);
                      prizeController.pwtDateController.value.text = formatDate(
                          date: date ?? DateTime.now(),
                          formatType: "dd-MM-yyyy");

                      prizeController.getPwtList(
                        pwtStatus: "Sold",
                      );
                    },
                    controller: prizeController.pwtDateController.value,
                    suffixIcon: const Icon(Icons.date_range),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.02,
          ),
          Expanded(
            child: Obx(() => prizeController.isPwtLoading.value
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : prizeController.tickets.isNotEmpty
                    ? PwtDataTable(
                        prizesController: prizeController,
                      )
                    : Center(child: const Text("noTicketsFound").tr())),
          ),
        ],
      ),
    );
  }
}
