import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:distech_technology/Commons/app_sizes.dart';
import 'package:distech_technology/Features/Login/Presentation/login_screen.dart';
import 'package:distech_technology/Utils/app_helper.dart';
import 'package:distech_technology/Widgets/full_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Commons/app_colors.dart';
import '../../../Commons/app_images.dart';
import '../../../Widgets/custom_shape_clipper.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    getAlerttDialog();

    super.initState();
  }

  getAlerttDialog() async {
    await Future.delayed(const Duration(microseconds: 1000), () {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.info,
        animType: AnimType.bottomSlide,
        dismissOnTouchOutside: false,
        title: "Select Language",
        desc: 'This is a description.',
        body: Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
            child: Column(
              children: [
                const Text(
                  "Select Language",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ).tr(),
                const SizedBox(height: 10),
                Column(children: [
                  GestureDetector(
                    onTap: () async {
                      const newLocale = Locale('en', 'US');
                      await context.setLocale(
                          newLocale); // change `easy_localization` locale
                      Get.updateLocale(newLocale);
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primary),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text(
                        "English",
                        style:
                            TextStyle(color: AppColors.primary, fontSize: 17),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      const newLocale = Locale('hi', 'IN');
                      await context.setLocale(newLocale);
                      Get.updateLocale(newLocale);
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primary),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text(
                        "हिंदी",
                        style:
                            TextStyle(color: AppColors.primary, fontSize: 17),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      const newLocale = Locale('bn', 'BD');
                      await context.setLocale(newLocale);
                      Get.updateLocale(newLocale);
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primary),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text(
                        "বাংলা",
                        style:
                            TextStyle(color: AppColors.primary, fontSize: 17),
                      ),
                    ),
                  ),
                ]),
              ],
            )),
      ).show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipPath(
            clipper: CustomShape(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.8,
              padding:
                  EdgeInsets.symmetric(horizontal: AppSizes.kDefaultPadding),
              decoration:
                  const BoxDecoration(gradient: AppColors.radialGradient),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: AppSizes.kDefaultPadding,
                    ),
                    Image.asset(
                      AppImages.appLogo,
                      width: MediaQuery.of(context).size.width * 0.6,
                    ),
                    SizedBox(
                      height: AppSizes.kDefaultPadding * 3,
                    ),
                    Text(
                      'Welcome',
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                color: AppColors.white,
                              ),
                    ),
                    SizedBox(
                      height: AppSizes.kDefaultPadding,
                    ),
                    Text(
                      'Welcome to Singham Lotteries, where dreams have a chance to become reality.',
                      // textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.white, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: AppSizes.kDefaultPadding,
                    ),
                    Expanded(
                      child: Image.asset(
                        AppImages.welcomeImage,
                        width: MediaQuery.of(context).size.width * 0.8,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.kDefaultPadding),
            child: FullButton(
              label: 'Portal Login',
              arrowIconVisible: true,
              onPressed: () => context.pushReplacement(const LoginScreen()),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
