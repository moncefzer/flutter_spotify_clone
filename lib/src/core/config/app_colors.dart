import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const primary = Color(0xff1ED760);
  static const grey = Color(0xffB3B3B3);
  static const lightGrey = Color(0xffE5E5E5);
  static const black = Color(0xff111111);

  static ColorScheme darkColorScheme = const ColorScheme.light(
    primary: primary,
    background: black,
  );
  static ColorScheme lightColorScheme = const ColorScheme.light(
    primary: primary,
    background: Colors.white,
  );
}
