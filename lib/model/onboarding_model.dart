
import 'package:box_swan/core/constant/app_images.dart';
import 'package:box_swan/core/language/trans_helper.dart';

class OnBoardingModel{
  String img;
  String title;
  String des;

  OnBoardingModel({
    required this.img,
    required this.des,
    required this.title
});
  static List<OnBoardingModel> generateItems() {
    return [
      OnBoardingModel(
        img: AppImages.onboar1 ,
        title: TransHelper.welcome,
        des: TransHelper.des1,
      ),
      OnBoardingModel(
        img: AppImages.onboard2,
        title: TransHelper.work,
        des: TransHelper.des2,
      ),
      OnBoardingModel(
        img: AppImages.onboard3,
        title: TransHelper.task,
        des: TransHelper.des3,
      ),
    ];
  }

}