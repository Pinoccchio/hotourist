import 'package:flutter/material.dart';
import 'package:hotel_app/core/app_export.dart';
import 'package:hotel_app/widgets/app_bar/appbar_leading_image.dart';
import 'package:hotel_app/widgets/app_bar/appbar_title.dart';
import 'package:hotel_app/widgets/app_bar/appbar_trailing_image.dart';
import 'package:hotel_app/widgets/app_bar/custom_app_bar.dart';
import 'package:hotel_app/widgets/custom_elevated_button.dart';
import 'package:hotel_app/widgets/custom_radio_button.dart';
// ignore_for_file: must_be_immutable
class CardAddedScreen extends StatelessWidget {CardAddedScreen({Key? key}) : super(key: key);

String radioGroup = "";

@override Widget build(BuildContext context) { mediaQueryData = MediaQuery.of(context); return SafeArea(child: Scaffold(appBar: _buildAppBar(context), body: Container(width: double.maxFinite, padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 28.v), child: Column(children: [_buildPaymentMethods(context), SizedBox(height: 34.v), _buildPayWithDebitCredit(context), SizedBox(height: 5.v)])), bottomNavigationBar: _buildContinue(context))); } 
/// Section Widget
PreferredSizeWidget _buildAppBar(BuildContext context) { return CustomAppBar(height: 56.v, leadingWidth: 52.h, leading: AppbarLeadingImage(imagePath: ImageConstant.imgArrowLeft, margin: EdgeInsets.only(left: 24.h, top: 10.v, bottom: 17.v), onTap: () {onTapArrowLeft(context);}), title: AppbarTitle(text: "Payment", margin: EdgeInsets.only(left: 16.h)), actions: [AppbarTrailingImage(imagePath: ImageConstant.imgQrcode, margin: EdgeInsets.fromLTRB(24.h, 10.v, 24.h, 17.v))]); } 
/// Section Widget
Widget _buildPaymentMethods(BuildContext context) { return Column(children: [Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Payment Methods", style: theme.textTheme.titleMedium), Padding(padding: EdgeInsets.only(bottom: 2.v), child: Text("Add New Card", style: CustomTextStyles.titleMediumPrimary16))]), SizedBox(height: 23.v), _buildPaymentMethodsGoogle(context, userImage: ImageConstant.imgFrameLightBlue600, googlePayText: "Paypal"), SizedBox(height: 28.v), _buildPaymentMethodsGoogle(context, userImage: ImageConstant.imgFrame, googlePayText: "Google Pay"), SizedBox(height: 28.v), _buildPaymentMethodsGoogle(context, userImage: ImageConstant.imgFrameWhiteA70032x32, googlePayText: "Apple Pay")]); } 
/// Section Widget
Widget _buildPayWithDebitCredit(BuildContext context) { return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Pay with Debit/Credit Card", style: theme.textTheme.titleMedium), SizedBox(height: 23.v), Container(width: 380.h, padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 26.v), decoration: AppDecoration.outlineBlack9000c.copyWith(borderRadius: BorderRadiusStyle.roundedBorder16), child: Padding(padding: EdgeInsets.only(right: 8.h), child: CustomRadioButton(width: 324.h, text: "•••• •••• •••• •••• 4679", value: "•••• •••• •••• •••• 4679", groupValue: radioGroup, padding: EdgeInsets.fromLTRB(12.h, 1.v, 30.h, 1.v), isRightCheck: true, onChange: (value) {radioGroup = value;})))]); } 
/// Section Widget
Widget _buildContinue(BuildContext context) { return CustomElevatedButton(text: "Continue", margin: EdgeInsets.only(left: 24.h, right: 24.h, bottom: 49.v), onPressed: () {onTapContinue(context);}); } 
/// Common widget
Widget _buildPaymentMethodsGoogle(BuildContext context, {required String userImage, required String googlePayText, }) { return Container(padding: EdgeInsets.all(24.h), decoration: AppDecoration.outlineBlack9000c.copyWith(borderRadius: BorderRadiusStyle.roundedBorder16), child: Row(children: [CustomImageView(imagePath: userImage, height: 32.adaptSize, width: 32.adaptSize), Padding(padding: EdgeInsets.only(left: 12.h, top: 7.v, bottom: 2.v), child: Text(googlePayText, style: theme.textTheme.titleMedium!.copyWith(color: appTheme.whiteA700))), Spacer(), CustomImageView(imagePath: ImageConstant.imgContrast, height: 20.adaptSize, width: 20.adaptSize, margin: EdgeInsets.only(top: 6.v, right: 8.h, bottom: 6.v))])); } 

/// Navigates back to the previous screen.
onTapArrowLeft(BuildContext context) { Navigator.pop(context); } 
/// Navigates to the confirmPaymentScreen when the action is triggered.
onTapContinue(BuildContext context) { Navigator.pushNamed(context, AppRoutes.confirmPaymentScreen); } 
 }
