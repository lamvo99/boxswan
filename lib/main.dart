import 'package:box_swan/core/db/db_helper.dart';
import 'package:box_swan/core/language/localization_services.dart';
import 'package:box_swan/core/services/binding.dart';
import 'package:box_swan/screen/add_task/add_task_screen.dart';
import 'package:box_swan/screen/home/home_view.dart';
import 'package:box_swan/screen/onboarding/onboarding_screen.dart';
import 'package:box_swan/screen/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'controller/themes_controllers.dart';
import 'core/constant/app_routes.dart';
import 'core/constant/app_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  await DBHelper.initDb();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeController());

    return GetMaterialApp(
      locale: LocalizationService.locale,
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: LocalizationService(),
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeController.theme,
      initialBinding: Binding(),
      initialRoute: AppRoute.spalsh,
      getPages: [
        GetPage(name: AppRoute.spalsh, page: () => const SpalshScreen()),
        GetPage(name: AppRoute.home, page: () =>  HomeView()),
        GetPage(name: AppRoute.onboarding, page: () => OnBoardingScreen()),
        GetPage(name: AppRoute.addtask, page: () => AddTaskScreen()),
      ],
    );
  }
}