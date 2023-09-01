import 'package:distech_technology/Commons/theme.dart';
import 'package:distech_technology/Features/Home/Presentation/home_screen.dart';
import 'package:distech_technology/Features/Splash/Presentation/splash_screen.dart';
import 'package:distech_technology/Utils/storage/local_storage.dart';
import 'package:distech_technology/Widgets/dismissable_widget.dart';
import 'package:distech_technology/global_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark));
  final String jwtToken = await LocalStorageService()
          .getFromDisk(LocalStorageService.ACCESS_TOKEN_KEY) ??
      "";
  final String userName =
      await LocalStorageService().getFromDisk(LocalStorageService.USER_NAME) ??
          "";
  runApp(MyApp(jwtToken: jwtToken, userName: userName));
}

class MyApp extends StatelessWidget {
  final String jwtToken;
  final String userName;
  const MyApp({super.key, required this.jwtToken, required this.userName});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: GlobalBloc(
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'singham lottery',
          theme: AppTheme.lightTheme,
          themeMode: ThemeMode.light,
          home: (jwtToken != "")
              ? HomeScreen(username: userName)
              : const SplashScreen(),
        ),
      ),
    );
  }
}

//
