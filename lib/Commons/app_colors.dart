import 'dart:math';
import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF1F6AFD);
  static const primaryBg = Color(0xFFF2F4FF);
  static const primaryDark = Color(0xFF0042C2);
  static const secondary = Color(0xFFF34001);
  static const white = Color(0xFFFFFFFF);
  static const scaffold = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const darkGrey = Color(0xFF515151);
  static const lightGrey = Color(0xFFC2C1C1);
  static const grey = Color(0xFF8E8D8D);
  static const bg = Color(0xFFD8DEFF);
  static const transparent = Color(0x00FFFFFF);
  static const linearGradient =
      LinearGradient(begin: Alignment.center, colors: [primary, primaryDark]);
  static const radialGradient = RadialGradient(colors: [primary, primaryDark]);

  static MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: tintColor(color, 0.9),
      100: tintColor(color, 0.8),
      200: tintColor(color, 0.6),
      300: tintColor(color, 0.4),
      400: tintColor(color, 0.2),
      500: color,
      600: shadeColor(color, 0.1),
      700: shadeColor(color, 0.2),
      800: shadeColor(color, 0.3),
      900: shadeColor(color, 0.4),
    });
  }

  static int tintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  static Color tintColor(Color color, double factor) => Color.fromRGBO(
      tintValue(color.red, factor),
      tintValue(color.green, factor),
      tintValue(color.blue, factor),
      1);

  static int shadeValue(int value, double factor) =>
      max(0, min(value - (value * factor).round(), 255));

  static Color shadeColor(Color color, double factor) => Color.fromRGBO(
      shadeValue(color.red, factor),
      shadeValue(color.green, factor),
      shadeValue(color.blue, factor),
      1);
}
