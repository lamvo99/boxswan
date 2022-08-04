import 'dart:convert';

import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

const KEY = "FIRST_TIME_OPEN";

class RatingAppServices {
  late SharedPreferences _prefs;
  final InAppReview _inAppReview = InAppReview.instance;

  Future<bool> isSeconTimeOpen() async {
    _prefs = await SharedPreferences.getInstance();
    try{
      dynamic isSecondTime = _prefs.getBool(KEY) as bool;
      if(isSecondTime != null && !isSecondTime){
        _prefs.setBool(KEY, false);
        return false;
      }else if(isSecondTime != null && isSecondTime){
        _prefs.setBool(KEY, false);
        return true;
      }else{
        _prefs.setBool(KEY, true);
        return false;
      }
    }catch (e) {
      return false;
    }
  }
  Future<bool> showRating() async {
    try {
      final available = await _inAppReview.isAvailable();
      if(available){
        _inAppReview.requestReview();
      }else {
        _inAppReview.openStoreListing(
          appStoreId: 'com.xingzhuang.box_swan'
        );
      }
      return true;
    }catch (e){
      return false;
    }
  }
}