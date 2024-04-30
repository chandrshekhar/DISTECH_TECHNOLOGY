import 'package:distech_technology/Commons/app_colors.dart';
import 'package:distech_technology/Commons/app_images.dart';
import 'package:distech_technology/Features/Welcome/Presentation/welcome_screen.dart';
import 'package:distech_technology/Utils/app_helper.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // Go To Welcome Screen After 1.5 Seconds
    Future.delayed(const Duration(milliseconds: 1500),
        () => context.pushReplacement(const WelcomeScreen()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(gradient: AppColors.radialGradient),
        child: Image.asset(
          AppImages.appLogo,
          width: MediaQuery.of(context).size.width * 0.6,
        ),
      ),
    );
  }
}
