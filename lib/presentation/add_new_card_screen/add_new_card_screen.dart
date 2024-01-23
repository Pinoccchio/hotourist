import 'package:flutter/material.dart';
import 'package:hotel_app/core/app_export.dart';
import 'package:hotel_app/widgets/app_bar/appbar_leading_image.dart';
import 'package:hotel_app/widgets/app_bar/appbar_title.dart';
import 'package:hotel_app/widgets/app_bar/custom_app_bar.dart';
import 'package:hotel_app/widgets/custom_elevated_button.dart';
import 'package:hotel_app/widgets/custom_text_form_field.dart';


// ignore_for_file: must_be_immutable
class AddNewCardScreen extends StatelessWidget {
 AddNewCardScreen({Key? key}) : super(key: key);

 TextEditingController nameEditTextController = TextEditingController();
 TextEditingController numberEditTextController = TextEditingController();
 TextEditingController expiryDateEditTextController = TextEditingController();
 TextEditingController cvvEditTextController = TextEditingController();

 @override
 Widget build(BuildContext context) {
  MediaQueryData mediaQueryData = MediaQuery.of(context);

  return SafeArea(
   child: Scaffold(
    resizeToAvoidBottomInset: false,
    appBar: _buildAppBar(context),
    body: Container(
     width: double.maxFinite,
     padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 27.v),
     child: Column(
      children: [
       CustomImageView(
        imagePath: ImageConstant.imgCard1,
        height: 240.v,
        width: 380.h,
       ),
       SizedBox(height: 28.v),
       _buildNameEditText(context),
       SizedBox(height: 28.v),
       _buildNumberEditText(context),
       SizedBox(height: 28.v),
       _buildExpiryAndCvvNumberRow(context),
       SizedBox(height: 5.v),
      ],
     ),
    ),
    bottomNavigationBar: _buildAddNewCardButton(context),
   ),
  );
 }

 /// Section Widget
 PreferredSizeWidget _buildAppBar(BuildContext context) {
  return CustomAppBar(
   height: 52.v,
   leadingWidth: 52.h,
   leading: AppbarLeadingImage(
    imagePath: ImageConstant.imgArrowLeft,
    margin: EdgeInsets.only(left: 24.h, top: 11.v, bottom: 13.v),
    onTap: () {
     onTapArrowLeft(context);
    },
   ),
   title: AppbarTitle(
    text: "Add New Card",
    margin: EdgeInsets.only(left: 16.h),
   ),
  );
 }

 /// Section Widget
 Widget _buildNameEditText(BuildContext context) {
  return CustomTextFormField(
   controller: nameEditTextController,
   hintText: "Daniel Austin",
  );
 }

 /// Section Widget
 Widget _buildNumberEditText(BuildContext context) {
  return CustomTextFormField(
   controller: numberEditTextController,
   hintText: "6373 2728 4797 4679",
  );
 }

 /// Section Widget
 Widget _buildExpiryDateEditText(BuildContext context) {
  return Expanded(
   child: Padding(
    padding: EdgeInsets.only(right: 8.h),
    child: CustomTextFormField(
     controller: expiryDateEditTextController,
     hintText: "02/30",
    ),
   ),
  );
 }

 /// Section Widget
 Widget _buildCvvEditText(BuildContext context) {
  return Expanded(
   child: Padding(
    padding: EdgeInsets.only(left: 8.h),
    child: CustomTextFormField(
     controller: cvvEditTextController,
     hintText: "190",
     textInputAction: TextInputAction.done,
    ),
   ),
  );
 }

 /// Section Widget
 Widget _buildExpiryAndCvvNumberRow(BuildContext context) {
  return Row(
   mainAxisAlignment: MainAxisAlignment.center,
   children: [
    _buildExpiryDateEditText(context),
    _buildCvvEditText(context),
   ],
  );
 }

 /// Section Widget
 Widget _buildAddNewCardButton(BuildContext context) {
  return CustomElevatedButton(
   text: "Add New Card",
   margin: EdgeInsets.only(left: 24.h, right: 24.h, bottom: 49.v),
  );
 }

 /// Navigates back to the previous screen.
 onTapArrowLeft(BuildContext context) {
  Navigator.pop(context);
 }
}

