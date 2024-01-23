import 'package:flutter/material.dart';
import 'package:hotel_app/core/app_export.dart';
import 'package:hotel_app/widgets/app_bar/appbar_leading_image.dart';
import 'package:hotel_app/widgets/app_bar/appbar_title.dart';
import 'package:hotel_app/widgets/app_bar/custom_app_bar.dart';
import 'package:hotel_app/widgets/custom_elevated_button.dart';
import '../forgot_password_screen/widgets/forgotpassword_item_widget.dart';

class ForgotPasswordScreen extends StatelessWidget {
 const ForgotPasswordScreen({Key? key}) : super(key: key);

 @override
 Widget build(BuildContext context) {
  MediaQueryData mediaQueryData = MediaQuery.of(context);

  return SafeArea(
   child: Scaffold(
    appBar: _buildAppBar(context),
    body: Container(
     width: double.maxFinite,
     padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 39.v),
     child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       SizedBox(height: 16.v),
       CustomImageView(
        imagePath: ImageConstant.imgImage,
        height: 240.adaptSize,
        width: 240.adaptSize,
        alignment: Alignment.center,
       ),
       SizedBox(height: 41.v),
       Container(
        width: 355.h,
        margin: EdgeInsets.only(right: 24.h),
        child: Text(
         "Select which contact details should we use to reset your password",
         maxLines: 2,
         overflow: TextOverflow.ellipsis,
         style: theme.textTheme.bodyLarge!.copyWith(height: 1.50),
        ),
       ),
       SizedBox(height: 18.v),
       _buildForgotPassword(context),
      ],
     ),
    ),
    bottomNavigationBar: _buildContinueButton(context),
   ),
  );
 }

 /// Section Widget
 PreferredSizeWidget _buildAppBar(BuildContext context) {
  return CustomAppBar(
   leadingWidth: 52.h,
   leading: AppbarLeadingImage(
    imagePath: ImageConstant.imgArrowLeft,
    margin: EdgeInsets.only(left: 24.h, top: 11.v, bottom: 16.v),
    onTap: () {
     onTapArrowLeft(context);
    },
   ),
   title: AppbarTitle(
    text: "Forgot Password",
    margin: EdgeInsets.only(left: 16.h),
   ),
  );
 }

 /// Section Widget
 Widget _buildForgotPassword(BuildContext context) {
  return ListView.separated(
   physics: NeverScrollableScrollPhysics(),
   shrinkWrap: true,
   separatorBuilder: (context, index) {
    return SizedBox(height: 24.v);
   },
   itemCount: 2,
   itemBuilder: (context, index) {
    return ForgotpasswordItemWidget();
   },
  );
 }

 /// Section Widget
 Widget _buildContinueButton(BuildContext context) {
  return CustomElevatedButton(
   text: "Continue",
   margin: EdgeInsets.only(left: 24.h, right: 24.h, bottom: 49.v),
   onPressed: () {
    onTapContinueButton(context);
   },
  );
 }

 /// Navigates back to the previous screen.
 onTapArrowLeft(BuildContext context) {
  Navigator.pop(context);
 }

 /// Navigates to the forgotPasswordTypeOtpScreen when the action is triggered.
 onTapContinueButton(BuildContext context) {
  Navigator.pushNamed(context, AppRoutes.forgotPasswordTypeOtpScreen);
 }
}