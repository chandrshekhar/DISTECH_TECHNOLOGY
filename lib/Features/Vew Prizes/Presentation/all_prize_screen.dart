import 'package:distech_technology/Commons/app_colors.dart';
import 'package:distech_technology/Commons/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AllPrizeScreen extends StatelessWidget {
  AllPrizeScreen({super.key});

  ScrollController? controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        controller: controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            priceCard(
                title: "Sold Tickets",
                color: const Color(0xFFFFBF1C),
                imagePath: AppIcons.prize),
            priceCard(
                title: "Unsupplied Tickets",
                color: const Color(0xFF29C57F),
                imagePath: AppIcons.soldTicket),
            priceCard(
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

  Widget priceCard(
      {String? title,
      String? price,
      required Color color,
      required String imagePath}) {
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
                "$title   (18/01/2024)" ?? "",
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
              const SizedBox(height: 5),
              const Text(
                "₹1000000",
                style: TextStyle(
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
