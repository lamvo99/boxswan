import 'package:box_swan/controller/task_controller.dart';
import 'package:box_swan/core/constant/app_colors.dart';
import 'package:box_swan/core/constant/app_constants.dart';
import 'package:box_swan/core/constant/app_themes.dart';
import 'package:box_swan/core/language/trans_helper.dart';
import 'package:box_swan/model/task_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskItem extends StatelessWidget {
  final TaskModel task;
  TaskItem({Key? key, required this.task}) : super(key: key);

  final TaskController taskController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConstants.width,
      margin: EdgeInsets.only(bottom: 8.h),
      padding:  EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: _getBGClr(task.color??0),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title?? "",
                    style: textWhite18W600
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey[200],
                        size: 18,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "${task.startTime} - ${task.endTime}",
                        style: textAbls13W400
                      )
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    task.note??"",
                    style: textAbls15W400
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 60.h,
              width:1.w,
              color:  AppColors.mercury,
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                task.isCompleted == 1 ? TransHelper.complete : TransHelper.todo,
                style: textWhite10Bold,
              ),
            )
          ],
        ),
      )
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
