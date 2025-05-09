// import 'package:distech_technology/Commons/app_colors.dart';
// import 'package:distech_technology/Commons/app_icons.dart';
// import 'package:distech_technology/Commons/app_sizes.dart';
// import 'package:distech_technology/Controller/Ticket%20Controller/sold_ticket_controller.dart';
// import 'package:distech_technology/Widgets/custom_chip.dart';
// import 'package:distech_technology/Widgets/custom_divider.dart';
// import 'package:distech_technology/Widgets/full_button.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../Features/Home/Models/sem_model.dart';

// class FilterDialog extends StatefulWidget {
//   final String selectedDate;
//   const FilterDialog({Key? key, required this.selectedDate}) : super(key: key);

//   @override
//   State<FilterDialog> createState() => _FilterDialogState();
// }

// class _FilterDialogState extends State<FilterDialog> {
//   final soldTicketController = Get.put(SoldTicketController());
//   int _selectedIndex = -1;

//   void _onButtonSelected(int index) {
//     setState(() {
//       _selectedIndex = index;
//       int sem = semList[index].label!;
//       soldTicketController.semNumber.value = sem;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height * 0.65,
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
//       ),
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(bottom: AppSizes.kDefaultPadding),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Row(
//                     children: [
//                       Image.asset(
//                         AppIcons.filterIcon,
//                         width: 24,
//                         height: 24,
//                         color: AppColors.primary,
//                       ),
//                       const SizedBox(
//                         width: AppSizes.kDefaultPadding / 3,
//                       ),
//                       Text(
//                         'Filter',
//                         style: Theme.of(context)
//                             .textTheme
//                             .headlineMedium!
//                             .copyWith(
//                                 color: AppColors.darkGrey.withOpacity(0.8),
//                                 fontWeight: FontWeight.w500),
//                       ),
//                     ],
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () => Navigator.pop(context),
//                   child: Image.asset(
//                     AppIcons.closeIcon,
//                     width: 16,
//                     height: 16,
//                     color: AppColors.primary,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const CustomDivider(),
//           Padding(
//             padding:
//                 const EdgeInsets.symmetric(vertical: AppSizes.kDefaultPadding),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Filter by SEM',
//                   style: Theme.of(context).textTheme.headlineSmall!.copyWith(
//                       color: AppColors.darkGrey.withOpacity(0.8),
//                       fontWeight: FontWeight.w500),
//                 ),
//                 InkWell(
//                     onTap: () async {
//                       soldTicketController.filterSemClear(0);
//                       await soldTicketController.getAllTicket();
//                       Navigator.pop(context);
//                     },
//                     child: Text(
//                       'Clear',
//                       style: Theme.of(context)
//                           .textTheme
//                           .headlineSmall!
//                           .copyWith(
//                               color: AppColors.primary,
//                               fontWeight: FontWeight.w400),
//                     ))
//               ],
//             ),
//           ),
//           const SizedBox(
//             height: AppSizes.kDefaultPadding,
//           ),
//           Flexible(
//             child: Scrollbar(
//               child: GridView.builder(
//                 itemCount: semList.length,
//                 shrinkWrap: false,
//                 physics: const BouncingScrollPhysics(),
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: 1 / 0.4, // child height
//                   mainAxisSpacing: AppSizes.kDefaultPadding,
//                   crossAxisSpacing: AppSizes.kDefaultPadding,
//                 ),
//                 itemBuilder: (BuildContext context, int index) {
//                   return ElevatedButton(
//                     onPressed: () => _onButtonSelected(index),
//                     style: ElevatedButton.styleFrom(
//                       primary:
//                           _selectedIndex == index ? Colors.blue : Colors.grey,
//                     ),
//                     child: Text("${semList[index].label} SEM"),
//                   );
//                 },
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: AppSizes.kDefaultPadding,
//           ),
//           Obx(() => FullButton(
//               label: soldTicketController.isAllTicketLoading.value == false
//                   ? 'Apply'
//                   : "Please wait...",
//               onPressed: () async {
//                 await soldTicketController.getAllTicket(
//                     search: soldTicketController.searchText.value,
//                     semNumber: soldTicketController.semNumber.value,date: widget.selectedDate);
//                 Navigator.pop(context);
//               }))
//         ],
//       ),
//     );
//   }
// }
