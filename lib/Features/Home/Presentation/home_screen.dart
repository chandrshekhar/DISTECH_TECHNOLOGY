import 'dart:async';

import 'package:distech_technology/Commons/app_colors.dart';
import 'package:distech_technology/Commons/app_icons.dart';
import 'package:distech_technology/Commons/app_sizes.dart';
import 'package:distech_technology/Controller/Timer%20Controller/app_strate_controller.dart';
import 'package:distech_technology/Controller/Timer%20Controller/timer_controller.dart';
import 'package:distech_technology/Features/Bills/Presentation/my_bills_screen.dart';
import 'package:distech_technology/Features/Claim/Presentation/my_claim-screen.dart';
import 'package:distech_technology/Features/Dashboard/Presentation/dashboard_main.dart';
import 'package:distech_technology/Features/Home/Widgets/drawer_item.dart';
import 'package:distech_technology/Features/Login/Presentation/login_screen.dart';
import 'package:distech_technology/Features/Profile/Presentation/profile_screen.dart';
import 'package:distech_technology/Features/PurchaseHistory/Presentation/purchase_history_screen.dart';
import 'package:distech_technology/Features/ReturnUnsoldTicket/Presentation/return_unsold_ticket_screen.dart';
import 'package:distech_technology/Features/ReturnedTickets/Presentation/returned_tickets_screen.dart';
import 'package:distech_technology/Features/ScanCode/scan_code_screen.dart';
import 'package:distech_technology/Features/SoldTicket/Presentation/sold_ticket_screen.dart';
import 'package:distech_technology/Features/Support/Presentation/support_screen.dart';
import 'package:distech_technology/Features/Vew%20Prizes/Presentation/pwt_sold_ticket.dart';
import 'package:distech_technology/Features/Vew%20Prizes/Presentation/pwt_unsold_screen.dart';
import 'package:distech_technology/Utils/app_helper.dart';
import 'package:distech_technology/Utils/date_time_format.dart';
import 'package:distech_technology/Utils/storage/local_storage.dart';
import 'package:distech_technology/Widgets/custom_app_bar.dart';
import 'package:distech_technology/Widgets/custom_expation_tile.dart';
import 'package:distech_technology/Widgets/custom_shape_clipper.dart';
import 'package:distech_technology/Widgets/full_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controller/Profile Controller/profile_controller.dart';
import '../../Claim/Presentation/new_claim_screen.dart';
import '../../Result/Presentation/result_screen.dart';
import '../../Vew Prizes/Controller/prize_controller.dart';
import '../Components/timer_card_widget.dart';

