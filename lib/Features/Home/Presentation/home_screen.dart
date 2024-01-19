import 'dart:async';

import 'package:distech_technology/Commons/app_colors.dart';
import 'package:distech_technology/Commons/app_sizes.dart';
import 'package:distech_technology/Controller/Timer%20Controller/timer_controller.dart';
import 'package:distech_technology/Features/Claim/Presentation/my_claim-screen.dart';
import 'package:distech_technology/Features/Dashboard/Presentation/dashboard_screen.dart';
import 'package:distech_technology/Features/Home/Models/drawer_item_model.dart';
import 'package:distech_technology/Features/Home/Widgets/drawer_item.dart';
import 'package:distech_technology/Features/Inventory/Presentation/inventory_screen.dart';
import 'package:distech_technology/Features/Login/Presentation/login_screen.dart';
import 'package:distech_technology/Features/Profile/Presentation/profile_screen.dart';
import 'package:distech_technology/Features/PurchaseHistory/Presentation/purchase_history_screen.dart';
import 'package:distech_technology/Features/ReturnUnsoldTicket/Presentation/return_unsold_ticket_screen.dart';
import 'package:distech_technology/Features/ReturnedTickets/Presentation/returned_tickets_screen.dart';
import 'package:distech_technology/Features/ScanCode/scan_code_screen.dart';
import 'package:distech_technology/Features/SoldTicket/Presentation/sold_ticket_screen.dart';
import 'package:distech_technology/Features/Support/Presentation/support_screen.dart';
import 'package:distech_technology/Features/Vew%20Prizes/Presentation/all_prize_screen.dart';
import 'package:distech_technology/Utils/app_helper.dart';
import 'package:distech_technology/Utils/storage/local_storage.dart';
import 'package:distech_technology/Widgets/custom_app_bar.dart';
import 'package:distech_technology/Widgets/custom_shape_clipper.dart';
import 'package:distech_technology/Widgets/full_button.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controller/Profile Controller/profile_controller.dart';
import '../../Claim/Presentation/new_claim_screen.dart';
import '../Components/timer_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Variable Declarations
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  //drawer item selected index
  int selectedIndex = 0;

  //all screens which will be visible on home screens
  final List<Widget> screens = [
    const DashboardScreen(),
    const ReturnUnsoldTicket(),
    const SoldTicketScreen(),
    const ReturnedTicketScreen(),
    const PurchaseHistoryScreen(),
    ScanBarCodeScreen(),
    const NewClaimScreen(),
    const MyClaimScreen(),
    const SupportScreen(),
    AllPrizeScreen(),
    const InVentoryScreen()
  ];

  //drawer item selected background color.
  //by default: dashboard will be selected.
  List<bool> isHighlighted = [
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  final userProfileController = Get.put(ProfileController());
  final timerController = Get.put(TimerController());

  //Close Drawer if open
  void closeDrawer() {
    if (_key.currentState!.isDrawerOpen) {
      _key.currentState!.closeDrawer();
    } else {
      _key.currentState!.openDrawer();
    }
  }

  @override
  void initState() {
    super.initState();
    callProfile();
  }

  void callProfile() async {
    await Future.delayed(const Duration(microseconds: 2000), () {
      userProfileController.getUserDetails();
    });
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
          break;
        case 7:
          setState(() {
            selectedIndex = 7;
          });
        case 8:
          setState(() {
            selectedIndex = 8;
          });
        case 9:
          setState(() {
            selectedIndex = 9;
          });
        case 10:
          setState(() {
            selectedIndex = 10;
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
                    backgroundImage:
                        AssetImage("assets/images/blank-profile-picture.webp"),
                    maxRadius: 16,
                    minRadius: 16,
                  ),
                ),
              ),
            )
          ],
        ),
        // drawer: const CustomDrawarWidget(),

        drawer: Drawer(
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
              alignment: Alignment.topCenter,
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
                Obx(() => RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text:
                          'Hi, ${userProfileController.userProfileModel.value.user?.fullName ?? ""}\n',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w500),
                      children: <TextSpan>[
                        TextSpan(
                          text: timerController.intialSlot.isEmpty
                              ? '< ${timerController.intialSlot} >'
                              : '< Evening slot >',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500),
                        ),
                      ],
                    ))),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       'Hi, ${userProfileController.userProfileModel.value.user?.fullName ?? ""}\n "djghadsfjkhasjkdf',
                //       textAlign: TextAlign.center,
                //       style: Theme.of(context)
                //           .textTheme
                //           .headlineSmall!
                //           .copyWith(
                //               color: AppColors.white,
                //               fontWeight: FontWeight.w500),
                //     )
                //   ],
                // ),
                Positioned(
                  bottom: 10,
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
