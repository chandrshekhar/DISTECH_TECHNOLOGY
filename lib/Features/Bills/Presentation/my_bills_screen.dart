import 'package:distech_technology/Commons/app_colors.dart';
import 'package:distech_technology/Features/Bills/Controller/my_bislls_controller.dart';
import 'package:distech_technology/Features/Bills/Presentation/view_bills_screen.dart';
import 'package:distech_technology/Utils/date_time_format.dart';
import 'package:distech_technology/Widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyBillsScreen extends StatefulWidget {
  const MyBillsScreen({super.key});

  @override
  State<MyBillsScreen> createState() => _MyBillsScreenState();
}

class _MyBillsScreenState extends State<MyBillsScreen> {
  final myBillController = Get.put(MyBillsController());

  final scrollController = ScrollController();

  @override
  void initState() {
    myBillController.getMyBills();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    myBillController.textEditController.value.text =
        "${formatDate(date: myBillController.startDate.value, formatType: "dd-MM-yyyy")} - ${formatDate(date: myBillController.endDate.value, formatType: "dd-MM-yyyy")}";
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  const Expanded(
                    flex: 0,
                    child: Text("MY BILLS ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                  ),
                  Expanded(
                      flex: 3,
                      child: CustomTextField(
                        height: MediaQuery.of(context).size.height * 0.06,
                        readOnly: true,
                        onTap: () async {
                          myBillController.textEditController.value.text =
                              await myBillController.selectDate(context) ?? "";
                        },
                        controller: myBillController.textEditController.value,
                        suffixIcon: const Icon(Icons.date_range),
                      )),
                ],
              ),
              const SizedBox(height: 10),
              Obx(
                () => myBillController.isBillLoading.value
                    ? const Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : myBillController.billList.isEmpty
                        ? Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.3),
                            child: const Center(
                              child: Text("No Bill On Date"),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: myBillController.billList.length,
                            controller: scrollController,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                margin: const EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                    color:
                                        AppColors.lightGrey.withOpacity(0.5)),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Expanded(
                                            flex: 1,
                                            child: Text(
                                              "SL",
                                            )),
                                        Expanded(
                                            flex: 3,
                                            child: Text(
                                              "TOTAL REMAINING AMOUNT",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                    color: AppColors.black,
                                                  ),
                                            )),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ViewBillsScreen(
                                                          bills:
                                                              myBillController
                                                                      .billList[
                                                                  index],
                                                        )));
                                          },
                                          child: const Icon(
                                            Icons.visibility,
                                            size: 20,
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                                "${index + 1}".toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        color: AppColors
                                                            .primaryDark
                                                            .withOpacity(
                                                                0.5)))),
                                        Expanded(
                                            flex: 3,
                                            child: Text(
                                                "${myBillController.billList[index].remainingAmount ?? 0}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        color: AppColors
                                                            .primaryDark
                                                            .withOpacity(
                                                                0.5)))),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              "DATE",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                    color: AppColors.black,
                                                  ),
                                            )),
                                        Expanded(
                                            flex: 3,
                                            child: Text(
                                              "TOTAL PAYABLE AMOUNT",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                    color: AppColors.black,
                                                  ),
                                            )),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                                formatDate(
                                                    date: DateTime.parse(
                                                        "${myBillController.billList[index].supply!.fromDate}"),
                                                    formatType: "yyyy/MM/dd"),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        color: AppColors
                                                            .primaryDark
                                                            .withOpacity(
                                                                0.5)))),
                                        Expanded(
                                            flex: 3,
                                            child: Text(
                                                "${myBillController.billList[index].totalPayable ?? 0000}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        color: AppColors
                                                            .primaryDark
                                                            .withOpacity(
                                                                0.5)))),
                                      ],
                                    )
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
