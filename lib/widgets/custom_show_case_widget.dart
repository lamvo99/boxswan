import 'package:box_swan/core/constant/app_colors.dart';
import 'package:box_swan/core/constant/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomShowCaseWidget extends StatelessWidget {
  final Widget child;
  final String description;
  final GlobalKey globalKey;
  const CustomShowCaseWidget({Key? key, required this.child, required this.description, required this.globalKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Showcase(
      key: globalKey,
      description: description,
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      descTextStyle: textWhite18W600,
      showcaseBackgroundColor: AppColors.bluishClr,
      child: child,
    );
  }
}
