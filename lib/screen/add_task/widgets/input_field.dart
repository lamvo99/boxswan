import 'package:box_swan/core/constant/app_colors.dart';
import 'package:box_swan/core/constant/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class InputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  final bool isHiveFight;

  const InputField({
    Key? key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
    this.isHiveFight = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textDarkJungleGreen18W600,
          ),
          Container(
            height: 60.h,
            margin: EdgeInsets.only(top: 8.h),
            padding: EdgeInsets.only(left: 10.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: AppColors.davyGrey,
                  width: 1.w,
                )),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget == null ? false : true,
                    autofocus: false,
                    cursorColor: Get.isDarkMode ? AppColors.mercury : AppColors.davyGrey,
                    controller: controller,
                    style: textDarkJungleGreen16W400,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: isHiveFight ? textDarkJungleGreen16W400 : textMercury16W400,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: context.theme.backgroundColor, width: 0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: context.theme.backgroundColor, width: 0),
                      ),
                    ),
                  ),
                ),
                widget == null ? Container() : Center(child: Container(child: widget))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
