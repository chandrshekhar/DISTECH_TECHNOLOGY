import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_sizes.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: false,
      dividerColor: AppColors.grey,
      brightness: Brightness.light,
      cardColor: AppColors.white,
      primaryColor: AppColors.sunRisesColor,
      hintColor: AppColors.darkGrey,
      unselectedWidgetColor: AppColors.grey,
      inputDecorationTheme: InputDecorationTheme(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.bg, width: 1.0)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: AppColors.secondary.withOpacity(0.6), width: 1.0)),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.bg, width: 1.0)),
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
        radius: Radius.circular(AppSizes.cardCornerRadius),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          elevation: 5, backgroundColor: AppColors.primary),
      // AppBar Theme
      appBarTheme: AppBarTheme(
          iconTheme: const IconThemeData(
            size: 24,
            color: AppColors.white,
          ),
          backgroundColor: AppColors.sunRisesColor,
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
          color: AppColors.primaryDark, circularTrackColor: AppColors.bg),
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
      textTheme: TextTheme(
        displayLarge: TextStyle(
            color: AppColors.black,
            fontSize: AppSizes.headline1,
            fontWeight: FontWeight.w900),
        displayMedium: TextStyle(
            color: AppColors.black,
            fontSize: AppSizes.headline2,
            fontWeight: FontWeight.w700),
        displaySmall: TextStyle(
            color: AppColors.black,
            fontSize: AppSizes.headline3,
            fontWeight: FontWeight.w700),
        headlineMedium: TextStyle(
            color: AppColors.black,
            fontSize: AppSizes.headline4,
            fontWeight: FontWeight.w700),
        headlineSmall: TextStyle(
            color: AppColors.black,
            fontSize: AppSizes.headline5,
            fontWeight: FontWeight.w600),
        titleLarge: TextStyle(
            color: AppColors.black,
            fontSize: AppSizes.headline6,
            fontWeight: FontWeight.w500),
        bodyLarge: TextStyle(
            color: AppColors.black,
            fontSize: AppSizes.bodyText1,
            fontWeight: FontWeight.w500),
        bodyMedium: TextStyle(
            color: AppColors.darkGrey,
            fontSize: AppSizes.bodyText2,
            fontWeight: FontWeight.w400),
        bodySmall: TextStyle(
            color: AppColors.darkGrey,
            fontSize: AppSizes.caption,
            fontWeight: FontWeight.w400),
        labelLarge: TextStyle(
            color: AppColors.white,
            fontSize: AppSizes.button,
            fontWeight: FontWeight.w600),
      ),
      colorScheme: ColorScheme.fromSwatch(
              primarySwatch: AppColors.generateMaterialColor(AppColors.primary))
          .copyWith(background: AppColors.white),
      //fontFamily: FontFamily.poppinsRegular,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: false,
      dividerColor: AppColors.grey,
      brightness: Brightness.light,
      cardColor: AppColors.white,
      primaryColor: AppColors.sunsetColor,
      hintColor: AppColors.white,
      unselectedWidgetColor: AppColors.grey,
      inputDecorationTheme: InputDecorationTheme(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.bg, width: 1.0)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: AppColors.primary.withOpacity(0.6), width: 1.0)),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.bg, width: 1.0)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: AppColors.primary.withOpacity(0.6), width: 1.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: AppColors.secondary.withOpacity(0.4), width: 1.0))),
      // Scrollbar Theme
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: MaterialStateProperty.all<Color>(AppColors.secondary),
        thickness: MaterialStateProperty.all<double>(3),
        radius: Radius.circular(AppSizes.cardCornerRadius),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          elevation: 5, backgroundColor: AppColors.secondary),
      // AppBar Theme
      appBarTheme: AppBarTheme(
          iconTheme: const IconThemeData(
            size: 24,
            color: AppColors.white,
          ),
          backgroundColor: AppColors.sunsetColor,
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
          color: AppColors.secondary, circularTrackColor: AppColors.bg),
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
            borderSide: BorderSide(color: AppColors.secondary)),
      ),
      // Text Theme
      textTheme: TextTheme(
        displayLarge: TextStyle(
            color: AppColors.white,
            fontSize: AppSizes.headline1,
            fontWeight: FontWeight.w900),
        displayMedium: TextStyle(
            color: AppColors.primaryDark,
            fontSize: AppSizes.headline2,
            fontWeight: FontWeight.w700),
        displaySmall: TextStyle(
            color: AppColors.primaryDark,
            fontSize: AppSizes.headline3,
            fontWeight: FontWeight.w700),
        headlineMedium: TextStyle(
            color: AppColors.primaryDark,
            fontSize: AppSizes.headline4,
            fontWeight: FontWeight.w700),
        headlineSmall: TextStyle(
            color: AppColors.primaryDark,
            fontSize: AppSizes.headline5,
            fontWeight: FontWeight.w600),
        titleLarge: TextStyle(
            color: AppColors.primaryDark,
            fontSize: AppSizes.headline6,
            fontWeight: FontWeight.w500),
        bodyLarge: TextStyle(
            color: AppColors.primaryDark,
            fontSize: AppSizes.bodyText1,
            fontWeight: FontWeight.w500),
        bodyMedium: TextStyle(
            color: AppColors.primaryDark,
            fontSize: AppSizes.bodyText2,
            fontWeight: FontWeight.w400),
        bodySmall: TextStyle(
            color: AppColors.lightGrey,
            fontSize: AppSizes.caption,
            fontWeight: FontWeight.w400),
        labelLarge: TextStyle(
            color: AppColors.primaryDark,
            fontSize: AppSizes.button,
            fontWeight: FontWeight.w600),
      ),
      colorScheme: ColorScheme.fromSwatch(
              primarySwatch:
                  AppColors.generateMaterialColor(AppColors.secondary))
          .copyWith(background: AppColors.black),
      //fontFamily: FontFamily.poppinsRegular,
    );
  }
}
