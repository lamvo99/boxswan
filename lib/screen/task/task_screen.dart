import 'package:box_swan/controller/task_controller.dart';
import 'package:box_swan/core/constant/app_colors.dart';
import 'package:box_swan/core/constant/app_constants.dart';
import 'package:box_swan/core/constant/app_images.dart';
import 'package:box_swan/core/constant/app_themes.dart';
import 'package:box_swan/core/language/trans_helper.dart';
import 'package:box_swan/core/services/notification_services.dart';
import 'package:box_swan/model/show_case_key.dart';
import 'package:box_swan/model/task_model.dart';
import 'package:box_swan/screen/task/widgets/task_item.dart';
import 'package:box_swan/widgets/custom_show_case_widget.dart';
import 'package:box_swan/widgets/get_to_button_widget.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controller/themes_controllers.dart';
import '../../core/language/localization_services.dart';
import '../add_task/add_task_screen.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  Rx<DateTime> _selectedDate = DateTime.now().obs;
  DateTime _selectDate = DateTime.now();
  final themeController = Get.find<ThemeController>();
  var notifyHelper = NotifyHelper();
  final TaskController taskController = Get.find();
  final RxString _selectedLang = LocalizationService.locale!.languageCode.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Get.isDarkMode ? AppColors.black : AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAddTaskBar(),
          _buildTimeLine(),
          SizedBox(height: 8.h),
          _showTask(),
        ],
      ),
    );
  }

  Widget _showTask() {
    return Expanded(
      child: Obx(
        () => taskController.taskList.length == 0
            ? Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(AppImages.list),
                      Text(
                       TransHelper.notTask1,
                        style: textMercury18W600,
                      ),
                      Text(
                        TransHelper.notTask2,
                        style: textMercury18W600,
                      )
                    ],
                  ),
                ),
              )
            : ListView.builder(
                itemCount: taskController.taskList.length,
                itemBuilder: (_, index) {
                  TaskModel task = taskController.taskList[index];
                  if (task.repeat == AppConstants.repeatList[0]) {
                    var dateDiff = taskDateDiffrent(task.date.toString());
                    if (dateDiff < 0) {
                      taskController.delete(task: task);
                    }
                  }
                  if (task.repeat == AppConstants.repeatList[1]) {
                    DateTime date = DateFormat.jm().parse(task.startTime.toString());
                    var myTime = DateFormat("HH:mm").format(date);
                    notifyHelper.scheduledNotification(
                      hour: int.parse(myTime.toString().split(":")[0]),
                      minutes: int.parse(myTime.toString().split(":")[1]),
                      task: task,
                    );
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      child: SlideAnimation(
                        child: FadeInAnimation(
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _showBottomSheet(context, task);
                                },
                                child: TaskItem(task: task),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  if (task.repeat == AppConstants.repeatList[2]) {
                    DateTime dat = formatStringDate(task.date.toString());
                    String weekly = DateFormat('EEEE').format(dat);
                    if(weekly == DateFormat('EEEE').format(_selectDate).toString()){
                      DateTime date = DateFormat.jm().parse(task.startTime.toString());
                      var myTime = DateFormat("HH:mm").format(date);
                      notifyHelper.scheduledNotification(
                        hour: int.parse(myTime.toString().split(":")[0]),
                        minutes: int.parse(myTime.toString().split(":")[1]),
                        task: task,
                      );
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        child: SlideAnimation(
                          child: FadeInAnimation(
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _showBottomSheet(context, task);
                                  },
                                  child: TaskItem(task: task),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  }
                  if (task.repeat == AppConstants.repeatList[3]) {
                    DateTime dat = formatStringDate(task.date.toString());
                    String monthDay = DateFormat('d').format(dat);
                    if(monthDay == DateFormat('d').format(_selectDate).toString()){
                      DateTime date = DateFormat.jm().parse(task.startTime.toString());
                      var myTime = DateFormat("HH:mm").format(date);
                      notifyHelper.scheduledNotification(
                        hour: int.parse(myTime.toString().split(":")[0]),
                        minutes: int.parse(myTime.toString().split(":")[1]),
                        task: task,
                      );
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        child: SlideAnimation(
                          child: FadeInAnimation(
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _showBottomSheet(context, task);
                                  },
                                  child: TaskItem(task: task),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  }
                  if (task.date == DateFormat.yMd().format(_selectDate)) {
                    if (task.repeat != AppConstants.repeatList[1]) {
                      DateTime date = DateFormat.jm().parse(task.startTime.toString());
                      var myTime = DateFormat("HH:mm").format(date);
                      notifyHelper.scheduledNotification(
                        hour: int.parse(myTime.toString().split(":")[0]),
                        minutes: int.parse(myTime.toString().split(":")[1]),
                        task: task,
                      );
                    }
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      child: SlideAnimation(
                        child: FadeInAnimation(
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _showBottomSheet(context, task);
                                },
                                child: TaskItem(task: task),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
      ),
    );
  }

  DateTime formatStringDate(String dateString){
    String year = dateString.split("/")[2];
    String date = dateString.split("/")[1];
    String mounth = dateString.split("/")[0];
    if (int.parse(mounth) < 10) {
      mounth = "0" + mounth;
    }
    String time = year + mounth + date;
    DateTime tasDate = DateTime.parse(time);
    return tasDate;
  }
  int taskDateDiffrent(String dateString) {
    String year = dateString.split("/")[2];
    String date = dateString.split("/")[1];
    String mounth = dateString.split("/")[0];
    if (int.parse(mounth) < 10) {
      mounth = "0" + mounth;
    }
    String time = year + mounth + date;
    DateTime tasDate = DateTime.parse(time);
    var dateDiff = tasDate.difference(DateTime.now()).inDays;
    return dateDiff;
  }

  _showBottomSheet(BuildContext context, TaskModel task) {
    Get.bottomSheet(Container(
      decoration: BoxDecoration(
          color: Get.isDarkMode ? AppColors.darkHeaderClr : AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      padding: EdgeInsets.only(top: 10.h),
      height: task.isCompleted == 1 ? AppConstants.height * 0.24 : AppConstants.height * 0.32,
      child: Column(
        children: [
          Container(
            height: 6.h,
            width: 120.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode ? AppColors.alabaster : AppColors.mercury),
          ),
          task.isCompleted == 1
              ? Container()
              : GetToButtonWidget(
                  text: TransHelper.taskCompleted,
                  onTap: () {
                    taskController.markTaskCompleted(id: task.id);
                    Get.back();
                    EasyLoading.showSuccess(TransHelper.taskCompleted);
                  },
                  colorButton: AppColors.appColorDefault,
                  fontWeight: FontWeight.bold,
                  isHighLight: true,
                  margin: EdgeInsets.only(left: 22.w, right: 22.w, top: 10.h),
                ),
          GetToButtonWidget(
            text: TransHelper.deleteTask,
            onTap: () {
              taskController.delete(task: task);
              Get.back();
              EasyLoading.showSuccess(TransHelper.deleteTaskSuccess);
            },
            colorButton: AppColors.redClr,
            fontWeight: FontWeight.bold,
            isHighLight: true,
            margin: EdgeInsets.only(left: 22.w, right: 22.w, top: 10.h),
          ),
          Spacer(),
          GetToButtonWidget(
            text: TransHelper.close,
            onTap: () => Get.back(),
            colorButton: Get.isDarkMode ? AppColors.alabaster : AppColors.mercury,
            fontWeight: FontWeight.bold,
            margin: EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
          ),
        ],
      ),
    ));
  }

  Widget _buildTimeLine() {
    return CustomShowCaseWidget(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 12.w),
          child: DatePicker(
            DateTime.now(),
            height: 100.h,
            width: 60.w,
            initialSelectedDate: DateTime.now(),
            selectionColor: Get.isDarkMode ? AppColors.aquaHaze : AppColors.bluishClr,
            selectedTextColor: Get.isDarkMode ? AppColors.black : AppColors.black,
            dateTextStyle: textMercury20W500,
            monthTextStyle: textMercury16W400,
            dayTextStyle: textMercury16W400,
            onDateChange: (date) {
              _selectedDate.value = date;
              if (mounted)
                setState(() {
                  _selectDate = date;
                });
            },
          ),
        ),
        description: TransHelper.keySix,
        globalKey: ShowKey.keySix,
    );
  }

  Widget _buildAddTaskBar() {
    return Container(
      margin: EdgeInsets.only(left: 14.w, right: 14.w, top: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMd().format(DateTime.now()),
                  style: textMercury18W600,
                ),
                Text(
                  TransHelper.today,
                  style: textDarkJungleGreen28Bold,
                ),
              ],
            ),
          ),
          CustomShowCaseWidget(
            globalKey: ShowKey.keyFive,
            description: TransHelper.keyFive,
            child: GetToButtonWidget(
              text: '+ ${TransHelper.addtask}',
              onTap: () async {
                await Get.to(() => AddTaskScreen(), transition: Transition.rightToLeftWithFade);
                taskController.getTasks();
              },
              width: 100.w,
              height: 50.h,
              colorButton: Get.isDarkMode ? AppColors.aquaHaze : AppColors.bluishClr,
              isHighLight: !Get.isDarkMode,
            ),
          )
        ],
      ),
    );
  }
}
