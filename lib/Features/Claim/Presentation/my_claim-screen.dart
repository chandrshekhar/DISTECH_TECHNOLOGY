import 'package:distech_technology/Controller/Claim%20Controller/my_claim_controller.dart';
import 'package:distech_technology/Widgets/custom_divider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Commons/app_colors.dart';
import '../../../Commons/app_icons.dart';
import '../../../Commons/app_sizes.dart';
import '../../../Widgets/custom_text_field.dart';
import '../../Dashboard/Presentation/drop_down.dart';

class MyClaimScreen extends StatefulWidget {
  const MyClaimScreen({super.key});

  @override
  State<MyClaimScreen> createState() => _MyClaimScreenState();
}

class _MyClaimScreenState extends State<MyClaimScreen> {
  final myClaimController = Get.put(MyClaimController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(AppSizes.kDefaultPadding),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'My Claims By Date',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.w400),
                ),
                const Spacer(),
                AppDropDown(
                    onChanged: (value) async {
                      // soldTicketController.limit.value = value;
                      // soldTicketController.dropDownValue.value = value;
                      // await soldTicketController.getAllTicket(
                      //     date: formatedDate,
                      //     search: soldTicketController.searchText.value,
                      //     semNumber: soldTicketController.semNumber.value);
                    },
                    list: myClaimController.selectDropDownLimit)
              ],
            ),
            SizedBox(
              height: AppSizes.kDefaultPadding,
            ),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: CustomTextField(
                    controller: myClaimController.myClaimSearcController.value,
                    hintText: 'Search',
                    prefixIcon: const Icon(
                      EvaIcons.searchOutline,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    onChanged: (value) {
                      if (value.toString().isNotEmpty) {
                      } else {}
                    },
                    maxLines: 1,
                    minLines: 1,
                    isBorder: false,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                // Expanded(
                //   flex: 1,
                //   child: InkWell(
                //     onTap: () {
                //       showDialog(
                //           context: context,
                //           builder: (context) {
                //             return AlertDialog(
                //               content: FilterDialog(
                //                 selectedDate: formatedDate,
                //               ),
                //             );
                //           });
                //     },
                //     child: Container(
                //       padding: const EdgeInsets.all(
                //           AppSizes.kDefaultPadding / 1.5),
                //       height: AppSizes.buttonHeight + 4,
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(
                //               AppSizes.cardCornerRadius / 2),
                //           border: Border.all(color: AppColors.bg)),
                //       child: Image.asset(
                //         AppIcons.filterIcon,
                //         width: 25,
                //         height: 25,
                //       ),
                //     ),
                //   ),
                // ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                    myClaimController.selectDate(context);
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
            const SizedBox(
              height: 15,
            ),
          //const CustomDivider(),
          ],
        ),
      ),
    );
  }
}
