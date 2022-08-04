import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_colors.dart';
import 'app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  // Theme
  static final light = ThemeData(
    primaryColor: AppColors.brightGold,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(),
    backgroundColor: AppColors.white,
  );

  static final dark = ThemeData(
      primaryColor: AppColors.appColorDefault,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(),
      backgroundColor: AppColors.davyGrey);
}

TextStyle get textDarkJungleGreen30W500 {
  return TextStyle(
    fontSize: 30.sp,
    color: Get.isDarkMode ? AppColors.white : AppColors.darkJungleGreen,
    fontWeight: FontWeight.w500,
    fontFamily: AppConstants.openSanFont,
  );
}

TextStyle get textDarkJungleGreen18W600 {
  return TextStyle(
    fontSize: 18.sp,
    color: Get.isDarkMode ? AppColors.white : AppColors.darkJungleGreen,
    fontWeight: FontWeight.w600,
    fontFamily: AppConstants.openSanFont,
  );
}

TextStyle get textDarkJungleGreen16W400 {
  return TextStyle(
    fontSize: 16.sp,
    color: Get.isDarkMode ? AppColors.white : AppColors.darkJungleGreen,
    fontWeight: FontWeight.w400,
    fontFamily: AppConstants.openSanFont,
  );
}

TextStyle get textMercury16W400 {
  return TextStyle(
    fontSize: 16.sp,
    color: Get.isDarkMode ? AppColors.white : AppColors.mercury,
    fontWeight: FontWeight.w400,
    fontFamily: AppConstants.openSanFont,
  );
}

TextStyle get textMercury16W600 {
  return TextStyle(
    fontSize: 16.sp,
    color: Get.isDarkMode ? AppColors.white : AppColors.mercury,
    fontWeight: FontWeight.w600,
    fontFamily: AppConstants.openSanFont,
  );
}

TextStyle get textMercury18W600 {
  return TextStyle(
    fontSize: 18.sp,
    color: Get.isDarkMode ? AppColors.white : AppColors.mercury,
    fontWeight: FontWeight.bold,
    fontFamily: AppConstants.openSanFont,
  );
}

TextStyle get textMercury20W500 {
  return TextStyle(
    fontSize: 20.sp,
    color: Get.isDarkMode ? AppColors.white : AppColors.mercury,
    fontWeight: FontWeight.w500,
    fontFamily: AppConstants.openSanFont,
  );
}

TextStyle get textWhite22Bold {
  return TextStyle(
    fontSize: 22.sp,
    color: AppColors.white ,
    fontWeight: FontWeight.bold,
    fontFamily: AppConstants.openSanFont,
  );
}

TextStyle get textWhite30W600 {
  return TextStyle(
    fontSize: 30.sp,
    color: AppColors.white ,
    fontWeight: FontWeight.w600,
    fontFamily: AppConstants.openSanFont,
  );
}

TextStyle get textMercury20Bold {
  return TextStyle(
    fontSize: 20.sp,
    color: Get.isDarkMode ? AppColors.white : AppColors.mercury,
    fontWeight: FontWeight.bold,
    fontFamily: AppConstants.openSanFont,
  );
}

TextStyle get textGrey20W500 {
  return TextStyle(
    fontSize: 20.sp,
    color: Get.isDarkMode ? AppColors.white : AppColors.davyGrey,
    fontWeight: FontWeight.w500,
    fontFamily: AppConstants.openSanFont,
  );
}

TextStyle get textDarkJungleGreen22Bold {
  return TextStyle(
    fontSize: 22.sp,
    color: AppColors.darkJungleGreen,
    fontWeight: FontWeight.bold,
    fontFamily: AppConstants.robotoFont,
  );
}

TextStyle get textDarkJungleGreen28Bold {
  return TextStyle(
    fontSize: 28.sp,
    color: Get.isDarkMode ? AppColors.white : AppColors.darkJungleGreen,
    fontWeight: FontWeight.bold,
    fontFamily: AppConstants.robotoFont,
  );
}

TextStyle get textDarkJungleGreen22W600 {
  return TextStyle(
    fontSize: 22.sp,
    color: Get.isDarkMode ? AppColors.white : AppColors.darkJungleGreen,
    fontWeight: FontWeight.w600,
    fontFamily: AppConstants.openSanFont,
  );
}

TextStyle get textBlue18W600 {
  return TextStyle(
    fontSize: 18.sp,
    color: Get.isDarkMode ? AppColors.white : AppColors.blue,
    fontWeight: FontWeight.w600,
    fontFamily: AppConstants.openSanFont,
  );
}

TextStyle get textWhite18W600 {
  return TextStyle(
    fontSize: 18.sp,
    color: AppColors.white,
    fontWeight: FontWeight.w600,
    fontFamily: AppConstants.openSanFont,
  );
}

TextStyle get textWhite16W600 {
  return TextStyle(
    fontSize: 16.sp,
    color: AppColors.white,
    fontWeight: FontWeight.w600,
    fontFamily: AppConstants.openSanFont,
  );
}

TextStyle get textWhite10Bold {
  return TextStyle(
    fontSize: 10.sp,
    color: AppColors.white,
    fontWeight: FontWeight.bold,
    fontFamily: AppConstants.openSanFont,
  );
}

TextStyle get textAbls13W400 {
  return TextStyle(
    fontSize: 13.sp,
    color: AppColors.alabaster,
    fontWeight: FontWeight.w400,
    fontFamily: AppConstants.openSanFont,
  );
}

TextStyle get textAbls15W400 {
  return TextStyle(
    fontSize: 15.sp,
    color: AppColors.alabaster,
    fontWeight: FontWeight.w400,
    fontFamily: AppConstants.openSanFont,
  );
}
