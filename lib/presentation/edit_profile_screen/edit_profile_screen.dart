import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotel_app/core/app_export.dart';
import 'package:hotel_app/widgets/app_bar/appbar_leading_image.dart';
import 'package:hotel_app/widgets/app_bar/appbar_title.dart';
import 'package:hotel_app/widgets/app_bar/custom_app_bar.dart';
import 'package:hotel_app/widgets/custom_drop_down.dart';
import 'package:hotel_app/widgets/custom_elevated_button.dart';
import 'package:hotel_app/widgets/custom_text_form_field.dart';
import '../../services/notif_service.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController fullNameEditTextController = TextEditingController();
  TextEditingController nameEditTextController = TextEditingController();
  TextEditingController dateOfBirthEditTextController = TextEditingController();
  TextEditingController emailEditTextController = TextEditingController();
  TextEditingController phoneNumberEditTextController = TextEditingController();

  List<String> dropdownItemList = ["Male", "Female"];
  Color dropdownItemColor = Color(0xFF24272F);

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
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          appBar: _buildAppBar(context),
          body: SingleChildScrollView(
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
                  SizedBox(height: 30.v),
                  _buildContinueButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

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
      centerTitle: true,
      title: AppbarTitle(text: "Edit Profile"),
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

  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  void saveUserProfile(BuildContext context) async {

    NotificationService().simpleNotificationShow(
      title: 'Update Profile Successful',
      body: 'Your profile has been successfully updated. Thank you!',
    );

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      CollectionReference users = FirebaseFirestore.instance
          .collection('HotelApp')
          .doc('Users')
          .collection('User_Profile');
      String userEmail = user.email ?? '';

      String selectedGender =
      dropdownItemList.isNotEmpty ? dropdownItemList[0] : '';

      await users.doc(userEmail).set({
        'fullName': fullNameEditTextController.text,
        'nickname': nameEditTextController.text,
        'dateOfBirth': dateOfBirthEditTextController.text,
        'email': emailEditTextController.text,
        'phoneNumber': phoneNumberEditTextController.text,
        'gender': selectedGender,
      });

      await user.updateDisplayName(fullNameEditTextController.text);

      SystemNavigator.pop();
    }
  }
}