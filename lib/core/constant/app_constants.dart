import 'package:box_swan/core/constant/app_colors.dart';
import 'package:box_swan/core/language/trans_helper.dart';
import 'package:box_swan/model/show_case_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

List<GlobalKey> homeKeyList = [
  ShowKey.keyOne,
  ShowKey.keyTwo,
  ShowKey.keyThree,
  ShowKey.keyFour,
  ShowKey.keyFive,
  ShowKey.keySix,
  ShowKey.keySeven,
  ShowKey.keyEight,
];

class AppConstants {
  static const chanel = 'com.xingzhuang.box_swan';

  static const chaneName = 'Lam Vo';

  static const chanelDes = 'BoxSwan for you';

  static const openSanFont = "OpenSans";

  static const robotoFont = "Roboto";

  static const key = 'isDarkMode';

  static const en = 'en';

  static const vi = 'vi';

  static const zh = 'zh';

  static double width = 414.w;
  static double height = 896.h;

  static List<int> remindList = [
    5,
    10,
    15,
    20,
  ];

  static List<String> repeatList = [
    'None',
    'Daily',
    'Weekly',
    'Monthly',
  ];
}

numberFormatCurrency(number, localee) {
  return NumberFormat.currency(locale: localee, decimalDigits: 1).format(int.parse(number));
}
