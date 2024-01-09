import 'package:distech_technology/Controller/Claim%20Controller/my_claim_controller.dart';
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
        padding: EdgeInsets.symmetric(
            horizontal: AppSizes.kDefaultPadding,
            vertical: AppSizes.kDefaultPadding / 2),
        child: Obx(
          () => Column(
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
                height: AppSizes.kDefaultPadding / 2,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: CustomTextField(
                      controller:
                          myClaimController.myClaimSearcController.value,
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
              SizedBox(height: AppSizes.kDefaultPadding / 2),
              rowText(
                  title1: 'Total Claims: ',
                  title2: 'Pending Claims: ',
                  val1:
                      '${myClaimController.myClaimTicketModel.value.claimCounts?.total ?? 0}',
                  val2:
                      '${myClaimController.myClaimTicketModel.value.claimCounts?.pending ?? 0}'),
              rowText(
                  title1: 'Approved Claims: ',
                  title2: 'Rejected Claims: ',
                  val1:
                      '${myClaimController.myClaimTicketModel.value.claimCounts?.approved ?? 0}',
                  val2: '0'),
              const SizedBox(height: 20),
              myClaimController.isClaimingDataLoading == true
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : myClaimController.claimsDataList.isEmpty
                      ? const Center(
                          child: Text("No Data Found"),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: myClaimController.claimsDataList.length,
                            itemBuilder: (context, index) {
                              var data = myClaimController.claimsDataList;
                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.primaryBg),
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
                                                  text: "SCAN DATE\n",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TextSpan(
                                                  text: "${data[index].date}",
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
                                                  text: "CLAIMS\n",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TextSpan(
                                                  text: "${data[index].claims}",
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
                                                  text: "ALL CLAIMS\n",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TextSpan(
                                                  text: "${data[index].all}",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
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
                                                  text: "PENDING\n",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TextSpan(
                                                  text:
                                                      "${data[index].pending}",
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
                                                  text: "APPROVED\n",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TextSpan(
                                                  text:
                                                      "${data[index].approved}",
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
                                                  text: "REJECTED\n",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TextSpan(
                                                  text:
                                                      "${data[index].rejected}",
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
                         
                         
                         
                            },
                          ),
                        )
            ],
          ),
        ),
      ),
    );
  }

  Widget rowText({String? title1, String? title2, String? val1, String? val2}) {
    return Padding(
      padding: EdgeInsets.only(
        top: AppSizes.kDefaultPadding / 10,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: title1,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                    text: val1,
                    style: const TextStyle(fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: title2,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                    text: val2,
                    style: const TextStyle(fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }



}
