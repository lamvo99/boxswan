import 'package:box_swan/controller/task_controller.dart';
import 'package:box_swan/core/constant/app_constants.dart';
import 'package:box_swan/core/constant/app_images.dart';
import 'package:box_swan/core/constant/app_themes.dart';
import 'package:box_swan/core/language/trans_helper.dart';
import 'package:box_swan/model/task_model.dart';
import 'package:box_swan/screen/add_task/widgets/input_field.dart';
import 'package:box_swan/widgets/get_to_button_widget.dart';
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../core/constant/app_colors.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {

  DateTime _selectDate = DateTime.now();
  DateTime _valiDate = DateTime.now();
  String _endTime = '11:59 PM';
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  DateTime _valStartTime = DateTime.now();
  DateTime _valEndTime = DateTime.now();
  int _selectRemind = AppConstants.remindList[0];
  String _selectRepeat = AppConstants.repeatList[0];
  int _selectColor = 0;
  var titleController = TextEditingController();
  var noteController  = TextEditingController();
  final taskController = Get.find<TaskController>();

  TimeOfDay _time = TimeOfDay.now();
  bool iosStyle = true;

  void onTimeChanged(TimeOfDay newTime) {
    setState(() {
      _time = newTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Container(
          height: AppConstants.height,
          width: AppConstants.width,
          color: Get.isDarkMode ? AppColors.black : AppColors.white,
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(TransHelper.addtask, style: textDarkJungleGreen22W600),
              InputField(title: TransHelper.title, hint: TransHelper.hintTitle, controller: titleController),
              InputField(title: TransHelper.note, hint: TransHelper.hintnote, controller: noteController),
              InputField(
                title: TransHelper.date,
                hint: DateFormat.yMd().format(_selectDate),
                isHiveFight: true,
                widget: IconButton(
                  onPressed: () {
                    _getDateFromUser();
                  },
                  icon: Icon(
                    CupertinoIcons.calendar_today,
                    color: Get.isDarkMode ? AppColors.alabaster : AppColors.davyGrey,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      title: TransHelper.startTime,
                      hint: _startTime,
                      isHiveFight: true,
                      widget: IconButton(
                        onPressed: () => _getTimeFormUser(isStartTime: true),
                        icon: Icon(
                          Icons.access_time,
                          color: Get.isDarkMode ? AppColors.alabaster : AppColors.davyGrey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: InputField(
                      title: TransHelper.endTime,
                      hint: _endTime,
                      isHiveFight: true,
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFormUser(isStartTime: false);
                        },
                        icon: Icon(
                          Icons.access_time,
                          color: Get.isDarkMode ? AppColors.alabaster : AppColors.davyGrey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              InputField(
                title: TransHelper.remind,
                hint: "$_selectRemind ${TransHelper.minutesEarly}",
                isHiveFight: true,
                widget: DropdownButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Get.isDarkMode ? AppColors.alabaster : AppColors.davyGrey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: textDarkJungleGreen16W400,
                  underline: Container(height: 0),
                  onChanged: (String? newValue) {
                    if (mounted) {
                      setState(() {
                        _selectRemind = int.parse(newValue!);
                      });
                    }
                  },
                  items: AppConstants.remindList.map<DropdownMenuItem<String>>((int value) {
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
              ),
              InputField(
                title: TransHelper.repeat,
                hint: _selectRepeat,
                isHiveFight: true,
                widget: DropdownButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Get.isDarkMode ? AppColors.alabaster : AppColors.davyGrey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: textDarkJungleGreen16W400,
                  underline: Container(height: 0),
                  onChanged: (String? newValue) {
                    if (mounted) {
                      setState(() {
                        _selectRepeat = newValue!;
                      });
                    }
                  },
                  items: AppConstants.repeatList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
              ),
              _buildSelectColor(),
              GetToButtonWidget(
                onTap: ()=> validate(),
                text: TransHelper.createTask,
                fontSize: 18,
                margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 12.h),
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(){
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Get.isDarkMode ? AppColors.white : AppColors.black,
        ),
      ),
      actions: [
        SizedBox(
          width: 35.w,
          height: 35.h,
          child: Image.asset(AppImages.man),
        ),
        SizedBox(width: 6.w)
      ],
    );
  }

  validate(){
    EasyLoading.show(status: TransHelper.validation);
    if(titleController.text.isNotEmpty&&noteController.text.isNotEmpty){
      _addTaskToDb();
      Get.back();
      EasyLoading.showSuccess(TransHelper.addTaskSucces);
  } else if(titleController.text.isEmpty || noteController.text.isEmpty){
      EasyLoading.showError(TransHelper.fieldRequired);
    }
  }

  _addTaskToDb()async{
    int value = await taskController.addTask(
        task:TaskModel(
          note: noteController.text,
          title: titleController.text,
          date: DateFormat.yMd().format(_selectDate),
          startTime: _startTime,
          endTime: _endTime,
          remind: _selectRemind,
          repeat: _selectRepeat,
          color: _selectColor,
          isCompleted: 0,
        )
    );
  }

  Widget _buildSelectColor() {
    return Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(TransHelper.color, style: textDarkJungleGreen18W600),
              SizedBox(height: 6.h),
              Wrap(
                children: List<Widget>.generate(
                  3,
                  (int index) {
                    return GestureDetector(
                      onTap: () {
                        if (mounted) {
                          setState(() {
                            _selectColor = index;
                          });
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: CircleAvatar(
                          radius: 14.r,
                          backgroundColor: index == 0
                              ? AppColors.bluishClr
                              : index == 1
                                  ? AppColors.pinkClr
                                  : AppColors.yellowClr,
                          child: _selectColor == index
                              ? Icon(
                                  Icons.done,
                                  color: AppColors.white,
                                  size: 16,
                                )
                              : Container(),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        helpText: TransHelper.selectDate,
        cancelText: TransHelper.cancel,
        confirmText: TransHelper.ok,
        initialDate: DateTime.now(),
        firstDate: DateTime(2017),
        lastDate: DateTime(2025),
        errorInvalidText: TransHelper.outOfRange,
        errorFormatText: TransHelper.correctDateFormat,
        fieldLabelText: TransHelper.enterDate);
    if (_pickerDate != null) {
      if (mounted)
        setState(() {
          _selectDate = _pickerDate;
        });
      var dateDiff = _selectDate.difference(_valiDate).inDays;
      if(dateDiff <0){
        if (mounted)
          setState(() {
            _selectDate = DateTime.now();
          });
        EasyLoading.showError("The selected date must be after the current date!");
      }
    } else {
      debugPrint("It's null or something is wrong");
    }
  }

  _getTimeFormUser({required bool isStartTime}) {
    Navigator.of(context).push(
      showPicker(
        context: context,
        value: _time,
        onChange: onTimeChanged,
        minuteInterval: MinuteInterval.FIVE,
        // Optional onChange to receive value as DateTime
        onChangeDateTime: (DateTime dateTime) {
          if (isStartTime) {
            if (mounted)
              setState(() {
                _valStartTime = dateTime;
                _startTime = DateFormat("hh:mm a").format(dateTime).toString();
              });
          } else {
            if (mounted)
              setState(() {
                _valEndTime = dateTime;
              });
            if(_valEndTime.isBefore(_valStartTime)){
              EasyLoading.showError(TransHelper.endTimeAfter);
            }else{
              if (mounted)
                setState(() {
                  _endTime = DateFormat("hh:mm a").format(dateTime).toString();
                });
            }
          }
        },
      ),
    );
  }
}
