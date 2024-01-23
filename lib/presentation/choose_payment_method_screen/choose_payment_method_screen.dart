import 'package:flutter/material.dart';
import 'package:hotel_app/core/app_export.dart';
import 'package:hotel_app/widgets/app_bar/appbar_title.dart';
import 'package:hotel_app/widgets/app_bar/custom_app_bar.dart';
import 'package:hotel_app/widgets/custom_elevated_button.dart';

class ChoosePaymentMethodScreen extends StatelessWidget {
 const ChoosePaymentMethodScreen({Key? key}) : super(key: key);

 @override
 Widget build(BuildContext context) {
  mediaQueryData = MediaQuery.of(context);

  return SafeArea(
   child: Scaffold(
    appBar: _buildAppBar(context),
    body: _buildBody(context),
    bottomNavigationBar: _buildContinue(context),
   ),
  );
 }

 PreferredSizeWidget _buildAppBar(BuildContext context) {
  return CustomAppBar(
   height: 56.v,
   leadingWidth: 52.h,
   leading: _buildLeading(context),
   title: _buildTitle(),
  );
 }

 Widget _buildLeading(BuildContext context) {
  return GestureDetector(
   onTap: () => onTapImgArrowLeft(context),
   child: Container(
    height: 28.adaptSize,
    width: 28.adaptSize,
    margin: EdgeInsets.only(left: 24.h, top: 10.v, bottom: 17.v),
    child: Stack(
     alignment: Alignment.topCenter,
     children: [
      CustomImageView(
       imagePath: ImageConstant.imgArrowLeft,
       height: 28.adaptSize,
       width: 28.adaptSize,
       alignment: Alignment.topLeft,
      ),
      CustomImageView(
       imagePath: ImageConstant.imgArrowLeft,
       height: 28.adaptSize,
       width: 28.adaptSize,
       alignment: Alignment.topCenter,
      ),
     ],
    ),
   ),
  );
 }

 Widget _buildTitle() {
  return Container(
   height: 29.v,
   width: 96.h,
   margin: EdgeInsets.only(left: 16.h),
   child: Stack(
    alignment: Alignment.bottomCenter,
    children: [
     AppbarTitle(text: "Payment"),
     AppbarTitle(text: "Payment"),
    ],
   ),
  );
 }

 Widget _buildBody(BuildContext context) {
  return Container(
   width: double.maxFinite,
   padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 28.v),
   child: Column(
    children: [
     SizedBox(height: 28.v),
     _buildPaymentMethodsGcash(
      context,
      userImage: 'lib/images/gcash.png',
      googlePayText: "Gcash",
     ),
     SizedBox(height: 28.v),
     SizedBox(height: 5.v),
    ],
   ),
  );
 }

 Widget _buildContinue(BuildContext context) {
  return CustomElevatedButton(
   text: "Continue",
   margin: EdgeInsets.only(left: 24.h, right: 24.h, bottom: 49.v),
   onPressed: () => onTapContinue(context),
  );
 }

 Widget _buildPaymentMethodsGcash(BuildContext context,
     {required String userImage, required String googlePayText}) {
  return Container(
   padding: EdgeInsets.all(24.h),
   decoration: AppDecoration.outlineBlack9000c.copyWith(
    borderRadius: BorderRadiusStyle.roundedBorder16,
   ),
   child: Row(
    children: [
     CustomImageView(
      imagePath: userImage,
      height: 32.adaptSize,
      width: 32.adaptSize,
     ),
     Padding(
      padding: EdgeInsets.only(left: 12.h, top: 7.v, bottom: 2.v),
      child: Text(
       googlePayText,
       style: theme.textTheme.titleMedium!.copyWith(
        color: appTheme.whiteA700,
       ),
      ),
     ),
     Spacer(),
     CustomImageView(
      imagePath: ImageConstant.imgContrast,
      height: 20.adaptSize,
      width: 20.adaptSize,
      margin: EdgeInsets.only(top: 6.v, right: 8.h, bottom: 6.v),
     ),
    ],
   ),
  );
 }

 void onTapImgArrowLeft(BuildContext context) {
  Navigator.pop(context);
 }

 void onTapTxtAddNewCard(BuildContext context) {
  Navigator.pushNamed(context, AppRoutes.addNewCardScreen);
 }

 void onTapContinue(BuildContext context) {
  Navigator.pushNamed(context, AppRoutes.confirmPaymentScreen);
 }
}

