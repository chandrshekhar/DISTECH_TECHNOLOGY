import 'package:distech_technology/Commons/app_colors.dart';
import 'package:distech_technology/Commons/app_icons.dart';
import 'package:distech_technology/Commons/app_sizes.dart';
import 'package:distech_technology/Features/Login/Presentation/login_screen.dart';
import 'package:distech_technology/Utils/storage/local_storage.dart';
import 'package:distech_technology/Widgets/custom_expation_tile.dart';
import 'package:distech_technology/Widgets/full_button.dart';
import 'package:flutter/material.dart';

import '../Features/Inventory/Presentation/inventory_screen.dart';

class CustomDrawarWidget extends StatefulWidget {
  const CustomDrawarWidget({super.key});

  @override
  State<CustomDrawarWidget> createState() => _CustomDrawarWidgetState();
}

class _CustomDrawarWidgetState extends State<CustomDrawarWidget> {
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> expansionList = [
      {
        "title": "Dashboard",
        "icon": AppIcons.dashboardIcon,
        "children": <Widget>[]
      },
      {
        "title": "Inventory",
        "icon": AppIcons.ticketIcon,
        "children": <Widget>[
          subTile(
              title: "Inventory",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const InVentoryScreen()));
              }),
          const SizedBox(height: 20),
          subTile(title: "View Inventory", onTap: () {})
        ]
      },
      {
        "title": "Sales",
        "icon": AppIcons.ticketIcon,
        "children": <Widget>[
          subTile(title: "Inventory", onTap: () {}),
          const SizedBox(height: 20),
          subTile(title: "View Inventory", onTap: () {})
        ]
      },
      {
        "title": "Unsold",
        "icon": AppIcons.ticketIcon,
        "children": <Widget>[
          subTile(title: "Inventory", onTap: () {}),
          const SizedBox(height: 20),
          subTile(title: "View Inventory", onTap: () {})
        ]
      },
      {
        "title": "Verify",
        "icon": AppIcons.purchaseHistoryIcon,
        "children": <Widget>[
          subTile(title: "Inventory", onTap: () {}),
          const SizedBox(height: 20),
          subTile(title: "View Inventory", onTap: () {})
        ]
      },
      {
        "title": "Claim",
        "icon": AppIcons.myClaimIcon,
        "children": [
          subTile(title: "Inventory", onTap: () {}),
          const SizedBox(height: 20),
          subTile(title: "View Inventory", onTap: () {})
        ]
      },
      {
        "title": "Billing",
        "icon": AppIcons.purchaseHistoryIcon,
        "children": [
          subTile(title: "Inventory", onTap: () {}),
          const SizedBox(height: 20),
          subTile(title: "View Inventory", onTap: () {})
        ]
      },
      {
        "title": "Support",
        "icon": AppIcons.purchaseHistoryIcon,
        "children": <Widget>[
          subTile(title: "Inventory", onTap: () {}),
          const SizedBox(height: 20),
          subTile(title: "View Inventory", onTap: () {})
        ]
      }
    ];
    return SafeArea(
      child: Drawer(
        backgroundColor: AppColors.white,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  padding: EdgeInsets.only(
                      top: AppSizes.kDefaultPadding / 3,
                      left: AppSizes.kDefaultPadding / 3,
                      bottom: AppSizes.kDefaultPadding * 2,
                      right: AppSizes.kDefaultPadding * 2),
                  margin: EdgeInsets.only(
                      top: AppSizes.kDefaultPadding,
                      left: AppSizes.kDefaultPadding),
                  // decoration: const BoxDecoration(
                  //     image: DecorationImage(
                  //         fit: BoxFit.cover,
                  //         image: AssetImage(
                  //           AppImages.drawerLogoBg,
                  //         ))),
                  child: Image.asset(
                    "assets/images/logo2.png",
                    // width: 30,
                    fit: BoxFit.contain,
                    // height: 30,
                  )),
              // SizedBox(
              //   height: AppSizes.kDefaultPadding,
              // ),
              Expanded(
                child: ListView.builder(
                  key: Key(selectedIndex.toString()),
                  itemCount: expansionList.length,
                  itemBuilder: (context, index) {
                    return CustomExpansionPanel(
                      leading: Image.asset(
                        expansionList[index]['icon'],
                        height: 20,
                        width: 20,
                        color: selectedIndex == index
                            ? AppColors.primaryDark
                            : AppColors.primaryIconColor,
                      ),
                      title: expansionList[index]['title'],
                      onExpansionChanged: (v) {
                        if (v) {
                          setState(() {
                            selectedIndex = index;
                          });
                        } else {
                          setState(() {
                            selectedIndex = -1;
                          });
                        }
                      },
                      initiallyExpanded: index == selectedIndex,
                      children: expansionList[index]['children'],
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: FullButton(
                  label: 'Logout',
                  onPressed: () async {
                    await LocalStorageService()
                        .removeToDisk(LocalStorageService.ACCESS_TOKEN_KEY);
                    await LocalStorageService()
                        .removeToDisk(LocalStorageService.USER_NAME);
                    // ignore: use_build_context_synchronously
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                        (route) => false);
                  },
                  bgColor: AppColors.secondary,
                ),
              ),

              Padding(
                padding: EdgeInsets.all(AppSizes.kDefaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text('Developed By Excellis',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: AppColors.darkGrey.withOpacity(0.7),
                                ))),
                    Text(
                      'App V0.1.1',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: AppColors.darkGrey.withOpacity(0.7)),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget subTile({String? title, void Function()? onTap}) {
    return Padding(
      padding: const EdgeInsets.only(left: 55),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            const Icon(
              Icons.inventory,
              size: 15,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(title ?? "")
          ],
        ),
      ),
    );
  }
}
