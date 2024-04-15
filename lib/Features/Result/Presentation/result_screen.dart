import 'package:distech_technology/Commons/app_colors.dart';
import 'package:distech_technology/Controller/Ticket%20Controller/sold_ticket_controller.dart';
import 'package:distech_technology/Features/Vew%20Prizes/Controller/prize_controller.dart';
import 'package:distech_technology/Widgets/custom_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../Controller/Timer Controller/timer_controller.dart';

class ResultScreen extends StatelessWidget {
  ResultScreen({super.key, this.isComminFromDashboard = false});
  bool isComminFromDashboard;
  ScrollController? controller = ScrollController();
  final soldTicketController = Get.put(SoldTicketController());
  final getMyDashboardController = Get.put(PrizesController());
  final timerController = Get.put(TimerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: Obx(
          () => getMyDashboardController.getMyDashboardLoadfing.value == true
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isComminFromDashboard
                        ? AppBar(
                            title: const Text("result").tr(),
                          )
                        : const SizedBox.shrink(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: isComminFromDashboard ? 20 : 8,
                          horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              isComminFromDashboard ? "selectedDate" : "sesult",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                            ).tr(),
                          ),
                          Expanded(
                              child: CustomTextField(
                            height: MediaQuery.of(context).size.height * 0.06,
                            readOnly: true,
                            onTap: () async {
                              await getMyDashboardController
                                  .selectDateForCheckPrizes(context);
                            },
                            controller: getMyDashboardController
                                .pwtDateController.value,
                            suffixIcon: const Icon(Icons.date_range),
                          )),
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
                              ? Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.3),
                                    child: const Text("noTicketsFound").tr(),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      const SizedBox(height: 20),
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
                                                        BorderRadius.circular(
                                                            5)),
                                                margin: const EdgeInsets.all(1),
                                                child: Center(
                                                  child: Text(
                                                      getMyDashboardController
                                                                  .getPrizeModel
                                                                  .value
                                                                  .resultList!
                                                                  .result!
                                                                  .secondPrize?[
                                                              i] ??
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
                                                        BorderRadius.circular(
                                                            5)),
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
                                                        BorderRadius.circular(
                                                            5)),
                                                margin: const EdgeInsets.all(1),
                                                child: Center(
                                                  child: Text(
                                                      getMyDashboardController
                                                                  .getPrizeModel
                                                                  .value
                                                                  .resultList!
                                                                  .result!
                                                                  .fourthPrize?[
                                                              k] ??
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
                                                        BorderRadius.circular(
                                                            5)),
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
