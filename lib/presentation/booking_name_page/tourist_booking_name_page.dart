import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotel_app/core/app_export.dart';
import 'package:hotel_app/presentation/booking_ongoing_tab_container_page/booking_ongoing_tab_container_page.dart';
import 'package:hotel_app/presentation/confirm_payment_screen/confirm_payment_screen.dart';
import 'package:hotel_app/presentation/confirm_payment_screen/tourist_confirm_payment_screen.dart';
import 'package:hotel_app/presentation/home_screen_page/hotel_class/touristSpot_list_model.dart';
import 'package:hotel_app/widgets/custom_elevated_button.dart';
import 'package:hotel_app/widgets/custom_text_form_field.dart';

import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../booking_ongoing_page/booking_info_model.dart';
import '../home_screen_page/hotel_class/hotel_list_model.dart';

class TouristBookingNamePage extends StatefulWidget {
  final TouristListData touristData;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int guessCount;
  final int totalPrice;

  const TouristBookingNamePage({
    Key? key,
    required this.checkInDate,
    required this.checkOutDate,
    required this.guessCount,
    required this.totalPrice,
    required this.touristData,
  }) : super(key: key);

  @override
  BookingNamePageState createState() => BookingNamePageState();
}

class BookingNamePageState extends State<TouristBookingNamePage>
    with AutomaticKeepAliveClientMixin<TouristBookingNamePage> {
  TextEditingController fullName = TextEditingController();
  TextEditingController nickName = TextEditingController();
  TextEditingController editTextDateController = TextEditingController();
  TextEditingController editTextEmailController = TextEditingController();
  TextEditingController editTextPhoneController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  bool get wantKeepAlive => true;

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
            decoration: AppDecoration.fillOnPrimary,
            child: Column(
              children: [
                SizedBox(height: 30.v),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.h),
                    child: Column(
                      children: [
                        _buildEditTextLabel1(context),
                        SizedBox(height: 24.v),
                        _buildEditTextLabel2(context),
                        SizedBox(height: 24.v),
                        _buildEditTextDate(context),
                        SizedBox(height: 24.v),
                        _buildEditTextEmail(context),
                        SizedBox(height: 24.v),
                        _buildEditTextPhone(context),
                        Spacer(),
                        _buildButtonContinue(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 48.v,
      leadingWidth: 52.h,
      leading: AppbarLeadingImage(
        imagePath: 'lib/images/img_arrow_down.svg',
        margin: EdgeInsets.only(
          left: 24.h,
          top: 10.v,
          bottom: 10.v,
        ),
        onTap: () {
          onTapArrowLeft(context);
        },
      ),
      title: AppbarTitle(
        text: "Name of Reservation",
        margin: EdgeInsets.only(left: 16.h),
      ),
    );
  }
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
  /// Section Widget
  Widget _buildEditTextLabel1(BuildContext context) {
    return CustomTextFormField(
      controller: fullName,
      hintText: "Write your full name",
    );
  }

  Widget _buildEditTextLabel2(BuildContext context) {
    return CustomTextFormField(
      controller: nickName,
      hintText: "Write your nickname",
    );
  }

  Widget _buildEditTextDate(BuildContext context) {
    String currentDate = "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
    editTextDateController.text = currentDate;

    return CustomTextFormField(
      controller: editTextDateController,
      readOnly: true, // Set it to true to make it non-editable
      suffix: GestureDetector(
        onTap: () {
          // Handle calendar click
          // You can open a date picker here
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(30.h, 19.v, 22.h, 19.v),
          child: CustomImageView(
            imagePath: ImageConstant.imgCalendar,
            height: 16.v,
            width: 15.h,
          ),
        ),
      ),
      suffixConstraints: BoxConstraints(maxHeight: 56.v),
      contentPadding: EdgeInsets.only(left: 20.h, top: 19.v, bottom: 19.v),
    );
  }

  Widget _buildEditTextEmail(BuildContext context) {
    return CustomTextFormField(
      controller: editTextEmailController,
      hintText: "user@domain.com",
      textInputType: TextInputType.emailAddress,
      suffix: Container(
        margin: EdgeInsets.fromLTRB(30.h, 20.v, 22.h, 20.v),
        child: CustomImageView(
          imagePath: ImageConstant.imgClockPrimary15x15,
          height: 15.adaptSize,
          width: 15.adaptSize,
        ),
      ),
      suffixConstraints: BoxConstraints(maxHeight: 56.v),
      contentPadding: EdgeInsets.only(left: 20.h, top: 19.v, bottom: 19.v),
    );
  }

  Widget _buildEditTextPhone(BuildContext context) {
    return CustomTextFormField(
      controller: editTextPhoneController,
      hintText: "+639",
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.phone,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      prefix: Container(
        margin: EdgeInsets.fromLTRB(20.h, 19.v, 12.h, 19.v),
        child: CustomImageView(
          imagePath: 'lib/images/philippines.png',
          height: 18.v,
          width: 28.h,
        ),
      ),
      prefixConstraints: BoxConstraints(maxHeight: 56.v),
      contentPadding: EdgeInsets.only(top: 19.v, right: 30.h, bottom: 19.v),
    );
  }

  /// Section Widget
  Widget _buildButtonContinue(BuildContext context) {
    return CustomElevatedButton(
      text: "Continue",
      onPressed: () {
        onTapButtonContinue(context);
      },
    );
  }

  /// Navigates to the choosePaymentMethodScreen when the action is triggered.
  void onTapButtonContinue(BuildContext context) {
    if (isAnyFieldEmpty()) {
      // Show a toast or snackbar indicating that fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields.'),
        ),
      );
    } else {
      // All fields are filled, proceed to save data to Firestore
      saveDataToFirestore();

    }
  }

  void saveDataToFirestore() async {
    // Navigate to the confirm payment screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TouristConfirmPaymentScreen(
          touristData: widget.touristData,
          fullName: fullName.text,
          nickName: nickName.text,
          checkInDate: widget.checkInDate,
          checkOutDate: widget.checkOutDate,
          guestCount: widget.guessCount,
          totalPrice: widget.totalPrice,
          email: editTextEmailController.text,
          phone: editTextPhoneController.text,
        ),
      ),
    );
  }
  bool isAnyFieldEmpty() {
    return fullName.text.isEmpty ||
        nickName.text.isEmpty ||
        editTextDateController.text.isEmpty ||
        editTextEmailController.text.isEmpty ||
        editTextPhoneController.text.isEmpty;
  }
}
