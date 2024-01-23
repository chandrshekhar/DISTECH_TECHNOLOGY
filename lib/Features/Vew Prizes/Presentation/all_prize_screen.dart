import 'package:distech_technology/Commons/app_colors.dart';
import 'package:distech_technology/Commons/app_icons.dart';
import 'package:distech_technology/Commons/app_sizes.dart';
import 'package:distech_technology/Controller/Ticket%20Controller/sold_ticket_controller.dart';
import 'package:distech_technology/Features/Vew%20Prizes/Controller/prize_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AllPrizeScreen extends StatelessWidget {
  AllPrizeScreen({super.key});

  ScrollController? controller = ScrollController();

  final soldTicketController = Get.put(SoldTicketController());

  final getMyDashboardController = Get.put(PrizesController());
  @override
  Widget build(BuildContext context) {
    getMyDashboardController.getMydashboard();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        controller: controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      'Total (${getMyDashboardController.getModeldashBoard.value.userTypeCount?.stockistCounts?.total.toString()})',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.w400, fontSize: 18),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      soldTicketController.selectDate(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(AppSizes.kDefaultPadding / 2),
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
                  const SizedBox(
                    width: 10,
                  ),
                  // Expanded(
                  //   flex: 1,
                  //   child: AppDropDown(
                  //       onChanged: (value) async {
                  //         // soldTicketController.limit.value = value;
                  //         // soldTicketController.dropDownValue.value = value;
                  //         // await soldTicketController.getAllTicket(
                  //         //     date: soldTicketController.formatedDate.value,
                  //         //     search: soldTicketController.searchText.value,
                  //         //     semNumber: soldTicketController.semNumber.value);
                  //       },
                  //       list: soldTicketController.selectedValueList),
                  // )
                ],
              ),
            ),
            priceCard(
                value: getMyDashboardController.getModeldashBoard.value
                    .userTicketCounts?.ticketsCount?.sold
                    .toString(),
                title: "Sold Tickets",
                color: const Color(0xFFFFBF1C),
                imagePath: AppIcons.prize),
            priceCard(
                value: getMyDashboardController.getModeldashBoard.value
                    .userTicketCounts?.ticketsCount?.unsold
                    .toString(),
                title: "Unsupplied Tickets",
                color: const Color(0xFF29C57F),
                imagePath: AppIcons.soldTicket),
            priceCard(
                value: getMyDashboardController.getModeldashBoard.value
                    .userTicketCounts?.ticketsCount?.returned
                    .toString(),
                title: "Unsold Tickets",
                color: const Color(0xFFFF2E17),
                imagePath: AppIcons.soldTicket),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(5),
              alignment: Alignment.center,
              decoration: BoxDecoration(border: Border.all()),
              child: const Text(
                "Result for Draw held on 18/1/2024 Price 10/-",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "1st Prize ₹50,000.00",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(vertical: 5),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: AppColors.lightGrey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5)),
                child: const Text("14888")),
            const Padding(
              padding: EdgeInsets.only(top: 5, bottom: 2),
              child: Text(
                "2nd Prize ₹9,500.00",
                style: TextStyle(
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
                  5,
                  (index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: AppColors.lightGrey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5)),
                      margin: const EdgeInsets.all(1),
                      child: const Center(
                        child: Text(
                          '14888',
                        ),
                      ),
                    );
                  },
                )),
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 2),
              child: Text(
                "3nd Prize ₹700.00",
                style: TextStyle(
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
                  10,
                  (index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: AppColors.lightGrey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5)),
                      margin: const EdgeInsets.all(1),
                      child: const Center(
                        child: Text(
                          '14888',
                        ),
                      ),
                    );
                  },
                )),
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 2),
              child: Text(
                "4th Prize ₹450.00",
                style: TextStyle(
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
                  10,
                  (index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: AppColors.lightGrey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5)),
                      margin: const EdgeInsets.all(1),
                      child: const Center(
                        child: Text(
                          '14888',
                        ),
                      ),
                    );
                  },
                )),
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 2),
              child: Text(
                "5th Prize ₹450.00",
                style: TextStyle(
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
                  100,
                  (index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: AppColors.lightGrey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5)),
                      margin: const EdgeInsets.all(1),
                      child: const Center(
                        child: Text(
                          '14888',
                        ),
                      ),
                    );
                  },
                )),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }

  Widget priceCard({
    String? value,
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
                "$title   (${date ?? ""})",
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
              const SizedBox(height: 5),
              Text(
                value ?? "",
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
