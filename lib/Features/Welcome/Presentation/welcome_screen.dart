import 'package:distech_technology/Commons/app_sizes.dart';
import 'package:distech_technology/Features/Home/Presentation/home_screen.dart';
import 'package:distech_technology/Features/Login/Presentation/login_screen.dart';
import 'package:distech_technology/Utils/app_helper.dart';
import 'package:distech_technology/Widgets/custom_shape_clipper.dart';
import 'package:distech_technology/Widgets/full_button.dart';
import 'package:flutter/material.dart';

import '../../../Commons/app_colors.dart';
import '../../../Commons/app_images.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

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
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.kDefaultPadding),
              decoration:
                  const BoxDecoration(gradient: AppColors.radialGradient),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: AppSizes.kDefaultPadding,
                    ),
                    Image.asset(
                      AppImages.appLogo,
                      width: MediaQuery.of(context).size.width * 0.6,
                    ),
                    const SizedBox(
                      height: AppSizes.kDefaultPadding * 3,
                    ),
                    Text(
                      'Welcome',
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                color: AppColors.white,
                              ),
                    ),
                    const SizedBox(
                      height: AppSizes.kDefaultPadding,
                    ),
                    Text(
                      'Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs',
                     // textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.white, fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(
                      height: AppSizes.kDefaultPadding,
                    ),
                    Expanded(
                      child: Image.asset(
                        AppImages.welcomeImage,
                        width: MediaQuery.of(context).size.width * 0.7,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.kDefaultPadding),
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
