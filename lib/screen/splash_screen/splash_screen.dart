import 'dart:async';
import 'package:box_swan/core/constant/app_images.dart';
import 'package:box_swan/core/constant/app_routes.dart';
import 'package:box_swan/core/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constant/app_colors.dart';
import '../../core/db/Storage.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({Key? key}) : super(key: key);

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _configEasyLoading();
    _configNotification();
    Storage.initGetStorage();
    _checkOnboaring();
  }

  _checkOnboaring() async {
    final timer = Timer(Duration(seconds: 3), ()async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool _seen = (prefs.getBool('seen') ?? false);
      if(_seen) {
        Get.toNamed(AppRoute.home);
      }else {
        await prefs.setBool('seen', true);
        Get.toNamed(AppRoute.onboarding);
      }
    });
  }

  _configEasyLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 40.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = AppColors.appColorDefault
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.05)
      ..userInteractions = true
      ..dismissOnTap = false;
  }

  _configNotification(){
    var notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      BoxConstraints(maxWidth: MediaQuery.of(context).size.width, maxHeight: MediaQuery.of(context).size.height),
      context: context,
      minTextAdapt: true,
      orientation: Orientation.portrait,
      designSize: Size(414, 896),
    );
    return Container(
      color: AppColors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            child: Image.asset(AppImages.logo),
            borderRadius: BorderRadius.circular(20),
          ),
          SizedBox(height: 30),
          LoadingAnimationWidget.flickr(
            leftDotColor: AppColors.pinkClr,
            rightDotColor: AppColors.bluishClr,
            size: 100,
          ),
        ],
      ),
    );
  }
}
