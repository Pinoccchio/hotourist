import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_app/core/app_export.dart';
import 'package:hotel_app/widgets/app_bar/appbar_title.dart';
import 'package:hotel_app/widgets/app_bar/custom_app_bar.dart';
import 'package:hotel_app/widgets/custom_drop_down.dart';
import 'package:hotel_app/widgets/custom_elevated_button.dart';
import 'package:hotel_app/widgets/custom_text_form_field.dart';

class FillProfileScreen extends StatelessWidget {
 FillProfileScreen({Key? key}) : super(key: key);

 TextEditingController fullNameEditTextController = TextEditingController();
 TextEditingController nameEditTextController = TextEditingController();
 TextEditingController dateOfBirthEditTextController = TextEditingController();
 TextEditingController emailEditTextController = TextEditingController();
 TextEditingController phoneNumberEditTextController = TextEditingController();

 List<String> dropdownItemList = ["Male", "Female"];

 GlobalKey<FormState> _formKey = GlobalKey<FormState>();

 DateTime selectedDate = DateTime.now();

 Future<void> _selectDate(BuildContext context) async {
  final DateTime picked = (await showDatePicker(
   context: context,
   initialDate: selectedDate,
   firstDate: DateTime(1900),
   lastDate: DateTime.now(),
  ))!;

  if (picked != null && picked != selectedDate)
   dateOfBirthEditTextController.text =
   picked.toLocal().toString().split(' ')[0];
 }

 @override
 Widget build(BuildContext context) {
  mediaQueryData = MediaQuery.of(context);
  return SafeArea(
   child: Scaffold(
    resizeToAvoidBottomInset: false,
    appBar: _buildAppBar(context),
    body: Form(
     key: _formKey,
     child: Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 40.v),
      child: Column(
       children: [
        _buildFullNameEditText(context),
        SizedBox(height: 24.v),
        _buildNameEditText(context),
        SizedBox(height: 24.v),
        _buildDateOfBirthEditText(context),
        SizedBox(height: 24.v),
        _buildEmailEditText(context),
        SizedBox(height: 24.v),
        _buildPhoneNumberEditText(context),
        SizedBox(height: 24.v),
        _buildGenderDropDown(context),
        SizedBox(height: 5.v),
       ],
      ),
     ),
    ),
    bottomNavigationBar: _buildContinueButton(context),
   ),
  );
 }

 PreferredSizeWidget _buildAppBar(BuildContext context) {
  return CustomAppBar(
   height: 52.v,
   leadingWidth: 52.h,
   centerTitle: true,
   title: AppbarTitle(text: "Fill Your Profile"),
  );
 }

 Widget _buildFullNameEditText(BuildContext context) {
  return CustomTextFormField(
   controller: fullNameEditTextController,
   hintText: "Full Name",
  );
 }

 Widget _buildNameEditText(BuildContext context) {
  return CustomTextFormField(
   controller: nameEditTextController,
   hintText: "Nickname",
  );
 }

 Widget _buildDateOfBirthEditText(BuildContext context) {
  return GestureDetector(
   onTap: () => _selectDate(context),
   child: AbsorbPointer(
    child: CustomTextFormField(
     controller: dateOfBirthEditTextController,
     hintText: "Date of Birth",
     suffix: Container(
      margin: EdgeInsets.fromLTRB(30.h, 18.v, 20.h, 18.v),
      child: CustomImageView(
       imagePath: ImageConstant.imgIconlyCurvedCalendar,
       height: 20.adaptSize,
       width: 20.adaptSize,
      ),
     ),
     suffixConstraints: BoxConstraints(maxHeight: 56.v),
     contentPadding: EdgeInsets.only(left: 20.h, top: 19.v, bottom: 19.v),
    ),
   ),
  );
 }

 Widget _buildEmailEditText(BuildContext context) {
  return CustomTextFormField(
   controller: emailEditTextController,
   hintText: "Email",
   textInputType: TextInputType.emailAddress,
   suffix: Container(
    margin: EdgeInsets.fromLTRB(30.h, 20.v, 22.h, 20.v),
    child: CustomImageView(
     imagePath: ImageConstant.imgCheckmarkBlueGray100,
     height: 15.adaptSize,
     width: 15.adaptSize,
    ),
   ),
   suffixConstraints: BoxConstraints(maxHeight: 56.v),
   contentPadding: EdgeInsets.only(left: 20.h, top: 19.v, bottom: 19.v),
  );
 }

 Widget _buildPhoneNumberEditText(BuildContext context) {
  return CustomTextFormField(
   controller: phoneNumberEditTextController,
   hintText: "Phone Number",
   textInputAction: TextInputAction.done,
   textInputType: TextInputType.phone,
   prefix: Padding(
    padding: EdgeInsets.fromLTRB(20.h, 19.v, 30.h, 19.v),
    child: Row(
     mainAxisSize: MainAxisSize.min,
     children: [
      CustomImageView(
       imagePath: ImageConstant.imageNotFound,
       height: 18.v,
       width: 24.h,
       margin: EdgeInsets.fromLTRB(20.h, 19.v, 30.h, 19.v),
      ),
      CustomImageView(
       imagePath: ImageConstant.imageNotFound,
       height: 4.67.v,
       width: 9.33.h,
      ),
     ],
    ),
   ),
   prefixConstraints: BoxConstraints(maxHeight: 56.v),
   contentPadding: EdgeInsets.only(top: 19.v, right: 30.h, bottom: 19.v),
  );
 }
