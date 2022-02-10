import 'package:flutter/material.dart';
import 'package:weather_firebase/ui/themes/app_colors.dart';

abstract class AppTheme {
  static final bgLight = ThemeData(
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
      color: AppColors.mainColor,
      elevation: 0,
      shadowColor: Color(0xFFFDF1DE),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.mainColor,
      unselectedItemColor: AppColors.whiteColor,
      selectedItemColor: AppColors.blackColor,
    ),
  );
}
