import 'package:distech_technology/Commons/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utils/date_time_format.dart';
import '../../../Widgets/custom_text_field.dart';
import '../Controller/prize_controller.dart';
import '../Widgets/pwt_tickets-table.dart';

class PwtUnsoldScreen extends StatefulWidget {
  PwtUnsoldScreen({super.key, this.isComminFromDashboard = false});

  bool isComminFromDashboard;

  @override
  State<PwtUnsoldScreen> createState() => _PwtSoldUnsoldScreenState();
}

class _PwtSoldUnsoldScreenState extends State<PwtUnsoldScreen> {
  final prizeController = Get.put(PrizesController());

  @override
  void initState() {
    prizeController.getPwtList(pwtStatus: "Returned", date: DateTime.now());
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
                  title: const Text("PWT Unsold"),
                )
              : const SizedBox.shrink(),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: Text(
                    "PWT Unsold",
                    style: TextStyle(fontSize: 18, color: AppColors.secondary),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 1,
                  child: CustomTextField(
                    height: MediaQuery.of(context).size.height * 0.06,
                    readOnly: true,
                    onTap: () async {
                      var selectedDate = await selectDate(context);
                      prizeController.pwtDateController.value.text =
                          formateDateddMMyyyy(selectedDate!);
                      prizeController.getPwtList(
                          pwtStatus: "Returned", date: selectedDate);
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
                : prizeController.getpwtList.value.tickets!.isNotEmpty
                    ? PwtDataTable(
                        prizesController: prizeController,
                      )
                    : const Center(child: Text("No Record found"))),
          ),
        ],
      ),
    );
  }
}
