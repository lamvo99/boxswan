import 'package:box_swan/core/constant/app_colors.dart';
import 'package:box_swan/core/constant/app_constants.dart';
import 'package:box_swan/core/constant/app_themes.dart';
import 'package:box_swan/core/constant/export_constants.dart';
import 'package:box_swan/core/language/trans_helper.dart';
import 'package:box_swan/model/show_case_key.dart';
import 'package:box_swan/widgets/custom_show_case_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BalanceCard extends StatelessWidget {
  final String balance;
  final String income;
  final String spending;
  final RxString locale;

  const BalanceCard(
      {Key? key, required this.balance, required this.income, required this.spending, required this.locale})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      child: Container(
        height: 200.h,
        decoration: BoxDecoration(
          color: Get.isDarkMode ? AppColors.davyGrey : AppColors.mercury,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(color: Colors.grey.shade500, offset: Offset(4.0, 4.0), blurRadius: 15.r, spreadRadius: 1.r),
            BoxShadow(color: Colors.white, offset: Offset(-4.0, -4.0), blurRadius: 15.r, spreadRadius: 1.r),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(TransHelper.balance, style: textWhite22Bold),
              CustomShowCaseWidget(
                globalKey: ShowKey.keyEight,
                description: TransHelper.keyEight,
                child: Text(numberFormatCurrency(balance, locale.value), style: textWhite30W600),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[200],
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_upward,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(TransHelper.income, style: textWhite16W600),
                            SizedBox(height: 4.h),
                            Text(numberFormatCurrency(income, locale.value), style: textWhite18W600),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[200],
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_downward,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Text(TransHelper.spending, style: textWhite16W600),
                            Text(numberFormatCurrency(spending, locale.value), style: textWhite18W600),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
