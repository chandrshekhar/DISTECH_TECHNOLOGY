import 'dart:async';

import 'package:distech_technology/Commons/app_colors.dart';
import 'package:distech_technology/Features/Bills/Controller/my_bislls_controller.dart';
import 'package:distech_technology/Features/Bills/Presentation/view_bills_screen.dart';
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
  Widget build(BuildContext context) {
    myBillController.textEditController.value.text =
        "${myBillController.startDate.value} - ${myBillController.endDate.value}";
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Selected Date",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                      child: CustomTextField(
                    height: MediaQuery.of(context).size.height * 0.05,
                    readOnly: true,
                    onTap: () async {
                      myBillController.textEditController.value.text =
                          await myBillController.selectDate(context) ?? "";
                    },
                    controller: myBillController.textEditController.value,
                    prefixIcon: const Icon(Icons.date_range),
                  )),
                ],
              ),
              const SizedBox(height: 20),
              const Text("MY BILLS",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                controller: scrollController,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    margin: const EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                        color: AppColors.lightGrey.withOpacity(0.5)),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                            const ViewBillsScreen()));
                              },
                              child: const Icon(
                                Icons.visibility,
                                size: 20,
                              ),
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 1,
                                child: Text(index.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: AppColors.primaryDark
                                                .withOpacity(0.5)))),
                            Expanded(
                                flex: 3,
                                child: Text("1234567",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: AppColors.primaryDark
                                                .withOpacity(0.5)))),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                        SizedBox(height: 5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 1,
                                child: Text("23/2/2023",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: AppColors.primaryDark
                                                .withOpacity(0.5)))),
                            Expanded(
                                flex: 3,
                                child: Text("000000",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: AppColors.primaryDark
                                                .withOpacity(0.5)))),
                          ],
                        )
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
