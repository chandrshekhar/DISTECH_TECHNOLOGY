import 'app_colors.dart';
import 'package:flutter/material.dart';

import 'app_sizes.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: false,
      primarySwatch: AppColors.generateMaterialColor(AppColors.primary),
      dividerColor: AppColors.grey,
      brightness: Brightness.light,
      backgroundColor: AppColors.white,
      cardColor: AppColors.white,
      primaryColor: AppColors.primary,
      hintColor: AppColors.darkGrey,
      unselectedWidgetColor: AppColors.grey,
      inputDecorationTheme: InputDecorationTheme(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.bg, width: 1.0)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: AppColors.secondary.withOpacity(0.6), width: 1.0)),
          border: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: AppColors.bg, width: 1.0)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: AppColors.secondary.withOpacity(0.6), width: 1.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: AppColors.primary.withOpacity(0.4), width: 1.0))),
      // Scrollbar Theme
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: MaterialStateProperty.all<Color>(AppColors.primary),
        thickness: MaterialStateProperty.all<double>(3),
        radius: const Radius.circular(AppSizes.cardCornerRadius),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          elevation: 5, backgroundColor: AppColors.primary),
      // AppBar Theme
      appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            size: 24,
            color: AppColors.white,
          ),
          backgroundColor: AppColors.primaryDark,
          elevation: AppSizes.elevation0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: AppColors.white,
            fontSize: AppSizes.headline5,
            fontWeight: FontWeight.w500,
            //    fontFamily: FontFamily.poppinsRegular
          ),
          foregroundColor: AppColors.black),
      // Progress Bar Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColors.lightGrey, circularTrackColor: AppColors.bg),
      // CheckBox Theme
      checkboxTheme: CheckboxThemeData(
          side: const BorderSide(width: 1, color: AppColors.grey),
          // To Make checkbox rounded or circle
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(AppSizes.cardCornerRadius / 2))),
      scaffoldBackgroundColor: AppColors.scaffold,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      // Tab Bar Theme
      tabBarTheme: const TabBarTheme(
        labelStyle: TextStyle(fontWeight: FontWeight.w600),
        labelColor: AppColors.white,
        indicatorSize: TabBarIndicatorSize.tab,
        unselectedLabelColor: AppColors.lightGrey,
        indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: AppColors.primary)),
      ),
      // Text Theme
      textTheme: const TextTheme(
        headline1: TextStyle(
            color: AppColors.black,
            fontSize: AppSizes.headline1,
            fontWeight: FontWeight.w900),
        headline2: TextStyle(
            color: AppColors.black,
            fontSize: AppSizes.headline2,
            fontWeight: FontWeight.w700),
        headline3: TextStyle(
            color: AppColors.black,
            fontSize: AppSizes.headline3,
            fontWeight: FontWeight.w700),
        headline4: TextStyle(
            color: AppColors.black,
            fontSize: AppSizes.headline4,
            fontWeight: FontWeight.w700),
        headline5: TextStyle(
            color: AppColors.black,
            fontSize: AppSizes.headline5,
            fontWeight: FontWeight.w600),
        headline6: TextStyle(
            color: AppColors.black,
            fontSize: AppSizes.headline6,
            fontWeight: FontWeight.w500),
        bodyText1: TextStyle(
            color: AppColors.black,
            fontSize: AppSizes.bodyText1,
            fontWeight: FontWeight.w500),
        bodyText2: TextStyle(
            color: AppColors.darkGrey,
            fontSize: AppSizes.bodyText2,
            fontWeight: FontWeight.w400),
        caption: TextStyle(
            color: AppColors.darkGrey,
            fontSize: AppSizes.caption,
            fontWeight: FontWeight.w400),
        button: TextStyle(
            color: AppColors.white,
            fontSize: AppSizes.button,
            fontWeight: FontWeight.w600),
      ),
      //fontFamily: FontFamily.poppinsRegular,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData();
  }
}
