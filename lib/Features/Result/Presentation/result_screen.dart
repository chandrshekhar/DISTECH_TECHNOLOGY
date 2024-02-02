import 'package:distech_technology/Commons/app_colors.dart';
import 'package:distech_technology/Commons/app_icons.dart';
import 'package:distech_technology/Commons/app_sizes.dart';
import 'package:distech_technology/Controller/Ticket%20Controller/sold_ticket_controller.dart';
import 'package:distech_technology/Features/Vew%20Prizes/Controller/prize_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../Controller/Timer Controller/timer_controller.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  ScrollController? controller = ScrollController();

  final soldTicketController = Get.put(SoldTicketController());

  final getMyDashboardController = Get.put(PrizesController());

  final timerController = Get.put(TimerController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        controller: controller,
        child: Obx(
          () => getMyDashboardController.getMyDashboardLoadfing.value == true
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Prize Winning Ticket",
                            style: TextStyle(fontSize: 20),
                          ),
                          InkWell(
                            onTap: () async {
                              await getMyDashboardController
                                  .selectDateForCheckPrizes(context);
                              await getMyDashboardController.getMydashboard();
                              await getMyDashboardController.getPrize();
                            },
                            child: Container(
                              padding:
                                  EdgeInsets.all(AppSizes.kDefaultPadding / 2),
                              height: AppSizes.buttonHeight,
                              // width: AppSizes.button * 3,
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
                          // const SizedBox(
                          //   width: 10,
                          // ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => getMyDashboardController.getPrizeLoading.value ==
                              true
                          ? const Center(
                              child: CircularProgressIndicator.adaptive(),
                            )
                          : getMyDashboardController
                                      .getPrizeModel.value.resultList ==
                                  null
                              ? const Center(
                                  child: Text("No data found!"),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(5),
                                      alignment: Alignment.center,
                                      decoration:
                                          BoxDecoration(border: Border.all()),
                                      child: Text(
                                        "Result for Draw held on ${getMyDashboardController.getPrizeModel.value.date ?? ""} Price 10/-",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "1st Prize ₹${getMyDashboardController.getPrizeModel.value.prizes?.winningPrize?.firstPrize ?? "0"}",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        decoration: BoxDecoration(
                                            color: AppColors.lightGrey
                                                .withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Text(getMyDashboardController
                                                .getPrizeModel
                                                .value
                                                .resultList
                                                ?.result
                                                ?.firstPrize?[0] ??
                                            "0")),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, bottom: 2),
                                      child: Text(
                                        "2nd Prize ₹${getMyDashboardController.getPrizeModel.value.prizes?.winningPrize?.secondPrize ?? "0"}",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    GridView.count(
                                        crossAxisCount: 5,
                                        shrinkWrap: true,
                                        childAspectRatio: 2,
                                        controller: controller,
                                        children: List.generate(
                                          getMyDashboardController
                                              .getPrizeModel
                                              .value
                                              .resultList!
                                              .result!
                                              .secondPrize!
                                              .length,
                                          (i) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                  color: AppColors.lightGrey
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              margin: const EdgeInsets.all(1),
                                              child: Center(
                                                child: Text(
                                                    getMyDashboardController
                                                            .getPrizeModel
                                                            .value
                                                            .resultList!
                                                            .result!
                                                            .secondPrize?[i] ??
                                                        ""),
                                              ),
                                            );
                                          },
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 2),
                                      child: Text(
                                        "3nd Prize ₹${getMyDashboardController.getPrizeModel.value.prizes?.winningPrize?.thirdPrize ?? "0"}",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    GridView.count(
                                        crossAxisCount: 5,
                                        shrinkWrap: true,
                                        childAspectRatio: 2,
                                        controller: controller,
                                        children: List.generate(
                                          getMyDashboardController
                                              .getPrizeModel
                                              .value
                                              .resultList!
                                              .result!
                                              .thirdPrize!
                                              .length,
                                          (j) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                  color: AppColors.lightGrey
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              margin: const EdgeInsets.all(1),
                                              child: Center(
                                                child: Text(
                                                    getMyDashboardController
                                                            .getPrizeModel
                                                            .value
                                                            .resultList!
                                                            .result!
                                                            .thirdPrize?[j] ??
                                                        ""),
                                              ),
                                            );
                                          },
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 2),
                                      child: Text(
                                        "4th Prize ₹${getMyDashboardController.getPrizeModel.value.prizes?.winningPrize?.fourthPrize ?? "0"}",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    GridView.count(
                                        crossAxisCount: 5,
                                        shrinkWrap: true,
                                        childAspectRatio: 2,
                                        controller: controller,
                                        children: List.generate(
                                          getMyDashboardController
                                              .getPrizeModel
                                              .value
                                              .resultList!
                                              .result!
                                              .fourthPrize!
                                              .length,
                                          (k) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                  color: AppColors.lightGrey
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              margin: const EdgeInsets.all(1),
                                              child: Center(
                                                child: Text(
                                                    getMyDashboardController
                                                            .getPrizeModel
                                                            .value
                                                            .resultList!
                                                            .result!
                                                            .fourthPrize?[k] ??
                                                        ""),
                                              ),
                                            );
                                          },
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 2),
                                      child: Text(
                                        "5th Prize ₹${getMyDashboardController.getPrizeModel.value.prizes?.winningPrize?.fifthPrize ?? "0"}",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    GridView.count(
                                        crossAxisCount: 5,
                                        shrinkWrap: true,
                                        childAspectRatio: 2,
                                        controller: controller,
                                        children: List.generate(
                                          getMyDashboardController
                                              .getPrizeModel
                                              .value
                                              .resultList!
                                              .result!
                                              .fifthPrize!
                                              .length,
                                          (l) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                  color: AppColors.lightGrey
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              margin: const EdgeInsets.all(1),
                                              child: Center(
                                                child: Text(
                                                    getMyDashboardController
                                                            .getPrizeModel
                                                            .value
                                                            .resultList!
                                                            .result!
                                                            .fifthPrize?[l] ??
                                                        ""),
                                              ),
                                            );
                                          },
                                        )),
                                  ],
                                ),
                    ),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
        ),
      ),
    );
  }

  Widget priceCard({
    required String value,
    String? date,
    String? title,
    required Color color,
    required String imagePath,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            imagePath,
            color: AppColors.white,
            height: 30,
            width: 30,
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: 0.5,
              height: 35,
              color: Colors.white),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "$title   ${date ?? ""}",
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
              const SizedBox(height: 5),
              Text(
                value,
                style: const TextStyle(
                    fontSize: 18,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
