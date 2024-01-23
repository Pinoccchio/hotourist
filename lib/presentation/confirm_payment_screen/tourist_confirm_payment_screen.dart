import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hotel_app/core/app_export.dart';
import 'package:hotel_app/presentation/booking_ongoing_page/booking_ongoing_page.dart';
import 'package:hotel_app/presentation/booking_ongoing_tab_container_page/booking_ongoing_tab_container_page.dart';
import 'package:hotel_app/presentation/home_screen_page/hotel_class/hotel_list_model.dart';
import 'package:hotel_app/presentation/home_screen_page/hotel_class/touristSpot_list_model.dart';
import 'package:hotel_app/presentation/home_screen_tab_container_page/home_screen_tab_container_page.dart';
import 'package:hotel_app/presentation/view_ticket_screen/view_ticket_screen.dart';
import 'package:hotel_app/widgets/app_bar/appbar_leading_image.dart';
import 'package:hotel_app/widgets/app_bar/appbar_title.dart';
import 'package:hotel_app/widgets/app_bar/appbar_trailing_image.dart';
import 'package:hotel_app/widgets/app_bar/custom_app_bar.dart';
import 'package:hotel_app/widgets/custom_elevated_button.dart';
import 'package:intl/intl.dart';

import '../../services/notif_service.dart';

class TouristConfirmPaymentScreen extends StatelessWidget {
  final TouristListData touristData;
  final String fullName;
  final String nickName;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int guestCount;
  final int totalPrice;
  final String email;
  final String phone;
  final String? bookingId;

  const TouristConfirmPaymentScreen({
    Key? key,
    required this.fullName,
    required this.nickName,
    required this.checkInDate,
    required this.checkOutDate,
    required this.guestCount,
    required this.totalPrice,
    required this.email,
    required this.phone,
    required this.touristData,
    this.bookingId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(context),
        bottomNavigationBar: _buildConfirmPayment(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 23.v),
      child: Column(
        children: [
          _buildResortDetails(context),
          SizedBox(height: 28.v),
          _buildBookingDetails(context),
          SizedBox(height: 28.v),
          _buildPrice(context),
          SizedBox(height: 28.v),
          //_buildPaymentMethod(context),
          //SizedBox(height: 5.v),
        ],
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 56.v,
      leadingWidth: 52.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(left: 24.h, top: 10.v, bottom: 17.v),
        onTap: () {
          onTapArrowLeft(context);
        },
      ),
      title: AppbarTitle(
        text: "Payment",
        margin: EdgeInsets.only(left: 16.h),
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgQrcode,
          margin: EdgeInsets.fromLTRB(24.h, 10.v, 24.h, 17.v),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildResortDetails(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.h),
      decoration: AppDecoration.outlineBlackC.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: touristData.imagePath,
            height: 100.adaptSize,
            width: 100.adaptSize,
            radius: BorderRadius.circular(16.h),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.h, bottom: 9.v),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(touristData.titleTxt, style: theme.textTheme.titleLarge),
                SizedBox(height: 15.v),
                Text(touristData.subTxt, style: theme.textTheme.bodyMedium),
                SizedBox(height: 12.v),
                Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgStarYellowA700,
                      height: 12.adaptSize,
                      width: 12.adaptSize,
                      margin: EdgeInsets.symmetric(vertical: 2.v),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.h),
                      child: Text(
                        "${touristData.rating.toStringAsFixed(1)}", // Limit to 1 decimal place
                        style: theme.textTheme.titleSmall,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.h, top: 1.v),
                      child: Text(
                        "(${touristData.reviews} reviews)",
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(top: 9.v, bottom: 6.v),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("${touristData.perNight}", style: CustomTextStyles.headlineSmallPrimary),
                SizedBox(height: 2.v),
                Text("/ night", style: theme.textTheme.labelMedium),
                SizedBox(height: 16.v),
                CustomImageView(
                  imagePath: ImageConstant.imgBookmarkPrimary,
                  height: 24.adaptSize,
                  width: 24.adaptSize,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildBookingDetails(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 21.v),
      decoration: AppDecoration.fillBlueGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(height: 5.v),
          _buildAutoLayoutHorizontal(
            context,
            checkOutLabel: "Check in",
            monthText: "${DateFormat('MMMM dd, yyyy').format(checkInDate)}",
          ),
          SizedBox(height: 20.v),
          _buildAutoLayoutHorizontal(
            context,
            checkOutLabel: "Check out",
            monthText: "${DateFormat('MMMM dd, yyyy').format(checkOutDate)}",
          ),
          SizedBox(height: 19.v),
          _buildAutoLayoutHorizontal(
            context,
            checkOutLabel: "Guest",
            monthText: "$guestCount",
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildPrice(BuildContext context) {
    int nights = checkOutDate.difference(checkInDate).inDays;
    double totalPerNight = (touristData.perNight * nights).toDouble();
    double taxesAndFees = calculateTaxesAndFees(totalPerNight); // Implement your own calculation logic
    double totalPrice = totalPerNight + taxesAndFees;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 21.v),
      decoration: AppDecoration.fillBlueGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(height: 5.v),
          _buildAutoLayoutHorizontal(
            context,
            checkOutLabel: "$nights Nights",
            monthText: "${totalPerNight.toStringAsFixed(2)}",
          ),
          SizedBox(height: 20.v),
          _buildAutoLayoutHorizontal(
            context,
            checkOutLabel: "Taxes & Fees (10%)",
            monthText: "${taxesAndFees.toStringAsFixed(2)}",
          ),
          SizedBox(height: 17.v),
          Divider(),
          SizedBox(height: 21.v),
          _buildAutoLayoutHorizontal(
            context,
            checkOutLabel: "Total",
            monthText: "${totalPrice.toStringAsFixed(2)}",
          ),
        ],
      ),
    );
  }
  double calculateTaxesAndFees(double totalPerNight) {
    // Implement your own calculation logic for taxes and fees
    return totalPerNight * 0.10;
  }

