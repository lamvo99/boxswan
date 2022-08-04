import 'dart:collection';
import 'vi_VN.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'en_US.dart';
import 'zh_CN.dart';

class LocalizationService extends Translations {

  static final locale = _getLocaleFromLanguage();
  static final fallbackLocale = Locale('en', 'US');
  static final langCodes = [
    'en',
    'vi',
    'zh'
  ];

  static final locales = [
    Locale('en', 'US'),
    Locale('vi', 'VN'),
    Locale('zh', 'CN'),
  ];

  static final langs = LinkedHashMap.from({
    'en': 'enIcon',
    'vi': 'viIcon',
    'zh': 'zhIcon'
  });

  static void changeLocale(String langCode) {
    final locale = _getLocaleFromLanguage(langCode: langCode);
    Get.updateLocale(locale!);
  }

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': en,
    'vi_VN': vi,
    'zh_CN': zh,
  };

  static Locale? _getLocaleFromLanguage({String? langCode}) {
    var lang = langCode ?? Get.deviceLocale!.languageCode;
    for (int i = 0; i < langCodes.length; i++) {
      if (lang == langCodes[i]) return locales[i];
    }
    return Get.locale;
  }
}
