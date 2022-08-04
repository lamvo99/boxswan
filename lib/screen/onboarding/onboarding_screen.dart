import 'package:box_swan/core/constant/app_colors.dart';
import 'package:box_swan/core/constant/app_constants.dart';
import 'package:box_swan/core/constant/app_images.dart';
import 'package:box_swan/core/constant/app_routes.dart';
import 'package:box_swan/core/constant/app_themes.dart';
import 'package:box_swan/core/language/trans_helper.dart';
import 'package:box_swan/model/onboarding_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../widgets/get_to_button_widget.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentPage = 0;
  PageController _pageController = new PageController(
    initialPage: 0,
    keepPage: true,
  );
  List<OnBoardingModel> list = OnBoardingModel.generateItems();
  List<String> onBottom = [AppImages.path1,AppImages.path2,AppImages.path3];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body:Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 540.h,
                child: PageView(
                  controller: _pageController,
                  children: List.generate(list.length, (index) => _buildOnBoardPage(list[index])),
                  onPageChanged: (index) {
                    if(mounted)
                      setState(() {
                        currentPage = index;
                      });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) => _getIndicator(index)),
              )
            ],
          ),
          Positioned(
            right: 14.w,
            top: 14.h,
            child: InkWell(
              onTap: (){
                Get.toNamed(AppRoute.home);
              },
              child: Text(
                  TransHelper.skip,
                  style: textBlue18W600
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(top: 20.h),
              height: 300.h,
              width: AppConstants.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(onBottom[currentPage]),
                    fit: BoxFit.fill,
                  )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GetToButtonWidget(
                    onTap: (){
                      if(currentPage == 2){
                        Get.toNamed(AppRoute.home);
                      }else{
                        if(mounted)
                          setState(() {
                            currentPage = currentPage+1;
                          });
                      }
                    },
                    text: (currentPage == 2) ? TransHelper.getStarted : TransHelper.next,
                    colorButton: AppColors.alabaster,
                    isHighLight: false,
                    margin: EdgeInsets.symmetric(horizontal: 25.w),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getIndicator(int pageNo){
    return AnimatedContainer(
      duration: Duration(microseconds: 100),
      height: 10.h,
      width: (currentPage == pageNo) ? 20.w : 10.w,
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          color: (currentPage == pageNo) ? AppColors.darkJungleGreen : AppColors.darkHeaderClr
      ),
    );
  }

  Widget _buildOnBoardPage(OnBoardingModel onboardItem){
    return Column(
      mainAxisAlignment:  MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 20.h
        ),
        Container(
          height: 200.h,
          width: AppConstants.width,
          padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 50.h),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(onboardItem.img)
            )
          ),
        ),
        SizedBox(height:50.h),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Text(onboardItem.title, style: textDarkJungleGreen30W500),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          child: Text(onboardItem.des, style: textMercury16W400),
        ),
      ],
    );
  }

}

