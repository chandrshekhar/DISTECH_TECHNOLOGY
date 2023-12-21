import 'package:distech_technology/Utils/Toast/app_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Commons/app_colors.dart';
import '../../../Commons/app_icons.dart';
import '../../../Commons/app_sizes.dart';
import '../../../Controller/Claim Controller/new_claim_controller.dart';

class NewClaimScreen extends StatefulWidget {
  const NewClaimScreen({super.key});
  @override
  State<NewClaimScreen> createState() => _NewClaimScreenState();
}

class _NewClaimScreenState extends State<NewClaimScreen> {
  final newClaimController = Get.put(NewClaimController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newClaimController.fromTicketScanValue.value = '';
    newClaimController.toTicketScanValue.value = '';
    newClaimController.dateFormat.value = '';
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
                  flex: 5,
                  child: Text(
                    "All claims you scan will be registered under ${newClaimController.fullName}",
                  ),
                ),
                Expanded(
                  // flex: 1,
                  child: InkWell(
                    onTap: () {
                      newClaimController.selectDate(context);
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
                )
              ],
            ),

            SizedBox(height: AppSizes.bodyText1),
            customTileCard(
              title: "From Tickets",
              subTitle: newClaimController.fromTicketScanValue.value,
              onTap: () async {
                if (newClaimController.dateFormat.value.isNotEmpty) {
                  newClaimController.scanBarCode(true, context);
                } else {
                  ToastMessage().toast(
                      context: context,
                      background: Colors.red,
                      message: "Please select date",
                      messageColor: Colors.white);
                }
              },
            ),

            Obx(
              () => newClaimController.fromTicketScanValue.value.isNotEmpty
                  ? customTileCard(
                      title: "To Tickets",
                      subTitle: newClaimController.toTicketScanValue.value,
                      onTap: () {
                        newClaimController.scanBarCode(false, context);
                      })
                  : const SizedBox.shrink(),
            ),

            const SizedBox(height: 20),
            //   Text("Ticket--> ${scanbarcodeController.barcodeValue}"),
          ],
        ),
      ),
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
}
