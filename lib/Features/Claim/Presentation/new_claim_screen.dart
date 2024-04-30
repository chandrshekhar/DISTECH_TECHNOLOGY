import 'package:distech_technology/Controller/Timer%20Controller/timer_controller.dart';
import 'package:distech_technology/Utils/date_time_format.dart';
import 'package:distech_technology/Widgets/custom_text_field.dart';
import 'package:distech_technology/Widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Commons/app_colors.dart';
import '../../../Commons/app_sizes.dart';
import '../../../Controller/Claim Controller/new_claim_controller.dart';

class NewClaimScreen extends StatefulWidget {
  const NewClaimScreen({super.key});
  @override
  State<NewClaimScreen> createState() => _NewClaimScreenState();
}

class _NewClaimScreenState extends State<NewClaimScreen> {
  final newClaimController = Get.put(NewClaimController());

  final timerController = Get.put(TimerController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newClaimController.fromTicketScanValue.value = '';
    newClaimController.toTicketScanValue.value = '';
    newClaimController.dateEditingController.value.text =
        formateDateddMMyyyy(DateTime.now());
    // newClaimController.dateFormat.value = '';
  }

  @override
  Widget build(BuildContext context) {
    newClaimController.getMyCnf();
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "All claims you scan will be registered under ${newClaimController.fullName}",
                      ),
                    ),
                    Expanded(
                        child: CustomTextField(
                      height: MediaQuery.of(context).size.height * 0.06,
                      readOnly: true,
                      onTap: () async {
                        newClaimController.selectDate(context);
                      },
                      controller:
                          newClaimController.dateEditingController.value,
                      suffixIcon: const Icon(Icons.date_range),
                    )),
                  ],
                ),

                SizedBox(height: AppSizes.bodyText1),
                customTileCard(
                  title: "From Tickets",
                  subTitle: newClaimController.fromTicketScanValue.value,
                  onTap: () async {
                    // newClaimController.createSignature("B7393471Z");
                    if (newClaimController
                        .dateEditingController.value.text.isEmpty) {
                      ToastMessage().toast(
                          context: context,
                          background: Colors.red,
                          message: "Please select date",
                          messageColor: Colors.white);
                    } else {
                      newClaimController.scanBarCode(
                          true, context, timerController.slotId.value);
                    }
                  },
                ),

                Obx(
                  () => newClaimController.fromTicketScanValue.value.isNotEmpty
                      ? customTileCard(
                          title: "To Tickets",
                          subTitle: newClaimController.toTicketScanValue.value,
                          onTap: () {
                            newClaimController.scanBarCode(
                                false, context, timerController.slotId.value);
                          })
                      : const SizedBox.shrink(),
                ),

                // const SizedBox(height: 20),
                //   Text("Ticket--> ${scanbarcodeController.barcodeValue}"),

                Obx(() => newClaimController
                            .fromTicketScanValue.value.isNotEmpty &&
                        newClaimController.toTicketScanValue.value.isNotEmpty
                    ? Align(
                        alignment: Alignment.centerRight,
                        child: FloatingActionButton(
                            mini: true,
                            child: const Icon(Icons.add),
                            onPressed: () {
                              // newClaimController.createSignature("B7393471Z");
                              newClaimController.handleAdd(context);
                            }))
                    : const SizedBox.shrink()),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: newClaimController.ticketClaimList.length,
                    itemBuilder: (context, index) {
                      return customTicketCard(
                          newClaimController.ticketClaimList[index]);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: Obx(
          () => newClaimController.ticketClaimList.isNotEmpty
              ? FloatingActionButton.extended(
                  onPressed: () {
                    newClaimController.onSubmitClaim(context);
                    // newClaimController.fromTicketScanValue.value = '';
                    // newClaimController.toTicketScanValue.value = '';
                    // newClaimController.ticketClaimList.clear();
                  },
                  label: const Text("Claim"))
              : const SizedBox.shrink(),
        ));
  }

  Widget customTileCard(
      {String? title,
      required String subTitle,
      void Function()? onTap,
      String? icon}) {
    return Container(
      padding: EdgeInsets.all(AppSizes.cardCornerRadius),
      margin: const EdgeInsets.only(bottom: 7),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius / 2),
          border: Border.all(color: AppColors.bg)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: '$title ',
                    style: const TextStyle(
                      fontSize: 16,
                    )),
                TextSpan(
                  text: subTitle.isNotEmpty ? "($subTitle)" : '',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ],
            ),
          ),
          Obx(() => newClaimController.fromTicketScaning.value ||
                  newClaimController.toTicketScaing.value
              ? const Center(
                  child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator.adaptive()),
                )
              : InkWell(
                  onTap: onTap,
                  child: Image.asset(
                    icon ?? "assets/icons/barcode-scanner.png",
                    width: 25,
                    height: 25,
                  ),
                )),
        ],
      ),
    );
  }

  Widget customTicketCard(ClaimModel claimModel) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: AppColors.primaryBg),
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: "From Ticket\n",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: claimModel.fromTicket,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: "To Ticket\n",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: claimModel.toTicket,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: "Total Ticket\n",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: claimModel.totalTicket.toString(),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: "Total Amount\n",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: claimModel.totalAmount.toString(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