  /// Section Widget
  Widget _buildPaymentMethod(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 26.v),
      decoration: AppDecoration.fillBlueGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgImage27x44,
            height: 27.v,
            width: 44.h,
            radius: BorderRadius.circular(4.h),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12.h, top: 2.v, bottom: 2.v),
            child: Text(
              "•••• •••• •••• •••• 4679",
              style: theme.textTheme.titleMedium,
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              onTapTxtChange(context);
            },
            child: Padding(
              padding: EdgeInsets.only(top: 5.v),
              child: Text(
                "Change",
                style: CustomTextStyles.titleMediumPrimarySemiBold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void saveDataToFirestore(BuildContext context) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String userUid = FirebaseAuth.instance.currentUser?.uid ?? '';

    CollectionReference ongoingBookingsCollection =
    firestore.collection('users').doc(userUid).collection('OngoingBookings');

    DocumentReference bookingDocRef = await ongoingBookingsCollection.add({
      'title': touristData.titleTxt,
      'location': touristData.subTxt,
      'image': touristData.imagePath,
      'fullName': fullName,
      'nickName': nickName,
      'checkInDate': checkInDate,
      'checkOutDate': checkOutDate,
      'guestCount': guestCount,
      'totalPrice': totalPrice,
      'email': email,
      'phone': phone,
      'completedTimestamp': null,
    });
    print("Data added to Firestore with ID: ${bookingDocRef.id}");

    String bookingId = bookingDocRef.id;

    Timestamp currentTimestamp = Timestamp.now();
    await bookingDocRef.update({'completedTimestamp': currentTimestamp});
  }

  /// Section Widget
  Widget _buildConfirmPayment(BuildContext context) {
    print("Clicked!");
    return CustomElevatedButton(
      text: "Confirm Payment",
      margin: EdgeInsets.only(left: 24.h, right: 24.h, bottom: 49.v),
      onPressed: () {
        saveDataToFirestore(context);
        /*
    Fluttertoast.showToast(
     msg: 'QR Code Generated! Make sure to take a screenshot of it.',
     toastLength: Toast.LENGTH_LONG,
     gravity: ToastGravity.BOTTOM,
     timeInSecForIosWeb: 1,
     backgroundColor: Color(0xFF1AADB6), // Set background color to #1AADB6
     textColor: Colors.white, // Set text color to white
     fontSize: 16.0,
    );


    Navigator.push(
     context,
     MaterialPageRoute(
      builder: (context) => ViewTicketScreen(
       fullName: fullName,
       nickName: nickName,
       checkInDate: checkInDate,
       checkOutDate: checkOutDate,
       guestCount: guestCount,
       totalPrice: totalPrice,
       email: email,
       phone: phone,
       hotelData: hotelData,
      ),
     ),
    );
    */
        Fluttertoast.showToast(
          msg: 'Book successfully! Go to booking to see the changes.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xFF1AADB6), // Set background color to #1AADB6
          textColor: Colors.white, // Set text color to white
          fontSize: 16.0,
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookingOngoingTabContainerPage(

            ),

          ),
        );

        NotificationService().simpleNotificationShow(
          title: 'Booking Successful',
          body: 'Thank you for booking ${touristData.titleTxt}! Enjoy your stay!',
        );

      },
    );
  }

  /// Common widget
  Widget _buildAutoLayoutHorizontal(BuildContext context,
      {required String checkOutLabel, required String monthText}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 1.v),
          child: Text(
            checkOutLabel,
            style: CustomTextStyles.titleMediumOnPrimaryContainer.copyWith(
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
        ),
        Text(
          monthText,
          style: theme.textTheme.titleMedium!.copyWith(
            color: appTheme.whiteA700,
          ),
        ),
      ],
    );
  }

  /// Navigates back to the previous screen.
  void onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the cardAddedScreen when the action is triggered.
  void onTapTxtChange(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.cardAddedScreen);
  }
}
