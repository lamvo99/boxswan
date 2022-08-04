import 'package:box_swan/controller/home_view_controller.dart';
import 'package:box_swan/core/constant/app_colors.dart';
import 'package:box_swan/core/constant/app_constants.dart';
import 'package:box_swan/core/constant/app_themes.dart';
import 'package:box_swan/core/language/trans_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotifiedPage extends StatelessWidget {
  final String label;
  NotifiedPage({Key? key, required this.label}) : super(key: key);
  final HomeViewController homeViewController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Get.isDarkMode ? AppColors.davyGrey : AppColors.white,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Get.isDarkMode ? AppColors.white : AppColors.davyGrey,
          ),
        ),
        centerTitle: true,
        title: Text(this.label.toString().split("|")[0], style: textDarkJungleGreen28Bold,),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 18.h),
            Obx(()=> Text('${TransHelper.hello} ${homeViewController.userName}', style: textDarkJungleGreen30W500),),
            SizedBox(height: 8.h),
            Text(TransHelper.remider),
            SizedBox(height: 24.h),
            Center(
              child: Container(
                height: 400.h,
                width: AppConstants.width*0.9,
                padding: EdgeInsets.only(left: 30.w, right: 20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  color:  _getBGClr(int.parse(this.label.toString().split("|")[3])),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.task, size: 40, color: AppColors.white),
                        SizedBox(width: 8.w),
                        Text(TransHelper.title, style: textWhite30W600)
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      this.label.toString().split("|")[0],
                      style: textWhite22Bold,
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.description, size: 40, color: AppColors.white),
                        SizedBox(width: 8.w),
                        Text(TransHelper.note, style: textWhite30W600)
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      this.label.toString().split("|")[1],
                      style: textWhite22Bold,
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.calendar_today_outlined, size: 40, color: AppColors.white),
                        SizedBox(width: 8.w),
                        Text(TransHelper.date, style: textWhite30W600)
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      this.label.toString().split("|")[2],
                      style: textWhite22Bold,
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.repeat, size: 40, color: AppColors.white),
                        SizedBox(width: 8.w),
                        Text(TransHelper.repeat, style: textWhite30W600)
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      this.label.toString().split("|")[3],
                      style: textWhite22Bold,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getBGClr(int no){
    switch (no){
      case 0 :
        return AppColors.bluishClr;
      case 1 :
        return AppColors.pinkClr;
      case 2 :
        return AppColors.yellowClr;
      default:
        return AppColors.bluishClr;
    }
  }
}
