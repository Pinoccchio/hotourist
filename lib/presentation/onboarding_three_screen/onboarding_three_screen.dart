import 'package:flutter/material.dart';
import 'package:hotel_app/core/app_export.dart';
import 'package:hotel_app/presentation/home_screen_page/tab_list/trending_home_screen.dart';
import 'package:hotel_app/presentation/home_screen_tab_container_page/home_screen_tab_container_page.dart';
import 'package:hotel_app/presentation/sign_in_screen/sign_in_screen.dart';
import 'package:hotel_app/widgets/custom_elevated_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../services/auth_service.dart';
import '../home_screen_container_screen/home_screen_container_screen.dart';
import '../home_screen_container_screen/home_screen_container_screen.dart';

class OnboardingThreeScreen extends StatelessWidget {
 const OnboardingThreeScreen({Key? key}) : super(key: key);

 @override
 Widget build(BuildContext context) {
  mediaQueryData = MediaQuery.of(context);

  return SafeArea(
   child: Scaffold(
    body: SizedBox(
     width: double.maxFinite,
     child: Column(
      children: [
       CustomImageView(
        imagePath: ImageConstant.imgRectangle12,
        height: 420.v,
        width: 428.h,
       ),
       SizedBox(height: 38.v),
       _buildInfoSection(context),
       SizedBox(height: 99.v),
       SizedBox(
        height: 8.v,
        child: AnimatedSmoothIndicator(
         activeIndex: 2,
         count: 3,
         effect: ScrollingDotsEffect(
          spacing: 6,
          activeDotColor: theme.colorScheme.primary,
          dotColor: appTheme.gray700,
          dotHeight: 8.v,
          dotWidth: 8.h,
         ),
        ),
       ),
       SizedBox(height: 30.v),
       _buildSkipSection(context),
       SizedBox(height: 5.v),
      ],
     ),
    ),
   ),
  );
 }

 /// Section Widget
 Widget _buildInfoSection(BuildContext context) {
  return Container(
   padding: EdgeInsets.symmetric(horizontal: 43.h),
   child: Column(
    children: [
     SizedBox(
      width: 338.h,
      child: Text(
       "Let’s discover the world with us",
       textAlign: TextAlign.center,
       style: theme.textTheme.headlineLarge!.copyWith(height: 1.50),
      ),
     ),
     SizedBox(height: 5.v),
     Container(
      width: 341.h,
      margin: EdgeInsets.symmetric(horizontal: 12.h),
      child: Text(
       "Let the world unfold at your fingertips with our app - 'Let’s Discover the World with Us.' Immerse yourself in unique stays, craft cherished memories, and redefine your journey into the extraordinary. Your global adventure starts here.",
       textAlign: TextAlign.center,
       style: CustomTextStyles.bodyLarge18.copyWith(height: 1.50),
      ),
     ),
    ],
   ),
  );
 }

 /// Section Widget
 Widget _buildSkipSection(BuildContext context) {
  return Padding(
   padding: EdgeInsets.symmetric(horizontal: 24.h),
   child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
     CustomElevatedButton(
      width: 180.h,
      text: "Skip",
      buttonStyle: CustomButtonStyles.fillBlueGray,
      onPressed: () {
       onTapSkip(context);
      },
     ),
     CustomElevatedButton(
      width: 180.h,
      text: "Next",
      margin: EdgeInsets.only(left: 20.h),
      onPressed: () {
       onTapNext(context);
      },
     ),
    ],
   ),
  );
 }

 /// Navigates to the letSYouInScreen when the action is triggered.
 onTapSkip(BuildContext context) {
  Navigator.pushReplacementNamed(context, AppRoutes.signInScreen);
 }

 /// Navigates to the onboardingThreeScreen when the action is triggered.
 void onTapNext(BuildContext context) {
  Navigator.pushReplacementNamed(context, AppRoutes.signInScreen);
 }

}