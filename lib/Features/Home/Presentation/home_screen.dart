import 'dart:async';

import 'package:distech_technology/Commons/app_colors.dart';
import 'package:distech_technology/Commons/app_sizes.dart';
import 'package:distech_technology/Features/Dashboard/Presentation/dashboard_screen.dart';
import 'package:distech_technology/Features/Login/Presentation/login_screen.dart';
import 'package:distech_technology/Features/Profile/Presentation/profile_screen.dart';
import 'package:distech_technology/Features/PurchaseHistory/Presentation/purchase_history_screen.dart';
import 'package:distech_technology/Features/ReturnUnsoldTicket/Presentation/return_unsold_ticket_screen.dart';
import 'package:distech_technology/Features/ReturnedTickets/Presentation/returned_tickets_screen.dart';
import 'package:distech_technology/Features/ScanCode/scan_code_screen.dart';
import 'package:distech_technology/Features/SoldTicket/Presentation/sold_ticket_screen.dart';
import 'package:distech_technology/Features/Support/Presentation/support_screen.dart';
import 'package:distech_technology/Utils/app_helper.dart';
import 'package:distech_technology/Utils/storage/local_storage.dart';
import 'package:distech_technology/Widgets/custom_app_bar.dart';
import 'package:distech_technology/Widgets/custom_shape_clipper.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Commons/app_images.dart';
import '../../../Controller/Profile Controller/profile_controller.dart';
import '../../../Widgets/full_button.dart';
import '../Components/timer_card_widget.dart';
import '../Models/drawer_item_model.dart';
import '../Widgets/drawer_item.dart';

class HomeScreen extends StatefulWidget {
  final String username;

  const HomeScreen({Key? key, required this.username}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Variable Declarations
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  //drawer item selected index
  int selectedIndex = 0;

  //all screens which will be visible on home screens
  final List<Widget> screens = const [
    DashboardScreen(),
    ReturnUnsoldTicket(),
    SoldTicketScreen(),
    ReturnedTicketScreen(),
    PurchaseHistoryScreen(),
    SupportScreen(),
    ScanBarCodeScreen()
  ];

  //drawer item selected background color.
  //by default: dashboard will be selected.
  List<bool> isHighlighted = [true, false, false, false, false, false, false];

  final userProfileController = Get.put(ProfileController());

  //Close Drawer if open
  void closeDrawer() {
    if (_key.currentState!.isDrawerOpen) {
      _key.currentState!.closeDrawer();
    } else {
      _key.currentState!.openDrawer();
    }
  }

  // Navigate to content from Drawer
  void navigate(int index) {
    Future.delayed(const Duration(milliseconds: 500), () {
      switch (index) {
        case 0:
          setState(() {
            selectedIndex = 0;
          });
          break;
        case 1:
          setState(() {
            selectedIndex = 1;
          });
          break;
        case 2:
          setState(() {
            selectedIndex = 2;
          });
          break;
        case 3:
          setState(() {
            selectedIndex = 3;
          });
          break;
        case 4:
          setState(() {
            selectedIndex = 4;
          });
          break;
        case 5:
          setState(() {
            selectedIndex = 5;
          });
          break;
        case 6:
          setState(() {
            selectedIndex = 6;
          });
      }
    });
  }

  // Hardware Back Button Pressed on Android Devices to Close the Application.
  Future<bool> _onBackPressed() async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Exit Application ?',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            content: Text(
              'Are you sure you want to exit from the application ?',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.w400),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    'Cancel',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: AppColors.darkGrey.withOpacity(0.8)),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text('Confirm',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: AppColors.primary))),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        key: _key,
        appBar: CustomAppBar(
          autoImplyLeading: false,
          leadingIcon: EvaIcons.menu2Outline,
          leadingIconPressed: () => _key.currentState!.openDrawer(),
          actions: [
            GestureDetector(
              onTap: () => context.push(const ProfileScreen()),
              child: Padding(
                padding: EdgeInsets.only(right: AppSizes.kDefaultPadding),
                child: const CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.white,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"),
                    maxRadius: 16,
                    minRadius: 16,
                  ),
                ),
              ),
            )
          ],
        ),
        drawer: Drawer(
          backgroundColor: AppColors.white,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    padding: EdgeInsets.only(
                        top: AppSizes.kDefaultPadding / 3,
                        left: AppSizes.kDefaultPadding / 3,
                        bottom: AppSizes.kDefaultPadding * 2,
                        right: AppSizes.kDefaultPadding * 2),
                    margin: EdgeInsets.only(
                        top: AppSizes.kDefaultPadding,
                        left: AppSizes.kDefaultPadding),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              AppImages.drawerLogoBg,
                            ))),
                    child: Image.asset(
                      AppImages.drawerLogo,
                      width: 30,
                      fit: BoxFit.contain,
                      height: 30,
                    )),
                SizedBox(
                  height: AppSizes.kDefaultPadding,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: drawerItemsList.length,
                      shrinkWrap: false,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            for (var i = 0; i < isHighlighted.length; i++) {
                              if (index == i) {
                                isHighlighted[index] = true;
                              } else {
                                isHighlighted[i] = false;
                              }
                            }
                            // Close the Drawer first

                            // Then Navigate to the Screens or Containers
                            closeDrawer();
                            navigate(index);
                            // if (index == 5) {
                            //   scanBarcode();

                            //   closeDrawer();

                            //   print("bar code scanner");
                            // } else {
                            //   closeDrawer();
                            //   navigate(index);
                            // }
                          },
                          child: DrawerItem(
                            drawerItemModel: drawerItemsList[index],
                            bgColor: isHighlighted[index]
                                ? AppColors.primary.withOpacity(0.2)
                                : AppColors.transparent,
                          ),
                        );
                      }),
                ),
                Padding(
                  padding: EdgeInsets.all(AppSizes.kDefaultPadding),
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
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.darkGrey.withOpacity(0.7)),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: CustomShape(),
                  child: Container(
                    height: 150,
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    color: AppColors.primaryDark,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GetX<ProfileController>(
                      builder: (controller) {
                        return Text(
                          'Hi, ${controller.userProfileModel.value.user?.fullName.toString()}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w500),
                        );
                      },
                    )
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: AppSizes.kDefaultPadding,
                  right: AppSizes.kDefaultPadding,
                  child: const TimerCardWidget(),
                )
              ],
            ),
            Expanded(child: screens[selectedIndex])
          ],
        ),
      ),
    );
  }
}