class HomeScreen extends StatefulWidget {
  String? comeFrom;
  HomeScreen({Key? key, this.comeFrom}) : super(key: key);

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
    const DashboardMainScreen(), //0
    const SoldTicketScreen(), //1
    const ReturnedTicketScreen(), //2
    const PurchaseHistoryScreen(), //3
    const ReturnUnsoldTicket(), //4
    PwtUnsoldScreen(), //5
    PwtSoldScreen(), //6
    const NewClaimScreen(), // 7
    const MyClaimScreen(), // 8
    const ScanBarCodeScreen(), //9
    ResultScreen(), //10
    const MyBillsScreen(), // 11
    const SupportScreen(), // 12
    // SaleTicketsScreen() // 13
  ];

  final userProfileController = Get.put(ProfileController());
  final timerController = Get.put(TimerController());
  late AppStateController appStateController;

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
    appStateController = Get.put(AppStateController());
    callProfile();
  }

  void callProfile() async {
    if (widget.comeFrom.toString().contains("home")) {
    } else {
      await Future.delayed(const Duration(microseconds: 1000), () {
        timerController.getSloat();
        ();
        userProfileController.getUserDetails();
      });
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
        case 11:
          setState(() {
            selectedIndex = 11;
          });
        case 12:
          setState(() {
            selectedIndex = 12;
          });
        case 13:
          setState(() {
            selectedIndex = 13;
          });
        case 14:
          setState(
            () {
              selectedIndex = 14;
            },
          );
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
            PopupMenuButton<String>(
                position: PopupMenuPosition.under,
                onSelected: (val) {
                  switch (val) {
                    case '0':
                      {
                        timerController.slotId.value =
                            timerController.drawModel.value.data?[0].sId ?? "";
                        timerController.getServerTime();
                        timerController.intialSlot.value =
                            timerController.drawModel.value.data?[0].name ?? "";
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => HomeScreen(
                                      comeFrom: "home",
                                    )));
                      }
                      break;
                    case '1':
                      {
                        timerController.slotId.value =
                            timerController.drawModel.value.data?[1].sId ?? "";
                        timerController.getServerTime();
                        timerController.intialSlot.value =
                            timerController.drawModel.value.data?[1].name ?? "";
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => HomeScreen(
                                      comeFrom: "home",
                                    )));
                      }

                      break;
                  }
                },
                icon: const Icon(Icons.expand_circle_down_outlined,
                    color: Colors.white, size: 36), // Icon for the button
                itemBuilder: (BuildContext context) {
                  return List.generate(
                      timerController.drawModel.value.data!.length,
                      (index) => PopupMenuItem<String>(
                          value: index.toString(),
                          child: Text(
                              "${timerController.drawModel.value.data?[index].name} (${formatTime(timerController.drawModel.value.data?[index].drawTime ?? "")})",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: AppColors.primary,
                                      fontSize: 15))));
                }),
            const SizedBox(width: 5),
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      key: Key(
                          userProfileController.isExpansionList[1].toString()),
                      children: [
                        CustomExpansionPanel(
                            isIconShowing: false,
                            title: "dashboard",
                            onExpansionChanged: (v) {
                              closeDrawer();
                              navigate(0);
                              // userProfileController.setExpansion(0);
                            },
                            initiallyExpanded:
                                userProfileController.isExpansionList[0],
                            children: const []),
                        Obx(() => CustomExpansionPanel(
                                title: "tickets",
                                onExpansionChanged: (v) {
                                  // userProfileController.setExpansion(1);
                                },
                                initiallyExpanded:
                                    userProfileController.isExpansionList[1],
                                children: [
                                  // DrawerItem(
                                  //     onTap: () {
                                  //       closeDrawer();
                                  //       navigate(1);
                                  //     },
                                  //     icon: AppIcons.ticketIcon,
                                  //     bgColor: AppColors.transparent,
                                  //     label: "My Tickets"),
                                  // const SizedBox(height: 10),
                                  DrawerItem(
                                      onTap: () {
                                        closeDrawer();
                                        navigate(1);
                                      },
                                      icon: AppIcons.soldTickets,
                                      bgColor: AppColors.transparent,
                                      label: "soldTickets"),
                                  const SizedBox(height: 10),
                                  // DrawerItem(
                                  //     onTap: () {
                                  //       closeDrawer();
                                  //       navigate(13);
                                  //     },
                                  //     icon: AppIcons.ticketIcon,
                                  //     bgColor: AppColors.transparent,
                                  //     label: "Prize Tickets"),
                                  // const SizedBox(height: 10),
                                  DrawerItem(
                                      onTap: () {
                                        closeDrawer();
                                        navigate(2);
                                      },
                                      icon: AppIcons.returnedTickets,
                                      bgColor: AppColors.transparent,
                                      label: "returnedTickets"),
                                  const SizedBox(height: 10),
                                  DrawerItem(
                                      onTap: () {
                                        closeDrawer();
                                        navigate(3);
                                      },
                                      icon: AppIcons.purchasedTickets,
                                      bgColor: AppColors.transparent,
                                      label: "purchasedTicket"),
                                ])),
                        // Obx(() => CustomExpansionPanel(
                        //         title: "Sale",
                        //         onExpansionChanged: (v) {
                        //           // userProfileController.setExpansion(2);
                        //         },
                        //         initiallyExpanded:
                        //             userProfileController.isExpansionList[2],
                        //         children: [
                        //           DrawerItem(
                        //               onTap: () {
                        //                 closeDrawer();
                        //                 navigate(13);
                        //               },
                        //               icon: AppIcons.filterIcon,
                        //               bgColor: AppColors.transparent,
                        //               label: "Sale Tickets"),
                        //         ])),
                        Obx(() => CustomExpansionPanel(
                                title: "unsold",
                                onExpansionChanged: (v) {
                                  // userProfileController.setExpansion(2);
                                },
                                initiallyExpanded:
                                    userProfileController.isExpansionList[2],
                                children: [
                                  DrawerItem(
                                      onTap: () {
                                        closeDrawer();
                                        navigate(4);
                                      },
                                      icon: AppIcons.returnedTickets,
                                      bgColor: AppColors.transparent,
                                      label: "returnTickets"),
                                  DrawerItem(
                                      onTap: () {
                                        closeDrawer();
                                        navigate(5);
                                      },
                                      icon: AppIcons.unsold,
                                      bgColor: AppColors.transparent,
                                      label: "unsoldPWT"),
                                ])),
                        Obx(() => CustomExpansionPanel(
                                title: "pwt",
                                onExpansionChanged: (v) {
                                  // userProfileController.setExpansion(4);
                                },
                                initiallyExpanded:
                                    userProfileController.isExpansionList[4],
                                children: [
                                  DrawerItem(
                                      onTap: () {
                                        closeDrawer();
                                        navigate(6);
                                      },
                                      icon: AppIcons.soldPwt,
                                      bgColor: AppColors.transparent,
                                      label: "soldPWT"),
                                  const SizedBox(height: 10),
                                  DrawerItem(
                                      onTap: () {
                                        closeDrawer();
                                        navigate(7);
                                      },
                                      icon: AppIcons.newClaim,
                                      bgColor: AppColors.transparent,
                                      label: "newClaim"),
                                  const SizedBox(height: 10),
                                  DrawerItem(
                                      onTap: () {
                                        closeDrawer();
                                        navigate(8);
                                      },
                                      icon: AppIcons.claimRequest,
                                      bgColor: AppColors.transparent,
                                      label: "myClaimRequest"),
                                ])),
                        CustomExpansionPanel(
                            isIconShowing: false,
                            title: "verifyTickets",
                            onExpansionChanged: (v) {
                              closeDrawer();
                              navigate(9);
                            },
                            initiallyExpanded:
                                userProfileController.isExpansionList[0],
                            children: const []),
                        CustomExpansionPanel(
                            isIconShowing: false,
                            title: "result",
                            onExpansionChanged: (v) {
                              closeDrawer();
                              navigate(10);
                              // userProfileController.setExpansion(6);
                            },
                            initiallyExpanded:
                                userProfileController.isExpansionList[6],
                            children: const []),
                        CustomExpansionPanel(
                            isIconShowing: false,
                            title: "myBill",
                            onExpansionChanged: (v) {
                              closeDrawer();
                              navigate(11);
                              // userProfileController.setExpansion(6);
                            },
                            initiallyExpanded:
                                userProfileController.isExpansionList[6],
                            children: const []),
                        CustomExpansionPanel(
                            isIconShowing: false,
                            title: "support",
                            onExpansionChanged: (v) {
                              closeDrawer();
                              navigate(12);
                              // userProfileController.setExpansion(5);
                            },
                            initiallyExpanded:
                                userProfileController.isExpansionList[5],
                            children: const []),
                        Obx(() => CustomExpansionPanel(
                                title: "language",
                                onExpansionChanged: (v) {
                                  // userProfileController.setExpansion(1);
                                },
                                initiallyExpanded:
                                    userProfileController.isExpansionList[1],
                                children: [
                                  // DrawerItem(
                                  //     onTap: () {
                                  //       closeDrawer();
                                  //       navigate(1);
                                  //     },
                                  //     icon: AppIcons.ticketIcon,
                                  //     bgColor: AppColors.transparent,
                                  //     label: "My Tickets"),
                                  // const SizedBox(height: 10),
                                  DrawerItem(
                                      onTap: () {
                                        // closeDrawer();
                                        const newLocale = Locale('hi', 'IN');
                                        context.setLocale(newLocale);
                                        Get.updateLocale(newLocale);
                                      },
                                      icon: AppIcons.hindiICon,
                                      bgColor: AppColors.transparent,
                                      label: "hindi"),
                                  const SizedBox(height: 10),
                                  // DrawerItem(
                                  //     onTap: () {
                                  //       closeDrawer();
                                  //       navigate(13);
                                  //     },
                                  //     icon: AppIcons.ticketIcon,
                                  //     bgColor: AppColors.transparent,
                                  //     label: "Prize Tickets"),
                                  // const SizedBox(height: 10),
                                  DrawerItem(
                                      onTap: () async {
                                        // closeDrawer();
                                        const newLocale = Locale('en', 'US');
                                        await context.setLocale(
                                            newLocale); // change `easy_localization` locale
                                        Get.updateLocale(newLocale);
                                      },
                                      icon: AppIcons.englishIcon,
                                      bgColor: AppColors.transparent,
                                      label: "english"),
                                  const SizedBox(height: 10),
                                  DrawerItem(
                                      onTap: () {
                                        // closeDrawer();
                                        const newLocale = Locale('bn', 'BD');
                                        context.setLocale(newLocale);
                                        Get.updateLocale(newLocale);
                                      },
                                      icon: AppIcons.bangalIcon,
                                      bgColor: AppColors.transparent,
                                      label: "bengali"),
                                ])),
                      ],
                    ),
                  ),
                ),
                // SizedBox(
                //   height: AppSizes.kDefaultPadding,
                // ),

                // Expanded(
                //   child: ListView.builder(
                //       itemCount: drawerItemsList.length,
                //       shrinkWrap: false,
                //       itemBuilder: (context, index) {
                //         return InkWell(
                //           onTap: () {
                //             // for (var i = 0; i < isHighlighted.length; i++) {
                //             //   if (index == i) {
                //             //     isHighlighted[index] = true;
                //             //   } else {
                //             //     isHighlighted[i] = false;
                //             //   }
                //             // }
                //             // Close the Drawer first

                //             // Then Navigate to the Screens or Containers
                //             closeDrawer();
                //             navigate(index);
                //             // if (index == 5) {
                //             //   scanBarcode();

                //             //   closeDrawer();

                //             //   print("bar code scanner");
                //             // } else {
                //             //   closeDrawer();
                //             //   navigate(index);
                //             // }
                //           },
                //           child: DrawerItem(
                //             drawerItemModel: drawerItemsList[index],
                //             bgColor:
                //                  AppColors.transparent,
                //           ),
                //         );
                //       }),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: FullButton(
                    label: 'logout',
                    onPressed: () async {
                      final getMyDashboardController =
                          Get.put(PrizesController());
                      await LocalStorageService()
                          .removeToDisk(LocalStorageService.ACCESS_TOKEN_KEY);
                      await LocalStorageService()
                          .removeToDisk(LocalStorageService.USER_NAME);

                      getMyDashboardController.isPopupShowing.value = false;
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
                          child: Text('developedBy',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: AppColors.darkGrey.withOpacity(0.7),
                                  )).tr()),
                      Text(
                        'App V0.3.15',
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
                          '${context.tr("hii")}, ${userProfileController.userProfileModel.value.user?.fullName ?? ""}\n',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w500),
                      children: <TextSpan>[
                        TextSpan(
                          text: timerController.intialSlot.isNotEmpty
                              ? '< ${timerController.intialSlot} >'
                              : '',
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
                //     Obx(() => Text(
                //           'Hi, ${userProfileController.userProfileModel.value.user?.fullName ?? ""}',
                //           textAlign: TextAlign.center,
                //           style: Theme.of(context)
                //               .textTheme
                //               .headlineSmall!
                //               .copyWith(
                //                   color: AppColors.white,
                //                   fontWeight: FontWeight.w500),
                //         ))
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
