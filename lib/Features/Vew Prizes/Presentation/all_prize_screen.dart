// import 'package:distech_technology/Commons/app_colors.dart';
// import 'package:distech_technology/Commons/app_icons.dart';
// import 'package:distech_technology/Commons/app_sizes.dart';
// import 'package:distech_technology/Controller/Ticket%20Controller/sold_ticket_controller.dart';
// import 'package:distech_technology/Controller/Ticket%20Controller/sold_ticket_list_controller.dart';
// import 'package:distech_technology/Features/Vew%20Prizes/Controller/prize_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';

// import '../../../Controller/Claim Controller/new_claim_controller.dart';
// import '../../../Controller/Timer Controller/timer_controller.dart';
// import '../../../Utils/Toast/app_toast.dart';

// class AllPrizeScreen extends StatefulWidget {
//   const AllPrizeScreen({super.key});

//   @override
//   State<AllPrizeScreen> createState() => _AllPrizeScreenState();
// }

// class _AllPrizeScreenState extends State<AllPrizeScreen> {
//   ScrollController? controller = ScrollController();

//   final soldTicketController = Get.put(SoldTicketController());

//   final getMyDashboardController = Get.put(PrizesController());

//   final timerController = Get.put(TimerController());
//   final newClaimController = Get.put(NewClaimController());
//   final soldTicketListController = Get.put(SoldTicketListController());
//   @override
//   void initState() {
//     newClaimController.fromTicketScanValue.value = '';
//     newClaimController.toTicketScanValue.value = '';
//     newClaimController.getMyCnf();
//     // getMyDashboardController.isPopupShowing.value == true

//     //     ? null
//     //     : getAlerttDialog();

//     super.initState();
//   }

