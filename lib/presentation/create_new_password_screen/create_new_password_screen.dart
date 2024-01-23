import 'package:flutter/material.dart';
import 'package:hotel_app/core/app_export.dart';
import 'package:hotel_app/widgets/app_bar/appbar_leading_image.dart';
import 'package:hotel_app/widgets/app_bar/appbar_title.dart';
import 'package:hotel_app/widgets/app_bar/custom_app_bar.dart';
import 'package:hotel_app/widgets/custom_checkbox_button.dart';
import 'package:hotel_app/widgets/custom_elevated_button.dart';
import 'package:hotel_app/widgets/custom_text_form_field.dart';
// ignore_for_file: must_be_immutable
class CreateNewPasswordScreen extends StatelessWidget {CreateNewPasswordScreen({Key? key}) : super(key: key);

TextEditingController newpasswordController = TextEditingController();

TextEditingController passwordController = TextEditingController();

bool rememberme = false;

GlobalKey<FormState> _formKey = GlobalKey<FormState>();

@override Widget build(BuildContext context) { mediaQueryData = MediaQuery.of(context); return SafeArea(child: Scaffold(resizeToAvoidBottomInset: false, appBar: _buildAppBar(context), body: Form(key: _formKey, child: Container(width: double.maxFinite, padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 56.v), child: Column(children: [SizedBox(height: 16.v), CustomImageView(imagePath: ImageConstant.imgImage300x300, height: 300.adaptSize, width: 300.adaptSize), SizedBox(height: 58.v), _buildForgotPassword(context)]))), bottomNavigationBar: _buildContinueButton(context))); } 
/// Section Widget
PreferredSizeWidget _buildAppBar(BuildContext context) { return CustomAppBar(leadingWidth: 52.h, leading: AppbarLeadingImage(imagePath: ImageConstant.imgArrowLeft, margin: EdgeInsets.only(left: 24.h, top: 11.v, bottom: 16.v), onTap: () {onTapArrowLeft(context);}), title: AppbarTitle(text: "Forgot Password", margin: EdgeInsets.only(left: 16.h))); } 
/// Section Widget
Widget _buildForgotPassword(BuildContext context) { return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Create Your New Password", style: theme.textTheme.bodyLarge), SizedBox(height: 23.v), CustomTextFormField(controller: newpasswordController, hintText: "*************", textInputType: TextInputType.visiblePassword, prefix: Container(margin: EdgeInsets.fromLTRB(20.h, 20.v, 12.h, 20.v), child: CustomImageView(imagePath: ImageConstant.imgLockWhiteA700, height: 20.adaptSize, width: 20.adaptSize)), prefixConstraints: BoxConstraints(maxHeight: 60.v), suffix: Container(margin: EdgeInsets.fromLTRB(30.h, 20.v, 20.h, 20.v), child: CustomImageView(imagePath: ImageConstant.imgDashboardWhiteA700, height: 20.adaptSize, width: 20.adaptSize)), suffixConstraints: BoxConstraints(maxHeight: 60.v), obscureText: true, contentPadding: EdgeInsets.symmetric(vertical: 21.v)), SizedBox(height: 24.v), CustomTextFormField(controller: passwordController, hintText: "*************", textInputAction: TextInputAction.done, textInputType: TextInputType.visiblePassword, prefix: Container(margin: EdgeInsets.fromLTRB(20.h, 20.v, 12.h, 20.v), child: CustomImageView(imagePath: ImageConstant.imgLockWhiteA700, height: 20.adaptSize, width: 20.adaptSize)), prefixConstraints: BoxConstraints(maxHeight: 60.v), suffix: Container(margin: EdgeInsets.fromLTRB(30.h, 20.v, 20.h, 20.v), child: CustomImageView(imagePath: ImageConstant.imgDashboardWhiteA700, height: 20.adaptSize, width: 20.adaptSize)), suffixConstraints: BoxConstraints(maxHeight: 60.v), obscureText: true, contentPadding: EdgeInsets.symmetric(vertical: 21.v)), SizedBox(height: 24.v), CustomCheckboxButton(text: "Remember me", value: rememberme, padding: EdgeInsets.symmetric(vertical: 3.v), onChange: (value) {rememberme = value;})]); } 
/// Section Widget
Widget _buildContinueButton(BuildContext context) { return CustomElevatedButton(text: "Continue", margin: EdgeInsets.only(left: 24.h, right: 24.h, bottom: 49.v)); } 

/// Navigates back to the previous screen.
onTapArrowLeft(BuildContext context) { Navigator.pop(context); } 
 }
