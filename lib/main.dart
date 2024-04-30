import 'package:distech_technology/Commons/theme.dart';
import 'package:distech_technology/Features/Home/Presentation/home_screen.dart';
import 'package:distech_technology/Features/Splash/Presentation/splash_screen.dart';
import 'package:distech_technology/Utils/storage/local_storage.dart';
import 'package:distech_technology/Widgets/dismissable_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:upgrader/upgrader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Upgrader.clearSavedSettings();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Upgrader.clearSavedSettings();

  /// app oriantation
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,

      /// status bar background color
      statusBarIconBrightness: Brightness.light,

      /// status bar icon and background color
      statusBarBrightness: Brightness.dark));
  final String jwtToken = await LocalStorageService()
          .getFromDisk(LocalStorageService.ACCESS_TOKEN_KEY) ??
      "";
  final String userName =
      await LocalStorageService().getFromDisk(LocalStorageService.USER_NAME) ??
          "";
  runApp(EasyLocalization(
      supportedLocales: const [
        Locale('hi', 'IN'),
        Locale('en', 'US'),
        Locale('bn', 'BD'),
      ],
      startLocale: const Locale('en', 'US'), // Default starting locale
      path: "assets/translations",
      fallbackLocale: const Locale('en', 'US'),
      child: MyApp(jwtToken: jwtToken, userName: userName)));
}

class MyApp extends StatelessWidget {
  final String jwtToken;
  final String userName;
  const MyApp({super.key, required this.jwtToken, required this.userName});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'singham lottery',
        theme: AppTheme.lightTheme,
        themeMode: ThemeMode.light,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: SafeArea(
          child: (jwtToken != "")
              ? UpgradeAlert(

                  /// get update when upload new build in google play store and app store
                  upgrader: Upgrader(
                    // debugDisplayAlways: true,
                    dialogStyle: UpgradeDialogStyle.cupertino,
                    showIgnore: false,
                    showLater: false,
                    showReleaseNotes: false,
                  ),
                  child: HomeScreen())
              : const SplashScreen(),
        ),
      ),
    );
  }
}
