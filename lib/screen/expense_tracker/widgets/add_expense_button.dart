import 'package:box_swan/core/constant/app_colors.dart';
import 'package:box_swan/core/constant/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddExpenseButton extends StatelessWidget {
  final Function()? onTap;
  const AddExpenseButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: Get.isDarkMode ? AppColors.mercury : AppColors.davyGrey,
        ),
        width: 50.w,
        height: 50.h,
        child: Center(
          child: Text('+', style: textDarkJungleGreen30W500),
        ),
      )
    );
  }
}
