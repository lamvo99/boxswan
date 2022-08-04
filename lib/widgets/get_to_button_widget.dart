import 'package:box_swan/core/constant/app_colors.dart';
import 'package:box_swan/core/constant/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GetToButtonWidget extends StatelessWidget {
  final String? text;
  final Function()? onTap;
  final bool isHighLight;
  final double? width;
  final double? height;
  final double? fontSize;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final Color? colorButton;

  const GetToButtonWidget({
    Key? key,
    this.text,
    this.onTap,
    this.isHighLight = true,
    this.width,
    this.height,
    this.margin,
    this.fontSize,
    this.borderRadius,
    this.fontWeight,
    this.colorButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: width ?? double.infinity,
          height: height ?? 56.h,
          margin: margin,
          decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(12.r),
            color: isHighLight ? colorButton ?? AppColors.appColorDefault : AppColors.alabaster,
          ),
          child: Center(
            child: Text(
              text ?? "",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize ?? 16.sp,
                fontFamily: AppConstants.openSanFont,
                fontWeight: fontWeight ?? FontWeight.w600,
                color: isHighLight ? Colors.white : AppColors.darkJungleGreen,
              ),
            ),
          )),
    );
  }
}