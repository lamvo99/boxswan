import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:box_swan/controller/home_view_controller.dart';
import 'package:box_swan/controller/task_controller.dart';
import 'package:box_swan/core/constant/app_colors.dart';
import 'package:box_swan/core/constant/app_constants.dart';
import 'package:box_swan/core/constant/app_func.dart';
import 'package:box_swan/core/constant/app_images.dart';
import 'package:box_swan/core/constant/app_themes.dart';
import 'package:box_swan/core/icon_custom/box_swan_icons.dart';
import 'package:box_swan/core/language/trans_helper.dart';
import 'package:box_swan/core/services/rating_servies.dart';
import 'package:box_swan/model/show_case_key.dart';
import 'package:box_swan/screen/expense_tracker/expense_tracker_screen.dart';
import 'package:box_swan/screen/task/task_screen.dart';
import 'package:box_swan/widgets/custom_show_case_widget.dart';
import 'package:box_swan/widgets/get_to_button_widget.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import '../../controller/themes_controllers.dart';
import '../../core/language/localization_services.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  final HomeViewController homeViewController = Get.find();

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      builder: Builder(builder: (context) => HomeViewShow()),
    );
  }
}

class HomeViewShow extends StatefulWidget {
  const HomeViewShow({Key? key}) : super(key: key);

  @override
  State<HomeViewShow> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeViewShow> {
  final themeController = Get.find<ThemeController>();
  final HomeViewController homeViewController = Get.find();
  final TaskController taskController = Get.find();
  final RxString _selectedLang = LocalizationService.locale!.languageCode.obs;
  var id = 0;
  final RatingAppServices _ratingAppServices = RatingAppServices();
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    homeViewController.checkId();
    _showFirstCase();
    Timer(const Duration(seconds: 3), () {
      _ratingAppServices.isSeconTimeOpen().then((seconOpen) {
        if (seconOpen) {
          _ratingAppServices.showRating();
        }
      });
    });
    super.initState();
  }

