import 'package:distech_technology/Controller/Claim%20Controller/my_claim_controller.dart';
import 'package:distech_technology/Features/Claim/Widgets/row_text.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Commons/app_colors.dart';
import '../../../Commons/app_sizes.dart';
import '../../../Widgets/custom_text_field.dart';
import '../../Dashboard/Presentation/drop_down.dart';

class MyClaimScreen extends StatefulWidget {
  const MyClaimScreen({super.key});

  @override
  State<MyClaimScreen> createState() => _MyClaimScreenState();
}

class _MyClaimScreenState extends State<MyClaimScreen> {
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
      Get.delete<MyClaimController>();
  }
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
                  Expanded(
                    child: Text(
                      'My Claims',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.w400, fontSize: 17),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: CustomTextField(
                        height: MediaQuery.of(context).size.height * 0.07,
                        readOnly: true,
                        onTap: () async {
                          myClaimController.selectDate(context);
                        },
                        controller:
                            myClaimController.dateEditingController.value,
                        suffixIcon: const Icon(Icons.date_range),
                      )),
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
                      height: MediaQuery.of(context).size.height * 0.065,
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
                  AppDropDown(
                      onChanged: (value) async {
                        // soldTicketController.limit.value = value;
                        // soldTicketController.dropDownValue.value = value;
                        // await soldTicketController.getAllTicket(
                        //     date: formatedDate,
                        //     search: soldTicketController.searchText.value,
                        //     semNumber: soldTicketController.semNumber.value);
                      },
                      list: myClaimController.selectDropDownLimit),
                ],
              ),
              SizedBox(height: AppSizes.kDefaultPadding / 2),
              RowTextCard(
                  title1: 'Total Claims: ',
                  title2: 'Pending Claims: ',
                  val1:
                      '${myClaimController.myClaimTicketModel.value.claimCounts?.total ?? 0}',
                  val2:
                      '${myClaimController.myClaimTicketModel.value.claimCounts?.pending ?? 0}'),
              RowTextCard(
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
                                                  text:
                                                      "${data[index].claims ?? 0}",
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
}
