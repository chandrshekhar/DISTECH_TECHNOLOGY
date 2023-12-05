import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Utils/date_time_format.dart';
import 'package:distech_technology/Widgets/full_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Commons/app_colors.dart';
import '../../Commons/app_icons.dart';
import '../../Commons/app_sizes.dart';
import '../../Controller/Purchaes Controller/purchaes_history_controller.dart';
import '../../Controller/Scan Barcode/scan_barcode_controller.dart';

class ScanBarCodeScreen extends StatefulWidget {
  const ScanBarCodeScreen({super.key});

  @override
  State<ScanBarCodeScreen> createState() => _ScanBarCodeScreenState();
}

class _ScanBarCodeScreenState extends State<ScanBarCodeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    dateFormat = '';
    super.initState();
  }

  Map<dynamic, dynamic> tikcetDetails = {};
  Widget? scannedTicket;
  String barcodeValue = "NA";
  final purchaesController = Get.put(PurchaseController());
  final scanbarcodeController = Get.put(ScanBarcodeController());

  DateTime selectedDate = DateTime.now();
  String dateFormat = '';
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(3000, 8),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        var formatedDate = formatDate(date: picked, formatType: "yyyy-MM-dd");
        dateFormat = formatedDate;
        purchaesController.getAllPurchaesTicket(dateTime: formatedDate);
      });
    }
  }

  ApiProvider apiProvider = ApiProvider();
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      child: const Text("Select Date",
                          style: TextStyle(fontSize: 20))),
                  InkWell(
                    onTap: () {
                      _selectDate(context);
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
              const SizedBox(height: 20),
              Text("Ticket--> ${scanbarcodeController.barcodeValue}"),
              Text(scanbarcodeController.invalidString == ''
                  ? ''
                  : scanbarcodeController.invalidString.toString()),
              scanbarcodeController.scanTickModel.value.success != true
                  ? const SizedBox.shrink()
                  : Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Card(
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
                                      value: scanbarcodeController.scanTickModel
                                              .value.ticket?.ticketId ??
                                          ""),
                                  rowWidget(
                                      title: "Draw Date:",
                                      value: scanbarcodeController
                                          .scanTickModel.value.ticket?.date
                                          .toString()),
                                  rowWidget(title: "Status:")
                                ],
                              ),
                            ),
                          ),
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
                                  const Text("Prize Details",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      )),
                                  const SizedBox(height: 10),
                                  rowWidget(
                                      title: "Prize Name:",
                                      value: scanbarcodeController.scanTickModel
                                          .value.ticket?.prize?.name),
                                  rowWidget(
                                    title: "Prize Amount:",
                                    value: scanbarcodeController.scanTickModel
                                        .value.ticket?.prize?.prizeAmount
                                        .toString(),
                                  ),
                                  rowWidget(
                                      title: "Agent Amount:",
                                      value: scanbarcodeController.scanTickModel
                                          .value.ticket?.prize?.agentAmount
                                          .toString())
                                ],
                              ),
                            ),
                          ),
                          // Card(
                          //   child: Container(
                          //     padding: const EdgeInsets.only(
                          //         left: 17, top: 10, right: 17, bottom: 25),
                          //     decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(10),
                          //         color: Colors.white),
                          //     child: Column(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         const Text("Current Owner Details",
                          //             style: TextStyle(
                          //               fontSize: 20,
                          //               fontWeight: FontWeight.w700,
                          //             )),
                          //         const SizedBox(height: 10),
                          //         rowWidget(title: "Name:", value: "AZ000343"),
                          //         rowWidget(
                          //             title: "username:",
                          //             value: "3rd Dec 2023"),
                          //         rowWidget(
                          //             title: "Email:",
                          //             value: "pandey211998@gmail.com"),
                          //         rowWidget(title: "City:", value: ""),
                          //         rowWidget(title: "District", value: "")
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          // Card(
                          //   child: Container(
                          //     padding: const EdgeInsets.only(
                          //         left: 17, top: 10, right: 17, bottom: 25),
                          //     decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(10),
                          //         color: Colors.white),
                          //     child: Column(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         const Text("Previous Seller",
                          //             style: TextStyle(
                          //               fontSize: 20,
                          //               fontWeight: FontWeight.w700,
                          //             )),
                          //         const SizedBox(height: 10),
                          //         rowWidget(title: "Name:", value: "AZ000343"),
                          //         rowWidget(
                          //             title: "username:",
                          //             value: "3rd Dec 2023"),
                          //         rowWidget(
                          //             title: "Email:",
                          //             value: "pandey211998@gmail.com"),
                          //         rowWidget(title: "City:", value: ""),
                          //         rowWidget(title: "District", value: "")
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
              // const Spacer(),
              dateFormat.toString().isNotEmpty
                  ? scanbarcodeController.isTicketScanning == true
                      ? const CircularProgressIndicator.adaptive()
                      : FullButton(
                          label: "Scan Barcode",
                          onPressed: () {
                            scanbarcodeController.invalidString.value = "";
                            scanbarcodeController.barcodeValue.value = "";
                            scanbarcodeController.scanBarcodeNormal(dateFormat);
                          })
                  : const Text("Please select date first")
            ],
          ),
        ));
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

  Widget rowWidget({String? title, String? value}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        children: [
          Expanded(
            flex: 2,
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
                style: const TextStyle(
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
