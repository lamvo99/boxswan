import 'app_images.dart';

class AppFunc {

  static String iconAsset ({required String iconAs}){
    print(iconAs);
    if(iconAs == 'en'){
      return AppImages.enIcon;
    }
    if(iconAs == 'vi'){
      return AppImages.viIcon;
    }
    if(iconAs == 'zh'){
      return AppImages.zhIcon;
    }
    return AppImages.enIcon;

  }
}
