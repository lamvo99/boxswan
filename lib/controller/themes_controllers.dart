import 'package:box_swan/core/constant/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../core/db/Storage.dart';

class ThemeController extends GetxController{

  ThemeMode get theme => _loadTheme() ? ThemeMode.dark : ThemeMode.light;

  bool _loadTheme() => Storage.box.read(AppConstants.key) ?? false;

  void saveTheme(bool isDarkMode) => Storage.box.write(AppConstants.key, isDarkMode);
  
  void changeTheme(ThemeData theme) => Get.changeTheme(theme);


}