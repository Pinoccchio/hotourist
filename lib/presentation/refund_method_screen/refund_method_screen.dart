import 'package:flutter/material.dart';
import 'package:hotel_app/core/app_export.dart';
import 'package:hotel_app/widgets/app_bar/appbar_leading_image.dart';
import 'package:hotel_app/widgets/app_bar/appbar_title.dart';
import 'package:hotel_app/widgets/app_bar/custom_app_bar.dart';
import 'package:hotel_app/widgets/custom_elevated_button.dart';
import 'package:hotel_app/widgets/custom_radio_button.dart';
// ignore_for_file: must_be_immutable
class RefundMethodScreen extends StatelessWidget {RefundMethodScreen({Key? key}) : super(key: key);

String radioGroup = "";

@override Widget build(BuildContext context) { mediaQueryData = MediaQuery.of(context); return SafeArea(child: Scaffold(appBar: _buildAppBar(context), body: Container(width: double.maxFinite, padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 22.v), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [SizedBox(height: 4.v), Container(width: 357.h, margin: EdgeInsets.only(right: 22.h), child: Text("Please select a payment refund method (only 80% will be refunded).", maxLines: 2, overflow: TextOverflow.ellipsis, style: CustomTextStyles.bodyLarge18.copyWith(height: 1.50))), SizedBox(height: 22.v), _buildPaymentMethodsGoogle(context, userImage: ImageConstant.imgFrameLightBlue600, googlePayText: "Paypal"), SizedBox(height: 28.v), _buildPaymentMethodsGoogle(context, userImage: ImageConstant.imgFrame, googlePayText: "Google Pay"), SizedBox(height: 28.v), _buildPaymentMethodsGoogle(context, userImage: ImageConstant.imgFrameWhiteA70032x32, googlePayText: "Apple Pay"), SizedBox(height: 28.v), _buildPaymentMethodsDebitCredit(context), Spacer(), Align(alignment: Alignment.center, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text("Paid: 479.5", style: CustomTextStyles.bodyLarge18), Padding(padding: EdgeInsets.only(left: 16.h), child: Text("Refund: 383.8", style: theme.textTheme.titleMedium))]))])), bottomNavigationBar: _buildConfirmCancellation(context))); } 
/// Section Widget
PreferredSizeWidget _buildAppBar(BuildContext context) { return CustomAppBar(leadingWidth: 52.h, leading: AppbarLeadingImage(imagePath: ImageConstant.imgArrowLeft, margin: EdgeInsets.only(left: 24.h, top: 11.v, bottom: 16.v), onTap: () {onTapArrowLeft(context);}), title: AppbarTitle(text: "Cancel Hotel Booking", margin: EdgeInsets.only(left: 16.h))); } 
/// Section Widget
Widget _buildPaymentMethodsDebitCredit(BuildContext context) { return Container(width: 380.h, padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 26.v), decoration: AppDecoration.outlineBlack9000c.copyWith(borderRadius: BorderRadiusStyle.roundedBorder16), child: Padding(padding: EdgeInsets.only(right: 8.h), child: CustomRadioButton(width: 324.h, text: "•••• •••• •••• •••• 4679", value: "•••• •••• •••• •••• 4679", groupValue: radioGroup, padding: EdgeInsets.fromLTRB(12.h, 1.v, 30.h, 1.v), isRightCheck: true, onChange: (value) {radioGroup = value;}))); } 
/// Section Widget
Widget _buildConfirmCancellation(BuildContext context) { return CustomElevatedButton(text: "Confirm Cancellation", margin: EdgeInsets.only(left: 24.h, right: 24.h, bottom: 48.v)); } 
/// Common widget
Widget _buildPaymentMethodsGoogle(BuildContext context, {required String userImage, required String googlePayText, }) { return Container(padding: EdgeInsets.all(24.h), decoration: AppDecoration.outlineBlack9000c.copyWith(borderRadius: BorderRadiusStyle.roundedBorder16), child: Row(children: [CustomImageView(imagePath: userImage, height: 32.adaptSize, width: 32.adaptSize), Padding(padding: EdgeInsets.only(left: 12.h, top: 7.v, bottom: 2.v), child: Text(googlePayText, style: theme.textTheme.titleMedium!.copyWith(color: appTheme.whiteA700))), Spacer(), CustomImageView(imagePath: ImageConstant.imgContrast, height: 20.adaptSize, width: 20.adaptSize, margin: EdgeInsets.only(top: 6.v, right: 8.h, bottom: 6.v))])); } 

/// Navigates back to the previous screen.
onTapArrowLeft(BuildContext context) { Navigator.pop(context); } 
 }
