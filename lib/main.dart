import 'package:distech_technology/Commons/theme.dart';
import 'package:distech_technology/Features/Login/Presentation/login_screen.dart';
import 'package:distech_technology/Features/Splash/Presentation/splash_screen.dart';
import 'package:distech_technology/Utils/storage/local_storage.dart';
import 'package:distech_technology/global_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark));
       final String jwtToken = await LocalStorageService()
              .getFromDisk(LocalStorageService.ACCESS_TOKEN_KEY)??"";
  runApp(MyApp(jwtToken: jwtToken));
}
class MyApp extends StatelessWidget {
  final String jwtToken;
  const MyApp({super.key ,required this.jwtToken});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GlobalBloc(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Distech Technology',
        theme:AppTheme.lightTheme,
        themeMode: ThemeMode.light,
        home: (jwtToken!="")?const LoginScreen() :const SplashScreen(),
      ),
    );
  }
}
