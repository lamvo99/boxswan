import 'package:box_swan/core/constant/app_colors.dart';
import 'package:box_swan/core/constant/app_constants.dart';
import 'package:box_swan/core/constant/app_themes.dart';
import 'package:box_swan/core/constant/export_constants.dart';
import 'package:box_swan/model/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTransaction extends StatelessWidget {
  final ExpenseModel expense;
  final RxString selectedtLang;

  const MyTransaction({
    Key? key,
    required this.expense,
    required this.selectedtLang,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
          color: Get.isDarkMode ? AppColors.davyGrey : AppColors.mercury, borderRadius: BorderRadius.circular(12.r)),
      height: 80.h,
      width: AppConstants.width*0.95,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey[500]),
                  child: Center(
                    child: Icon(
                      Icons.attach_money_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(expense.nameTrans.toString(), style: textWhite22Bold),
                    Text(expense.date.toString(), style: textWhite16W600),
                  ],
                ),
              ],
            ),
        Text(
          (expense.incomOrSpending == 0 ? '- ' : '+ ') + numberFormatCurrency(expense.amount.toString(), selectedtLang.value),
          style: TextStyle(
            //fontWeight: FontWeight.bold,
            fontSize: 16,
            color:
            expense.incomOrSpending == 0 ? Colors.red : Colors.green,
          ),
        ),],
        ),
      ),
    );
  }
}
