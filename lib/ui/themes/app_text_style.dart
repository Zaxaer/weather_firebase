import 'package:flutter/material.dart';
import 'package:weather_firebase/ui/themes/app_colors.dart';
import 'package:weather_firebase/ui/themes/app_fonts.dart';

abstract class AppTextStyle {
  static const button = TextStyle(
    color: AppColors.whiteColor,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    fontFamily: AppFonts.roboto,
    height: 1.25,
    letterSpacing: 0.4,
  );
}
