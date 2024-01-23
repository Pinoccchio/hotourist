import 'package:flutter/material.dart';
import 'package:hotel_app/core/app_export.dart';
import 'package:hotel_app/widgets/custom_elevated_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../services/auth_service.dart';
import '../home_screen_container_screen/home_screen_container_screen.dart';
import '../home_screen_tab_container_page/home_screen_tab_container_page.dart';
import '../sign_in_screen/sign_in_screen.dart';

class OnboardingTwoScreen extends StatelessWidget {
 const OnboardingTwoScreen({Key? key}) : super(key: key);

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
        imagePath: ImageConstant.imgRectangle11,
        height: 420.v,
        width: 428.h,
       ),
       SizedBox(height: 37.v),
       _buildInfoSection(context),
       SizedBox(height: 99.v),
       SizedBox(
        height: 8.v,
        child: AnimatedSmoothIndicator(
         activeIndex: 1,
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
     Container(
      width: 327.h,
      margin: EdgeInsets.only(left: 7.h, right: 5.h),
      child: Text(
       "Find the best hotels for your vacation",
       textAlign: TextAlign.center,
       style: theme.textTheme.headlineLarge!.copyWith(height: 1.50),
      ),
     ),
     SizedBox(height: 6.v),
     Container(
      width: 341.h,
      margin: EdgeInsets.symmetric(horizontal: 12.h),
      child: Text(
       "Embark on a Journey of Ultimate Comfort: Discover, Choose, and Experience the Finest Hotels Tailored for Your Dream Vacation. Find the best hotels effortlessly with our dedicated app, ensuring every stay is a memorable experience.",
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
 onTapNext(BuildContext context) {
  Navigator.pushNamed(context, AppRoutes.onboardingThreeScreen);
 }
}