  _showFirstCase() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('isFirstCase') ?? false);
    if (_seen) {
    } else {
      await prefs.setBool('isFirstCase', true);
      WidgetsBinding.instance!.addPostFrameCallback((_) async {
        ShowCaseWidget.of(context)!.startShowCase(homeKeyList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        body: SizedBox.expand(
          child: PageView(
            physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
            children: [
              TaskScreen(),
              ExpenseTrackerScreen(selectedLang: _selectedLang),
            ],
            controller: homeViewController.pageController,
          ),
        ),
        bottomNavigationBar: CustomShowCaseWidget(
          description: TransHelper.keyFour,
          globalKey: ShowKey.keyFour,
          child: Obx(
            () => FancyBottomNavigation(
              tabs: [
                TabData(iconData: BoxSwan.tasks, title: TransHelper.taskNvi),
                TabData(iconData: BoxSwan.wallet, title: TransHelper.expenseTracker),
              ],
              onTabChangedListener: (position) {
                homeViewController.currentIndex.value = position;
                homeViewController.pageController.jumpToPage(position);
              },
              initialSelection: homeViewController.currentIndex.value,
              key: homeViewController.bottomNavigationKey,
              inactiveIconColor: AppColors.davyGrey,
              barBackgroundColor: AppColors.mercury,
            ),
          ),
        ));
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: context.theme.backgroundColor,
      automaticallyImplyLeading: false,
      elevation: 0,
      centerTitle: true,
      title: Obx(
        () => Text(
            homeViewController.userName.value == ""
                ? ""
                : "${TransHelper.hello} ${homeViewController.userName.value}",
            style: textDarkJungleGreen28Bold),
      ),
      leading: SizedBox(
        height: 40,
        width: 40,
        child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: CustomShowCaseWidget(
              globalKey: ShowKey.keyThree,
              description: TransHelper.keyThree,
              child: Obx(() => GestureDetector(
                    onTap: () => _addUsernameAndProfileImage(),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.r),
                      child: homeViewController.imageBase64.value == ""
                          ? Image.asset(AppImages.man)
                          : Image.memory(
                              base64Decode(homeViewController.imageBase64.value),
                              fit: BoxFit.cover,
                            ),
                    ),
                  )),
            )),
      ),
      actions: [
        CustomShowCaseWidget(
          description: TransHelper.keyTwo,
          globalKey: ShowKey.keyTwo,
          child: Obx(
            () => GestureDetector(
              onTap: () {
                Get.defaultDialog(
                    title: TransHelper.changeLang,
                    content: Column(
                      children: [
                        GetToButtonWidget(
                          onTap: () {
                            _selectedLang.value = AppConstants.en;
                            LocalizationService.changeLocale(AppConstants.en);
                            Get.back();
                          },
                          width: 200.w,
                          text: TransHelper.english,
                        ),
                        SizedBox(height: 4.h),
                        GetToButtonWidget(
                          onTap: () {
                            _selectedLang.value = AppConstants.vi;
                            LocalizationService.changeLocale(AppConstants.vi);
                            Get.back();
                          },
                          width: 200.w,
                          text: TransHelper.vietnamese,
                        ),
                        SizedBox(height: 4.h),
                        GetToButtonWidget(
                          onTap: () {
                            _selectedLang.value = AppConstants.zh;
                            LocalizationService.changeLocale(AppConstants.zh);
                            Get.back();
                          },
                          width: 200.w,
                          text: TransHelper.chinese,
                        ),
                      ],
                    ));
              },
              child: Image.asset(
                AppFunc.iconAsset(iconAs: _selectedLang.value),
                width: 18.w,
                height: 19.h,
              ),
            ),
          ),
        ),
        SizedBox(width: 8.w),
        CustomShowCaseWidget(
          description: TransHelper.keyOne,
          globalKey: ShowKey.keyOne,
          child: GestureDetector(
            onTap: () {
              if (Get.isDarkMode) {
                themeController.changeTheme(AppTheme.light);
                themeController.saveTheme(false);
              } else {
                themeController.changeTheme(AppTheme.dark);
                themeController.saveTheme(true);
              }
              // notifyHelper.displayNotification(
              //     title: "Theme Changed",
              //     body: Get.isDarkMode ? " Activated Dark Theme" : "Activated light Theme"
              // );
            },
            child: Icon(
              Get.isDarkMode ? Icons.nightlight_round : Icons.wb_sunny_rounded,
              size: 22,
              color: Get.isDarkMode ? AppColors.white : AppColors.brightGold,
            ),
          ),
        ),
        SizedBox(width: 6.w)
      ],
    );
  }

  _addUsernameAndProfileImage() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return AlertDialog(
                title: Text(TransHelper.addUserName, style: textDarkJungleGreen18W600),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.r))),
                contentPadding: EdgeInsets.only(top: 10.0, right: 6.w, left: 6.w),
                content: SingleChildScrollView(
                  child: Container(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(
                            () => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () => homeViewController.getImage(),
                                child: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100.r),
                                    child: homeViewController.imageBase64.value == ""
                                        ? Image.asset(AppImages.man)
                                        : Image.memory(
                                            base64Decode(homeViewController.imageBase64.value),
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                                // child: SizedBox(
                                //   height: 100,
                                //   width: 100,
                                //   child: ClipRRect(
                                //     child: imageBytes == null
                                //         ? Image.asset(AppImages.man,)
                                //         : ClipRRect(child: Image.memory(imageBytes!,fit: BoxFit.cover)),
                                //   )
                                // ),
                              ),
                            ),
                          ),
                          Text(
                            TransHelper.clickImage,
                            style: textMercury16W400,
                          ),
                          SizedBox(height: 14.h),
                          TextFormField(
                            autofocus: false,
                            cursorColor: Get.isDarkMode ? AppColors.mercury : AppColors.davyGrey,
                            controller: nameController,
                            style: textDarkJungleGreen16W400,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return TransHelper.enterUsername;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: homeViewController.userName.value == ""
                                  ? TransHelper.username
                                  : homeViewController.userName.value,
                              hintStyle: textMercury16W400,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(),
                              ),
                            ),
                          ),
                          SizedBox(height: 14.h),
                        ],
                      ),
                    ),
                  ),
                ),
                actions: <Widget>[
                  MaterialButton(
                    color: AppColors.pinkClr,
                    child: Text(TransHelper.cancel, style: TextStyle(color: AppColors.white)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                  ),
                  MaterialButton(
                    color: AppColors.bluishClr,
                    child: Text(TransHelper.ok, style: TextStyle(color: AppColors.white)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        homeViewController.saveUsername(nameController.text);
                        Get.back();
                      }
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                  ),
                ],
              );
            },
          );
        });
  }
}
