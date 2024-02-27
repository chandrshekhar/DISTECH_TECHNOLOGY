import 'package:distech_technology/Commons/app_colors.dart';
import 'package:flutter/material.dart';

class ViewBillsScreen extends StatefulWidget {
  const ViewBillsScreen({super.key});

  @override
  State<ViewBillsScreen> createState() => _ViewBillsScreenState();
}

class _ViewBillsScreenState extends State<ViewBillsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.lightGrey.withOpacity(0.1),
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
                const Text("Mr Chp Pandey",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                const Text(
                  "pandey211998@gmail.com",
                  style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w400, height: 1.3),
                ),
                const Text(
                  "Kolkata sector v, Kolkata, 700120",
                  style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w400, height: 1.3),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      boxShadow: [],
                      color: AppColors.white.withOpacity(0.9),
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
                          value: "2024-02-23  2024-02-23"),
                      cardRowWidget(key: "TOTAL TICKETS : ", value: "500"),
                      cardRowWidget(key: "RATE : ", value: "1133"),
                      cardRowWidget(key: "AMOUNT : ", value: "566500.00"),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "SUPPLY",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                height: 1.3),
                          ),
                          Text(
                            "₹5,66,500.00",
                            style: TextStyle(
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
                      color: AppColors.white.withOpacity(0.9),
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
                          value: "2024-02-23  2024-02-23"),
                      cardRowWidget(key: "TOTAL TICKETS : ", value: "500"),
                      cardRowWidget(key: "RATE : ", value: "1133"),
                      cardRowWidget(key: "AMOUNT : ", value: "566500.00"),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "SUPPLY - UNSOLD = ",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                height: 1.3),
                          ),
                          Text(
                            "₹5,66,500.00",
                            style: TextStyle(
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
                      color: AppColors.white.withOpacity(0.9),
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
                          key: "DATE RANGE : ",
                          value: "2024-02-23  2024-02-23"),
                      cardRowWidget(key: "TOTAL TICKETS : ", value: "500"),
                      // cardRowWidget(key: "RATE : ", value: "1133"),
                      cardRowWidget(key: "AMOUNT : ", value: "566500.00"),
                      const SizedBox(height: 5),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "SUPPLY - (UNSOLD + VOUCHER) = ",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                height: 1.3),
                          ),
                          Expanded(
                            child: Text(
                              "₹5,66,500.00",
                              style: TextStyle(
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
                      color: AppColors.white.withOpacity(0.9),
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
                          key: "DATE RANGE : ",
                          value: "2024-02-23  2024-02-23"),
                      cardRowWidget(key: "TOTAL TICKETS : ", value: "500"),
                      // cardRowWidget(key: "RATE : ", value: "1133"),
                      cardRowWidget(key: "AMOUNT : ", value: "566500.00"),
                      const SizedBox(height: 5),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "SUPPLY - (PWT+UNSOLD+VOUCHER) = ",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                height: 1.3),
                          ),
                          Expanded(
                            child: Text(
                              "Remaining: ₹5,66,500.00",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  height: 1.3),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
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
