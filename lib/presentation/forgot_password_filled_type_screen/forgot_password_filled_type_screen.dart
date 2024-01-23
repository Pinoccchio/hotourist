import 'package:flutter/material.dart';
import 'package:hotel_app/core/app_export.dart';
import 'package:hotel_app/widgets/app_bar/appbar_leading_image.dart';
import 'package:hotel_app/widgets/app_bar/appbar_title.dart';
import 'package:hotel_app/widgets/app_bar/custom_app_bar.dart';
import 'package:hotel_app/widgets/custom_elevated_button.dart';
import 'package:hotel_app/widgets/custom_pin_code_text_field.dart';

class ForgotPasswordFilledTypeScreen extends StatelessWidget {const ForgotPasswordFilledTypeScreen({Key? key}) : super(key: key);

@override Widget build(BuildContext context) { mediaQueryData = MediaQuery.of(context); return SafeArea(child: Scaffold(resizeToAvoidBottomInset: false, appBar: _buildAppBar(context), body: Container(width: double.maxFinite, padding: EdgeInsets.symmetric(horizontal: 34.h), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [SizedBox(height: 18.v), Text("Code has been send to +1 111 ******99", style: theme.textTheme.bodyLarge), SizedBox(height: 59.v), CustomPinCodeTextField(context: context, onChanged: (value) {}), SizedBox(height: 62.v), RichText(text: TextSpan(children: [TextSpan(text: "Resend code in ", style: theme.textTheme.bodyLarge), TextSpan(text: "53", style: CustomTextStyles.bodyLargePrimary), TextSpan(text: " s", style: theme.textTheme.bodyLarge)]), textAlign: TextAlign.left)])), bottomNavigationBar: _buildVerifyButton(context))); } 
/// Section Widget
PreferredSizeWidget _buildAppBar(BuildContext context) { return CustomAppBar(leadingWidth: 52.h, leading: AppbarLeadingImage(imagePath: ImageConstant.imgArrowLeft, margin: EdgeInsets.only(left: 24.h, top: 11.v, bottom: 16.v), onTap: () {onTapArrowLeft(context);}), title: AppbarTitle(text: "Forgot Password", margin: EdgeInsets.only(left: 16.h))); } 
/// Section Widget
Widget _buildVerifyButton(BuildContext context) { return CustomElevatedButton(text: "Verify", margin: EdgeInsets.only(left: 24.h, right: 24.h, bottom: 49.v)); } 

/// Navigates back to the previous screen.
onTapArrowLeft(BuildContext context) { Navigator.pop(context); } 
 }
