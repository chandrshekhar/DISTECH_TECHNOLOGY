import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Widgets/full_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Commons/app_colors.dart';
import '../../Commons/app_icons.dart';
import '../../Commons/app_sizes.dart';
import '../../Controller/Scan Barcode/scan_barcode_controller.dart';

class ScanBarCodeScreen extends StatelessWidget {
  ScanBarCodeScreen({super.key});

  final scanbarcodeController = Get.put(ScanBarcodeController());

  ApiProvider apiProvider = ApiProvider();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                          text: 'Selected Date\n',
                          style: TextStyle(
                            fontSize: 20,
                          )),
                      TextSpan(
                        text: scanbarcodeController.dateFormat.isEmpty
                            ? ""
                            : '(${scanbarcodeController.dateFormat})',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    scanbarcodeController.selectDate(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(AppSizes.kDefaultPadding / 1.5),
                    height: AppSizes.buttonHeight + 4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppSizes.cardCornerRadius / 2),
                        border: Border.all(color: AppColors.bg)),
                    child: Image.asset(
                      AppIcons.calenderIcon,
                      width: 25,
                      height: 25,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          //   Text("Ticket--> ${scanbarcodeController.barcodeValue}"),

          Expanded(
            child: Obx(
              () => scanbarcodeController.isTicketScanning.value == true
                  ? const Center(child: CircularProgressIndicator.adaptive())
                  : (scanbarcodeController.scanTickModel.value.ticket == null)
                      ? Text(
                          scanbarcodeController.invalidString.toString(),
                          style: const TextStyle(color: Colors.red),
                        )
                      : ListView(
                          shrinkWrap: true,
                          children: [
                            Card(
                              elevation: 5,
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 17, top: 10, right: 17, bottom: 25),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Ticket Details",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        )),
                                    const SizedBox(height: 10),
                                    rowWidget(
                                        title: "Ticket Number:",
                                        value: scanbarcodeController
                                                .scanTickModel
                                                .value
                                                .ticket
                                                ?.ticketId ??
                                            ""),
                                    rowWidget(
                                        title: "Draw Date:",
                                        value: scanbarcodeController
                                            .scanTickModel.value.ticket?.date
                                            .toString()),
                                    rowWidget(
                                        title: "Status:",
                                        value: scanbarcodeController
                                            .scanTickModel.value.ticket?.status,
                                        valueStyle: statusColor(
                                            scanbarcodeController.scanTickModel
                                                .value.ticket?.status))
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            scanbarcodeController
                                        .scanTickModel.value.ticket?.prize ==
                                    null
                                ? const SizedBox()
                                : Card(
                                    elevation: 5,
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 17,
                                          top: 10,
                                          right: 17,
                                          bottom: 25),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text("Prize Details",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                              )),
                                          const SizedBox(height: 10),
                                          rowWidget(
                                              title: "Prize Name:",
                                              value: scanbarcodeController
                                                  .scanTickModel
                                                  .value
                                                  .ticket
                                                  ?.prize
                                                  ?.name),
                                          rowWidget(
                                            title: "Prize Amount:",
                                            value: scanbarcodeController
                                                .scanTickModel
                                                .value
                                                .ticket
                                                ?.prize
                                                ?.prizeAmount
                                                .toString(),
                                          ),
                                          rowWidget(
                                              title: "Agent Amount:",
                                              value: scanbarcodeController
                                                  .scanTickModel
                                                  .value
                                                  .ticket
                                                  ?.prize
                                                  ?.agentAmount
                                                  .toString())
                                        ],
                                      ),
                                    ),
                                  ),
                            scanbarcodeController.scanTickModel.value.ticket
                                        ?.currOwner ==
                                    null
                                ? const SizedBox()
                                : Card(
                                    elevation: 5,
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 17,
                                          top: 10,
                                          right: 17,
                                          bottom: 25),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text("Current Owner Details",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                              )),
                                          const SizedBox(height: 10),
                                          rowWidget(
                                              title: "Name:",
                                              value: scanbarcodeController
                                                  .scanTickModel
                                                  .value
                                                  .ticket
                                                  ?.currOwner
                                                  ?.fullName),
                                          rowWidget(
                                              title: "username:",
                                              value: scanbarcodeController
                                                  .scanTickModel
                                                  .value
                                                  .ticket
                                                  ?.currOwner
                                                  ?.fullName),
                                          rowWidget(
                                              title: "Email:",
                                              value: scanbarcodeController
                                                  .scanTickModel
                                                  .value
                                                  .ticket
                                                  ?.currOwner
                                                  ?.email),
                                          rowWidget(
                                              title: "City:",
                                              value: scanbarcodeController
                                                  .scanTickModel
                                                  .value
                                                  .ticket
                                                  ?.currOwner
                                                  ?.city),
                                          rowWidget(
                                              title: "District",
                                              value: scanbarcodeController
                                                  .scanTickModel
                                                  .value
                                                  .ticket
                                                  ?.currOwner
                                                  ?.address1)
                                        ],
                                      ),
                                    ),
                                  ),
                            scanbarcodeController
                                        .scanTickModel.value.ticket?.sellers ==
                                    null
                                ? const SizedBox()
                                : Card(
                                    elevation: 5,
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 17,
                                          top: 10,
                                          right: 17,
                                          bottom: 25),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text("Previous Seller",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                              )),
                                          const SizedBox(height: 10),
                                          rowWidget(
                                              title: "Name:",
                                              value: scanbarcodeController
                                                  .scanTickModel
                                                  .value
                                                  .ticket
                                                  ?.sellers?[0]
                                                  .userType),
                                        ],
                                      ),
                                    ),
                                  ),
                            const SizedBox(height: 10),
                          ],
                        ),
            ),
          ),
          // const Spacer(),
          Obx(() => scanbarcodeController.dateFormat.toString().isNotEmpty
              ? FullButton(
                  label: "Scan Barcode",
                  onPressed: () {
                    scanbarcodeController.scanBarcodeNormal();
                  })
              : const Text("Please select date first"))
        ],
      ),
    );
  }

  TextStyle statusColor(String? title) {
    if (title == "Sold") {
      return const TextStyle(
          letterSpacing: 0.2,
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.green);
    } else {
      return const TextStyle(
          letterSpacing: 0.2,
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.red);
    }
  }

  Widget _buildTicketDetails(BuildContext context, String title, String value) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 20,
        ),
        Text(value),
      ],
    );
  }

  Widget rowWidget({String? title, String? value, TextStyle? valueStyle}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(title ?? "",
                style: const TextStyle(
                    letterSpacing: 0.2,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF5E5E5E))),
          ),
          Expanded(
            flex: 1,
            child: Text(value ?? "",
                style: valueStyle ??
                    const TextStyle(
                        letterSpacing: 0.2,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF000000))),
          )
        ],
      ),
    );
  }
}
