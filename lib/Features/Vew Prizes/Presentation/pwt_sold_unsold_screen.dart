import 'package:distech_technology/Commons/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/date_time_format.dart';
import '../../../Widgets/custom_text_field.dart';
import '../Controller/prize_controller.dart';
import '../Widgets/pwt_tickets-table.dart';

class PwtSoldUnsoldScreen extends StatefulWidget {
  const PwtSoldUnsoldScreen({super.key});

  @override
  State<PwtSoldUnsoldScreen> createState() => _PwtSoldUnsoldScreenState();
}

class _PwtSoldUnsoldScreenState extends State<PwtSoldUnsoldScreen> {
  final prizeController = Get.put(PrizesController());

  @override
  void initState() {
    prizeController.getPwtList();
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
                prizeController.getPwtList();
              },
              controller: prizeController.pwtDateController,
              prefixIcon: const Icon(Icons.date_range),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.02,
            ),
            Row(
              children: [
                Obx(() => Expanded(
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                            prizeController.pwtStatus.value.contains("Sold")
                                ? AppColors.primary
                                : AppColors.lightGrey,
                          )),
                          onPressed: () {
                            prizeController.setPwtStatus(status: "Sold");
                            prizeController.getPwtList();
                          },
                          child: const Text("Sold")),
                    )),
                const SizedBox(width: 10),
                Obx(() => Expanded(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                          prizeController.pwtStatus.value.contains("Returned")
                              ? AppColors.primary
                              : AppColors.lightGrey,
                        )),
                        onPressed: () {
                          prizeController.setPwtStatus(status: "Returned");
                          prizeController.getPwtList();
                        },
                        child: const Text("Unsold")))),
              ],
            ),

            SizedBox(
              height: MediaQuery.of(context).size.width * 0.02,
            ),
            Expanded(
              child: PwtDataTable(
                prizesController: prizeController,
              ),
            ),
            // Container(
            // margin: EdgeInsets.only(
            //     top: MediaQuery.of(context).size.width * 0.02),
            // // constraints: BoxConstraints(
            // //   maxHeight: MediaQuery.of(context).size.height * 0.5,
            // // ),
            // width: MediaQuery.of(context).size.width,
            // decoration: BoxDecoration(
            //   borderRadius:
            //       BorderRadius.circular(AppSizes.cardCornerRadius / 2),
            //   border: Border.all(color: AppColors.bg),
            // ),
            // child: PwtDataTable(
            //   prizesController: prizeController,
            // ),

            // Container(
            //   color: AppColors.primaryBg,
            //   child: Column(
            //     children: [
            //       PwtDataTable(
            //         prizesController: prizeController,
            //       ),
            //       Padding(
            //         padding: EdgeInsets.symmetric(
            //             horizontal: AppSizes.kDefaultPadding,
            //             vertical: AppSizes.kDefaultPadding / 2),
            //         child: Row(
            //           children: [
            //             Expanded(
            //               flex: 1,
            //               child: Text(
            //                 'SL No',
            //                 textAlign: TextAlign.start,
            //                 style: Theme.of(context)
            //                     .textTheme
            //                     .bodyMedium!
            //                     .copyWith(
            //                         color:
            //                             AppColors.darkGrey.withOpacity(0.8),
            //                         fontWeight: FontWeight.w500),
            //               ),
            //             ),
            //             Expanded(
            //                 flex: 4,
            //                 child: Text(
            //                   'TICKET NUMBER',
            //                   textAlign: TextAlign.center,
            //                   style: Theme.of(context)
            //                       .textTheme
            //                       .bodyMedium!
            //                       .copyWith(
            //                           color:
            //                               AppColors.darkGrey.withOpacity(0.8),
            //                           fontWeight: FontWeight.w500),
            //                 )),
            //             Expanded(
            //               flex: 2,
            //               child: Text(
            //                 'PRIZE',
            //                 textAlign: TextAlign.center,
            //                 style: Theme.of(context)
            //                     .textTheme
            //                     .bodyMedium!
            //                     .copyWith(
            //                         color:
            //                             AppColors.darkGrey.withOpacity(0.8),
            //                         fontWeight: FontWeight.w500),
            //               ),
            //             ),

            //             // Expanded(
            //             //   flex: 1,
            //             //   child: Transform.scale(
            //             //     scale: 1.3,
            //             //     child: Obx(() => Checkbox(
            //             //           value: soldTicketControllera
            //             //               .isAllSelect.value,
            //             //           onChanged: (value) {
            //             //             soldTicketController
            //             //                 .isAllSelect.value = value!;
            //             //             if (value == true) {
            //             //               for (var element
            //             //                   in soldTicketController
            //             //                       .allTicketList) {
            //             //                 soldTicketController
            //             //                     .checkedBoxClicked(
            //             //                         element.sId!, true);
            //             //               }
            //             //             } else {
            //             //               for (var element
            //             //                   in soldTicketController
            //             //                       .allTicketList) {
            //             //                 soldTicketController
            //             //                     .checkedBoxClicked(
            //             //                         element.sId!, false);
            //             //               }
            //             //             }
            //             //             setState(() {});
            //             //           },
            //             //         )),
            //             //   ),
            //             // ),
            //           ],
            //         ),
            //       ),
            //       const CustomDivider(),
            //       Container(
            //           alignment: Alignment.center,
            //           constraints: BoxConstraints(
            //             maxHeight: MediaQuery.of(context).size.height * 0.45,
            //           ),
            //           width: MediaQuery.of(context).size.width,
            //           child: Obx(() => prizeController.isPwtLoading.value
            //               ? const Center(
            //                   child: CircularProgressIndicator.adaptive(),
            //                 )
            //               : prizeController.getpwtList.value.tickets !=
            //                           null &&
            //                       prizeController
            //                           .getpwtList.value.tickets!.isNotEmpty
            //                   ? ListView.builder(
            //                       // itemCount: prizeController
            //                       //     .getpwtList.value.tickets?.length,
            //                       itemCount: 18,
            //                       itemBuilder: (context, index) {
            //                         var data = prizeController
            //                             .getpwtList.value.tickets?[index];
            //                         return Container(
            //                           padding: EdgeInsets.symmetric(
            //                               vertical:
            //                                   AppSizes.kDefaultPadding / 1.5),
            //                           color: (index % 2 == 0)
            //                               ? AppColors.white
            //                               : AppColors.primaryBg,
            //                           child: Padding(
            //                             padding: EdgeInsets.symmetric(
            //                                 horizontal:
            //                                     AppSizes.kDefaultPadding),
            //                             child: Row(
            //                               children: [
            //                                 Expanded(
            //                                   flex: 1,
            //                                   child: Text(
            //                                     "${index + 1}",
            //                                     textAlign: TextAlign.start,
            //                                     style: const TextStyle(
            //                                         color: Colors.blue),
            //                                   ),
            //                                 ),
            //                                 Expanded(
            //                                     flex: 4,
            //                                     child: Text(
            //                                       "${data?.firstTicketLetter ?? ""}- ${data?.lastTicketLetter ?? ""} ${data?.ticketNumber ?? ""}",
            //                                       textAlign: TextAlign.center,
            //                                       style: Theme.of(context)
            //                                           .textTheme
            //                                           .bodyMedium,
            //                                     )),
            //                                 Expanded(
            //                                     flex: 2,
            //                                     child: Text(
            //                                       data?.prizeName ?? "",
            //                                       textAlign: TextAlign.center,
            //                                       style: Theme.of(context)
            //                                           .textTheme
            //                                           .bodyMedium,
            //                                     )),
            //                               ],
            //                             ),
            //                           ),
            //                         );
            //                       },
            //                     )
            //                   : const Center(
            //                       child: Text("No Data!"),
            //                     ))),

            //     ],
            //   ),

            // ),
            // ),
          ],
        ),
      ),
    );
  }
}
