import 'package:distech_technology/Commons/app_colors.dart';
import 'package:distech_technology/Controller/Profile%20Controller/profile_controller.dart';
import 'package:distech_technology/Features/Bills/Models/my_bills_model.dart';
import 'package:distech_technology/Utils/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewBillsScreen extends StatelessWidget {
  ViewBillsScreen({super.key, required this.bills});

  Bills? bills;

  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text("View Bills"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                    profileController.userProfileModel.value.user?.fullName ??
                        "",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                Text(
                  profileController.userProfileModel.value.user?.email ?? "",
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w400, height: 1.3),
                ),
                Text(
                  "${profileController.userProfileModel.value.user?.address1 ?? ""}, ${profileController.userProfileModel.value.user?.address2 ?? ""}",
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w400, height: 1.3),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: AppColors.lightGrey.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "SUPPLY",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            height: 1),
                      ),
                      cardRowWidget(
                          key: "DATE RANGE : ",
                          value:
                              "${formatDate(date: DateTime.parse(bills?.supply?.fromDate ?? ''), formatType: 'yyy-MM-dd')}/${formatDate(date: DateTime.parse(bills?.supply?.toDate ?? ''), formatType: 'yyy-MM-dd')}"),
                      cardRowWidget(
                          key: "TOTAL TICKETS : ",
                          value: "${bills?.supply?.totalTickets ?? 0}"),
                      cardRowWidget(
                          key: "RATE : ", value: "₹${bills?.purchaseRate}"),
                      cardRowWidget(
                          key: "AMOUNT : ",
                          value: "₹${bills?.supply?.totalPrice}"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "SUPPLY",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                height: 1.3),
                          ),
                          Text(
                            "₹${bills?.supply?.totalPrice}",
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                height: 1.3),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: AppColors.lightGrey.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "UNSOLD",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            height: 1),
                      ),
                      cardRowWidget(
                          key: "DATE RANGE : ",
                          value:
                              "${formatDate(date: DateTime.parse(bills?.unsold?.fromDate ?? ''), formatType: 'yyy-MM-dd')}/${formatDate(date: DateTime.parse(bills?.unsold?.toDate ?? ''), formatType: 'yyy-MM-dd')}"),
                      cardRowWidget(
                          key: "TOTAL TICKETS : ",
                          value: "${bills?.unsold?.totalTickets ?? 0}"),
                      cardRowWidget(
                          key: "RATE : ",
                          value: "₹ ${bills?.purchaseRate ?? 0}"),
                      cardRowWidget(
                          key: "AMOUNT : ",
                          value: "₹ ${bills?.unsold?.totalPrice ?? 0}"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "SUPPLY - UNSOLD = ",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                height: 1.3),
                          ),
                          Text(
                            "₹${((bills?.supply?.totalPrice ?? 0) - (bills?.unsold?.totalPrice ?? 0)).toString()}",
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                height: 1.3),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: AppColors.lightGrey.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "VOUCHER",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            height: 1),
                      ),
                      cardRowWidget(
                          key: "DATE RANGE : ", value: "2024-02-23/2024-02-23"),
                      cardRowWidget(key: "TOTAL TICKETS : ", value: "500"),
                      // cardRowWidget(key: "RATE : ", value: "1133"),
                      cardRowWidget(
                          key: "AMOUNT : ",
                          value:
                              "₹${(bills?.voucher?.totalPrice ?? 0).toString()}"),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "SUPPLY - (UNSOLD + VOUCHER) = ",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                height: 1.3),
                          ),
                          Expanded(
                            child: Text(
                              "₹${((bills?.supply?.totalPrice ?? 0) - ((bills?.unsold?.totalPrice ?? 0) + (bills!.voucher!.totalPrice ?? 0) ?? 0)).toString()}",
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  height: 1.3),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: AppColors.lightGrey.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "PWT",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            height: 1),
                      ),
                      cardRowWidget(
                          key: "DATE RANGE : ", value: "2024-02-23/2024-02-23"),
                      cardRowWidget(
                          key: "TOTAL TICKETS : ",
                          value: (bills?.pwt?.totalTickets ?? 0).toString()),
                      // cardRowWidget(
                      //     key: "RATE : ",
                      //     value: "₹ ${bills?.purchaseRate ?? 0}"),
                      cardRowWidget(
                          key: "AMOUNT : ",
                          value:
                              "₹ ${(bills?.pwt?.totalPrice ?? 0).toString()}"),
                      const SizedBox(height: 5),
                      const Text(
                        "SUPPLY - (PWT+UNSOLD+VOUCHER) = ",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            height: 1.3),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Remaining: ₹${((bills?.supply?.totalPrice ?? 0) - ((bills?.unsold?.totalPrice ?? 0) + (bills!.pwt!.totalPrice ?? 0) + (bills!.voucher!.totalPrice ?? 0) ?? 0)).toString()}",
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              height: 1.4),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "TOTAL REAMING = ",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                height: 1.6),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "₹${((bills?.supply?.totalPrice ?? 0) - ((bills?.unsold?.totalPrice ?? 0) + (bills!.pwt!.totalPrice ?? 0) + (bills!.voucher!.totalPrice ?? 0) ?? 0)).toString()}",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: AppColors.lightGrey.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      cardRowWidget(key: "PREVIOUS REMAINING", value: ""),
                      cardRowWidget(
                          key: "AMOUNT =",
                          value: "₹ ${bills?.remainingAmount ?? 0}"),
                      const SizedBox(height: 5),
                      cardRowWidget(
                          key: "TOTAL PAYABLE AMOUNT =",
                          value: "₹ ${bills?.totalPayable ?? 0}"),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cardRowWidget({required String key, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(key,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w400, height: 1.5)),
        Text(value,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w500, height: 1.5)),
      ],
    );
  }
}