//   // getAlerttDialog() async {
//   //   await Future.delayed(const Duration(microseconds: 100), () {
//   //     AwesomeDialog(
//   //             context: context,
//   //             dialogType: DialogType.info,
//   //             animType: AnimType.bottomSlide,
//   //             dismissOnTouchOutside: false,
//   //             body: Padding(
//   //               padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
//   //               child: Obx(() => timerController.slotList.isNotEmpty
//   //                   ? Column(
//   //                       children: List.generate(
//   //                         timerController.slotList.length,
//   //                         (index) => Padding(
//   //                           padding: const EdgeInsets.only(bottom: 20),
//   //                           child: ListTile(
//   //                             selected: true,
//   //                             shape: RoundedRectangleBorder(
//   //                                 borderRadius: BorderRadius.circular(20),
//   //                                 side: const BorderSide(
//   //                                     color: AppColors.primary)),
//   //                             onTap: () {
//   //                               timerController.intialSlot.value =
//   //                                   timerController.slotList[index].name ?? "";
//   //                               timerController.slotId.value =
//   //                                   timerController.slotList[index].sId ?? "";
//   //                               timerController.getServerTime();
//   //                               Navigator.pop(context);
//   //                             },
//   //                             title: Text(
//   //                               timerController.slotList[index].name.toString(),
//   //                               style: const TextStyle(
//   //                                   color: AppColors.primary, fontSize: 25),
//   //                             ),
//   //                           ),
//   //                         ),
//   //                       ),
//   //                     )
//   //                   : const Center(
//   //                       child: CircularProgressIndicator.adaptive())),
//   //             ),
//   //             titleTextStyle: const TextStyle(
//   //                 color: Colors.red, fontWeight: FontWeight.w600, fontSize: 16))
//   //         .show();
//   //     getMyDashboardController.isPopupShowing.value = true;
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: SingleChildScrollView(
//         controller: controller,
//         child: Obx(
//           () => getMyDashboardController.getMyDashboardLoadfing.value == true
//               ? Center(
//                   child: Padding(
//                     padding: EdgeInsets.only(
//                         top: MediaQuery.of(context).size.height * 0.3),
//                     child: const CircularProgressIndicator.adaptive(),
//                   ),
//                 )
//               : Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 8),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Expanded(
//                             child: Text(
//                               'Total (${getMyDashboardController.getModeldashBoard.value.userTypeCount?.stockistCounts?.total.toString()})',
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .headlineSmall!
//                                   .copyWith(
//                                       fontWeight: FontWeight.w400,
//                                       fontSize: 18),
//                             ),
//                           ),
//                           InkWell(
//                             onTap: () async {
//                               await getMyDashboardController
//                                   .selectDateForCheckPrizes(context);
//                               await getMyDashboardController.getMydashboard();
//                               await getMyDashboardController.getPrize();
//                             },
//                             child: Container(
//                               padding:
//                                   EdgeInsets.all(AppSizes.kDefaultPadding / 2),
//                               height: AppSizes.buttonHeight,
//                               // width: AppSizes.button * 3,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(
//                                       AppSizes.cardCornerRadius / 2),
//                                   border: Border.all(color: AppColors.bg)),
//                               child: Image.asset(
//                                 AppIcons.calenderIcon,
//                                 width: 25,
//                                 height: 25,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 10,
//                           ),
//                         ],
//                       ),
//                     ),
//                     priceCard(
//                         value: soldTicketListController.soldTicketCont
//                                 .toString() ??
//                             "0",
//                         date: getMyDashboardController.formatedDate.toString(),
//                         title: "Sold Tickets",
//                         color: const Color(0xFF29C57F),
//                         imagePath: AppIcons.prize),
//                     priceCard(
//                         value:
//                             "${soldTicketController.allticketCount.value - soldTicketListController.soldTicketCont.value}"
//                                     .toString() ??
//                                 "0",
//                         date: getMyDashboardController.formatedDate.toString(),
//                         title: "Unsold Tickets",
//                         color: const Color(0xFFFF2E17),
//                         imagePath: AppIcons.soldTicket),
//                     priceCard(
//                         value: soldTicketController.allticketCount.value
//                             .toString(),
//                         date: getMyDashboardController.formatedDate.toString(),
//                         title: "Supplied Tickets",
//                         color: const Color(0xFFFFBF1C),
//                         imagePath: AppIcons.soldTicket),

//                     Padding(
//                       padding: const EdgeInsets.all(20.0),
//                       child: Obx(
//                         () => Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 Expanded(
//                                   flex: 5,
//                                   child: Text(
//                                     "All claims you scan will be registered under ${newClaimController.fullName}",
//                                   ),
//                                 ),
//                                 Expanded(
//                                   // flex: 1,
//                                   child: InkWell(
//                                     onTap: () {
//                                       newClaimController.selectDate(context);
//                                     },
//                                     child: Container(
//                                       padding: EdgeInsets.all(
//                                           AppSizes.kDefaultPadding / 1.5),
//                                       height: AppSizes.buttonHeight + 4,
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(
//                                               AppSizes.cardCornerRadius / 2),
//                                           border:
//                                               Border.all(color: AppColors.bg)),
//                                       child: Image.asset(
//                                         AppIcons.calenderIcon,
//                                         width: 25,
//                                         height: 25,
//                                       ),
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),

//                             SizedBox(height: AppSizes.bodyText1),
//                             customTileCard(
//                               title: "From Tickets",
//                               subTitle:
//                                   newClaimController.fromTicketScanValue.value,
//                               onTap: () async {
//                                 // newClaimController.createSignature("B7393471Z");
//                                 if (newClaimController
//                                     .dateFormat.value.isEmpty) {
//                                   ToastMessage().toast(
//                                       context: context,
//                                       background: Colors.red,
//                                       message: "Please select date",
//                                       messageColor: Colors.white);
//                                 } else {
//                                   newClaimController.scanBarCode(true, context);
//                                 }
//                               },
//                             ),

//                             Obx(
//                               () => newClaimController
//                                       .fromTicketScanValue.value.isNotEmpty
//                                   ? customTileCard(
//                                       title: "To Tickets",
//                                       subTitle: newClaimController
//                                           .toTicketScanValue.value,
//                                       onTap: () {
//                                         newClaimController.scanBarCode(
//                                             false, context);
//                                       })
//                                   : const SizedBox.shrink(),
//                             ),

//                             // const SizedBox(height: 20),
//                             //   Text("Ticket--> ${scanbarcodeController.barcodeValue}"),

//                             Obx(() => newClaimController
//                                         .fromTicketScanValue.value.isNotEmpty &&
//                                     newClaimController
//                                         .toTicketScanValue.value.isNotEmpty
//                                 ? Align(
//                                     alignment: Alignment.centerRight,
//                                     child: FloatingActionButton(
//                                         mini: true,
//                                         child: const Icon(Icons.add),
//                                         onPressed: () {
//                                           // newClaimController.createSignature("B7393471Z");
//                                           newClaimController.handleAdd(context);
//                                         }))
//                                 : const SizedBox.shrink()),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             ListView.builder(
//                               shrinkWrap: true,
//                               itemCount:
//                                   newClaimController.ticketClaimList.length,
//                               itemBuilder: (context, index) {
//                                 return customTicketCard(
//                                     newClaimController.ticketClaimList[index]);
//                               },
//                             )
//                           ],
//                         ),
//                       ),
//                     ),

//                     // Obx(
//                     //   () => getMyDashboardController.getPrizeLoading == true
//                     //       ? const Center(
//                     //           child: CircularProgressIndicator.adaptive(),
//                     //         )
//                     //       : getMyDashboardController
//                     //                   .getPrizeModel.value.resultList ==
//                     //               null
//                     //           ? const SizedBox()
//                     //           : Column(
//                     //               crossAxisAlignment: CrossAxisAlignment.start,
//                     //               children: [
//                     //                 Container(
//                     //                   width: double.infinity,
//                     //                   padding: const EdgeInsets.all(5),
//                     //                   alignment: Alignment.center,
//                     //                   decoration:
//                     //                       BoxDecoration(border: Border.all()),
//                     //                   child: Text(
//                     //                     "Result for Draw held on ${getMyDashboardController.getPrizeModel.value.date ?? ""} Price 10/-",
//                     //                     style: const TextStyle(
//                     //                         fontSize: 15,
//                     //                         fontWeight: FontWeight.bold,
//                     //                         color: Colors.black),
//                     //                   ),
//                     //                 ),
//                     //                 const SizedBox(height: 10),
//                     //                 Text(
//                     //                   "1st Prize ₹${getMyDashboardController.getPrizeModel.value.prizes?.winningPrize?.firstPrize ?? "0"}",
//                     //                   style: const TextStyle(
//                     //                       fontSize: 18,
//                     //                       color: Colors.black,
//                     //                       fontWeight: FontWeight.bold),
//                     //                 ),
//                     //                 Container(
//                     //                     alignment: Alignment.center,
//                     //                     margin: const EdgeInsets.symmetric(
//                     //                         vertical: 5),
//                     //                     width: double.infinity,
//                     //                     padding: const EdgeInsets.symmetric(
//                     //                         vertical: 10),
//                     //                     decoration: BoxDecoration(
//                     //                         color: AppColors.lightGrey
//                     //                             .withOpacity(0.5),
//                     //                         borderRadius:
//                     //                             BorderRadius.circular(5)),
//                     //                     child: Text(getMyDashboardController
//                     //                             .getPrizeModel
//                     //                             .value
//                     //                             .resultList
//                     //                             ?.result
//                     //                             ?.firstPrize?[0] ??
//                     //                         "0")),
//                     //                 Padding(
//                     //                   padding: const EdgeInsets.only(
//                     //                       top: 5, bottom: 2),
//                     //                   child: Text(
//                     //                     "2nd Prize ₹${getMyDashboardController.getPrizeModel.value.prizes?.winningPrize?.secondPrize ?? "0"}",
//                     //                     style: const TextStyle(
//                     //                         fontSize: 18,
//                     //                         color: Colors.black,
//                     //                         fontWeight: FontWeight.bold),
//                     //                   ),
//                     //                 ),
//                     //                 GridView.count(
//                     //                     crossAxisCount: 5,
//                     //                     shrinkWrap: true,
//                     //                     childAspectRatio: 2,
//                     //                     controller: controller,
//                     //                     children: List.generate(
//                     //                       getMyDashboardController
//                     //                           .getPrizeModel
//                     //                           .value
//                     //                           .resultList!
//                     //                           .result!
//                     //                           .secondPrize!
//                     //                           .length,
//                     //                       (i) {
//                     //                         return Container(
//                     //                           decoration: BoxDecoration(
//                     //                               color: AppColors.lightGrey
//                     //                                   .withOpacity(0.5),
//                     //                               borderRadius:
//                     //                                   BorderRadius.circular(5)),
//                     //                           margin: const EdgeInsets.all(1),
//                     //                           child: Center(
//                     //                             child: Text(
//                     //                                 getMyDashboardController
//                     //                                         .getPrizeModel
//                     //                                         .value
//                     //                                         .resultList!
//                     //                                         .result!
//                     //                                         .secondPrize?[i] ??
//                     //                                     ""),
//                     //                           ),
//                     //                         );
//                     //                       },
//                     //                     )),
//                     //                 Padding(
//                     //                   padding: const EdgeInsets.only(
//                     //                       top: 10, bottom: 2),
//                     //                   child: Text(
//                     //                     "3nd Prize ₹${getMyDashboardController.getPrizeModel.value.prizes?.winningPrize?.thirdPrize ?? "0"}",
//                     //                     style: const TextStyle(
//                     //                         fontSize: 18,
//                     //                         color: Colors.black,
//                     //                         fontWeight: FontWeight.bold),
//                     //                   ),
//                     //                 ),
//                     //                 GridView.count(
//                     //                     crossAxisCount: 5,
//                     //                     shrinkWrap: true,
//                     //                     childAspectRatio: 2,
//                     //                     controller: controller,
//                     //                     children: List.generate(
//                     //                       getMyDashboardController
//                     //                           .getPrizeModel
//                     //                           .value
//                     //                           .resultList!
//                     //                           .result!
//                     //                           .thirdPrize!
//                     //                           .length,
//                     //                       (j) {
//                     //                         return Container(
//                     //                           decoration: BoxDecoration(
//                     //                               color: AppColors.lightGrey
//                     //                                   .withOpacity(0.5),
//                     //                               borderRadius:
//                     //                                   BorderRadius.circular(5)),
//                     //                           margin: const EdgeInsets.all(1),
//                     //                           child: Center(
//                     //                             child: Text(
//                     //                                 getMyDashboardController
//                     //                                         .getPrizeModel
//                     //                                         .value
//                     //                                         .resultList!
//                     //                                         .result!
//                     //                                         .thirdPrize?[j] ??
//                     //                                     ""),
//                     //                           ),
//                     //                         );
//                     //                       },
//                     //                     )),
//                     //                 Padding(
//                     //                   padding: const EdgeInsets.only(
//                     //                       top: 10, bottom: 2),
//                     //                   child: Text(
//                     //                     "4th Prize ₹${getMyDashboardController.getPrizeModel.value.prizes?.winningPrize?.fourthPrize ?? "0"}",
//                     //                     style: const TextStyle(
//                     //                         fontSize: 18,
//                     //                         color: Colors.black,
//                     //                         fontWeight: FontWeight.bold),
//                     //                   ),
//                     //                 ),
//                     //                 GridView.count(
//                     //                     crossAxisCount: 5,
//                     //                     shrinkWrap: true,
//                     //                     childAspectRatio: 2,
//                     //                     controller: controller,
//                     //                     children: List.generate(
//                     //                       getMyDashboardController
//                     //                           .getPrizeModel
//                     //                           .value
//                     //                           .resultList!
//                     //                           .result!
//                     //                           .fourthPrize!
//                     //                           .length,
//                     //                       (k) {
//                     //                         return Container(
//                     //                           decoration: BoxDecoration(
//                     //                               color: AppColors.lightGrey
//                     //                                   .withOpacity(0.5),
//                     //                               borderRadius:
//                     //                                   BorderRadius.circular(5)),
//                     //                           margin: const EdgeInsets.all(1),
//                     //                           child: Center(
//                     //                             child: Text(
//                     //                                 getMyDashboardController
//                     //                                         .getPrizeModel
//                     //                                         .value
//                     //                                         .resultList!
//                     //                                         .result!
//                     //                                         .fourthPrize?[k] ??
//                     //                                     ""),
//                     //                           ),
//                     //                         );
//                     //                       },
//                     //                     )),
//                     //                 Padding(
//                     //                   padding: const EdgeInsets.only(
//                     //                       top: 10, bottom: 2),
//                     //                   child: Text(
//                     //                     "5th Prize ₹${getMyDashboardController.getPrizeModel.value.prizes?.winningPrize?.fifthPrize ?? "0"}",
//                     //                     style: const TextStyle(
//                     //                         fontSize: 18,
//                     //                         color: Colors.black,
//                     //                         fontWeight: FontWeight.bold),
//                     //                   ),
//                     //                 ),
//                     //                 GridView.count(
//                     //                     crossAxisCount: 5,
//                     //                     shrinkWrap: true,
//                     //                     childAspectRatio: 2,
//                     //                     controller: controller,
//                     //                     children: List.generate(
//                     //                       getMyDashboardController
//                     //                           .getPrizeModel
//                     //                           .value
//                     //                           .resultList!
//                     //                           .result!
//                     //                           .fifthPrize!
//                     //                           .length,
//                     //                       (l) {
//                     //                         return Container(
//                     //                           decoration: BoxDecoration(
//                     //                               color: AppColors.lightGrey
//                     //                                   .withOpacity(0.5),
//                     //                               borderRadius:
//                     //                                   BorderRadius.circular(5)),
//                     //                           margin: const EdgeInsets.all(1),
//                     //                           child: Center(
//                     //                             child: Text(
//                     //                                 getMyDashboardController
//                     //                                         .getPrizeModel
//                     //                                         .value
//                     //                                         .resultList!
//                     //                                         .result!
//                     //                                         .fifthPrize?[l] ??
//                     //                                     ""),
//                     //                           ),
//                     //                         );
//                     //                       },
//                     //                     )),
//                     //               ],
//                     //             ),
//                     // ),

//                     const SizedBox(
//                       height: 50,
//                     )
//                   ],
//                 ),
//         ),
//       ),
//     );
//   }

//   Widget priceCard({
//     required String value,
//     String? date,
//     String? title,
//     required Color color,
//     required String imagePath,
//   }) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 5),
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: color,
//       ),
//       child: Row(
//         children: [
//           SvgPicture.asset(
//             imagePath,
//             color: AppColors.white,
//             height: 30,
//             width: 30,
//           ),
//           Container(
//               margin: const EdgeInsets.symmetric(horizontal: 20),
//               width: 0.5,
//               height: 35,
//               color: Colors.white),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Text(
//                 "$title   ${date ?? ""}",
//                 style: const TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.white),
//               ),
//               const SizedBox(height: 5),
//               Text(
//                 value,
//                 style: const TextStyle(
//                     fontSize: 18,
//                     letterSpacing: 1,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget customTileCard(
//       {String? title,
//       required String subTitle,
//       void Function()? onTap,
//       String? icon}) {
//     return Container(
//       padding: EdgeInsets.all(AppSizes.cardCornerRadius),
//       margin: const EdgeInsets.only(bottom: 7),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius / 2),
//           border: Border.all(color: AppColors.bg)),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text.rich(
//             TextSpan(
//               children: [
//                 TextSpan(
//                     text: '$title ',
//                     style: const TextStyle(
//                       fontSize: 16,
//                     )),
//                 TextSpan(
//                   text: subTitle.isNotEmpty ? "($subTitle)" : '',
//                   style: const TextStyle(
//                       fontWeight: FontWeight.w500, fontSize: 16),
//                 ),
//               ],
//             ),
//           ),
//           Obx(() => newClaimController.fromTicketScaning.value ||
//                   newClaimController.toTicketScaing.value
//               ? const Center(
//                   child: SizedBox(
//                       height: 20,
//                       width: 20,
//                       child: CircularProgressIndicator.adaptive()),
//                 )
//               : InkWell(
//                   onTap: onTap,
//                   child: Image.asset(
//                     icon ?? "assets/icons/barcode-scanner.png",
//                     width: 25,
//                     height: 25,
//                   ),
//                 )),
//         ],
//       ),
//     );
//   }

//   Widget customTicketCard(ClaimModel claimModel) {
//     return Container(
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10), color: AppColors.primaryBg),
//       margin: const EdgeInsets.symmetric(vertical: 5),
//       padding: const EdgeInsets.all(10),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: Text.rich(
//                   TextSpan(
//                     children: [
//                       const TextSpan(
//                         text: "From Ticket\n",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       TextSpan(
//                         text: claimModel.fromTicket,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Text.rich(
//                   TextSpan(
//                     children: [
//                       const TextSpan(
//                         text: "To Ticket\n",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       TextSpan(
//                         text: claimModel.toTicket,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 5,
//           ),
//           Row(
//             children: [
//               Expanded(
//                 child: Text.rich(
//                   TextSpan(
//                     children: [
//                       const TextSpan(
//                         text: "Total Ticket\n",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       TextSpan(
//                         text: claimModel.totalTicket.toString(),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Text.rich(
//                   TextSpan(
//                     children: [
//                       const TextSpan(
//                         text: "Total Amount\n",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       TextSpan(
//                         text: claimModel.totalAmount.toString(),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
