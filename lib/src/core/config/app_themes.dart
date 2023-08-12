import 'package:flutter/material.dart';
import 'package:spotify_clone/src/core/config/app_colors.dart';
import './app_texts.dart';

class AppThemes {
  AppThemes._();

  static ThemeData lightTheme = ThemeData.light().copyWith(
    textTheme: AppText.lightThemeText,
    colorScheme: AppColors.lightColorScheme,
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    textTheme: AppText.darkThemeText,
    colorScheme: AppColors.darkColorScheme,
  );
}