//UPDATE
 Widget _buildGenderDropDown(BuildContext context) {
  bool isAllFieldsFilled = !isAnyFieldEmpty();

  return Column(
   crossAxisAlignment: CrossAxisAlignment.start,
   children: [
    CustomDropDown(
     icon: Container(
      margin: EdgeInsets.fromLTRB(30.h, 18.v, 20.h, 18.v),
      child: CustomImageView(
       imagePath: ImageConstant.imgFavorite,
       height: 20.adaptSize,
       width: 20.adaptSize,
      ),
     ),
     hintText: "Gender",
     items: dropdownItemList,
     onChanged: isAllFieldsFilled ? (value) {} : null,
     backgroundColor: isAllFieldsFilled ? Color(0xFF181A20) : Colors.red,
     textColor: Colors.white,
    ),
    if (!isAllFieldsFilled)
     Padding(
      padding: EdgeInsets.only(top: 5),
      child: Text(
       'Make sure to fill all fields before proceeding to gender.',
       style: TextStyle(color: Colors.red),
      ),
     ),
   ],
  );
 }

 bool isAnyFieldEmpty() {
  return fullNameEditTextController.text.isEmpty ||
      nameEditTextController.text.isEmpty ||
      dateOfBirthEditTextController.text.isEmpty ||
      emailEditTextController.text.isEmpty ||
      phoneNumberEditTextController.text.isEmpty;
 }

 Widget _buildContinueButton(BuildContext context) {
  bool isAllFieldsFilled = !isAnyFieldEmpty();

  return CustomElevatedButton(
   text: "Continue",
   margin: EdgeInsets.only(left: 24.h, right: 24.h, bottom: 52.v),
   onPressed: () {
    // Check if all fields are filled before proceeding
    if (isAllFieldsFilled) {
     // All fields are filled, proceed to save data to Firestore
     saveUserProfile(context);
    } else {
     // Show a toast or snackbar indicating that fields are empty
     ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
       content: Text('Please fill in all fields.'),
      ),
     );
    }
   },
  );
 }

 void saveUserProfile(BuildContext context) async {
  // Get the current user
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
   // Create a reference to the user's document in Firestore
   CollectionReference users = FirebaseFirestore.instance
       .collection('HotelApp')
       .doc('Users')
       .collection('User_Profile');
   String userEmail = user.email ?? '';

   // Get the selected gender
   String selectedGender =
   dropdownItemList.isNotEmpty ? dropdownItemList[0] : '';

   // Save user information to Firestore
   await users.doc(userEmail).set({
    'fullName': fullNameEditTextController.text,
    'nickname': nameEditTextController.text,
    'dateOfBirth': dateOfBirthEditTextController.text,
    'email': emailEditTextController.text,
    'phoneNumber': phoneNumberEditTextController.text,
    'gender': selectedGender, // Store gender
   });

   // Optionally, you can also update the user's display name
   await user.updateDisplayName(fullNameEditTextController.text);

   // Navigate to HomePage
   Navigator.pushReplacementNamed(
       context, AppRoutes.homeScreenContainerScreen);
  }
 }
}