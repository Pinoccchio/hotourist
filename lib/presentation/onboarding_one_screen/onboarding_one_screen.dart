import 'package:flutter/material.dart';
import 'package:hotel_app/core/app_export.dart';
import 'package:hotel_app/widgets/custom_elevated_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../services/auth_service.dart';
import '../home_screen_container_screen/home_screen_container_screen.dart';
import '../sign_in_screen/sign_in_screen.dart';

class OnboardingOneScreen extends StatelessWidget {
 const OnboardingOneScreen({Key? key}) : super(key: key);

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
        imagePath: ImageConstant.imgRectangle1420x428,
        height: 420.v,
        width: 428.h,
       ),
       SizedBox(height: 37.v),
       _buildInfoSection(context),
       SizedBox(height: 98.v),
       SizedBox(
        height: 8.v,
        child: AnimatedSmoothIndicator(
         activeIndex: 0,
         count: 3,
         effect: ScrollingDotsEffect(
          spacing: 6,
          activeDotColor: theme.colorScheme.primary,
          dotColor: appTheme.blueGray900,
          dotHeight: 8.v,
          dotWidth: 8.h,
         ),
        ),
       ),
       SizedBox(height: 32.v),
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
      width: 307.h,
      margin: EdgeInsets.only(left: 16.h, right: 17.h),
      child: Text(
       "Travel safely, comfortably, & easily",
       textAlign: TextAlign.center,
       style: theme.textTheme.headlineLarge!.copyWith(height: 1.50),
      ),
     ),
     SizedBox(height: 6.v),
     Container(
      width: 341.h,
      margin: EdgeInsets.symmetric(horizontal: 12.h),
      child: Text(
       "Your journey begins with us. Navigate the world with peace of mind, surrounded by comfort and convenience. Experience safe and effortless travels, curated just for you.",
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

 /// Navigates to the SignInScreen or HomePage when the action is triggered.
 onTapSkip(BuildContext context) {
  Navigator.pushReplacementNamed(context, AppRoutes.signInScreen);
 }

 /// Navigates to the onboardingTwoScreen when the action is triggered.
 onTapNext(BuildContext context) {
  Navigator.pushNamed(context, AppRoutes.onboardingTwoScreen);
 }
}