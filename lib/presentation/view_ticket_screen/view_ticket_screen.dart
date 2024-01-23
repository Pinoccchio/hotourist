import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hotel_app/core/app_export.dart';
import 'package:screenshot/screenshot.dart';
import 'package:uuid/uuid.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:hotel_app/widgets/app_bar/appbar_leading_image.dart';
import 'package:hotel_app/widgets/app_bar/appbar_title.dart';
import 'package:hotel_app/widgets/app_bar/custom_app_bar.dart';
import 'package:hotel_app/widgets/custom_elevated_button.dart';
import '../booking_ongoing_page/booking_info_model.dart';
import '../home_screen_page/hotel_class/hotel_list_model.dart';

class ViewTicketScreen extends StatelessWidget {
 final BookingInfo booking;
 final ScreenshotController screenshotController =
 ScreenshotController(); // Define the controller here

 ViewTicketScreen({
  Key? key,
  required this.booking,
 }) : super(key: key);

 @override
 Widget build(BuildContext context) {
  return SafeArea(
   child: Scaffold(
    appBar: _buildAppBar(context),
    body: SingleChildScrollView(
     child: SizedBox(
      width: double.maxFinite,
      child: Screenshot(
       controller: screenshotController,
       child: Column(
        children: [
         SizedBox(height: 52.v),
         Container(
          margin: EdgeInsets.symmetric(horizontal: 24.h),
          padding: EdgeInsets.symmetric(horizontal: 22.h, vertical: 34.v),
          decoration: BoxDecoration(
           image: DecorationImage(
            image: fs.Svg(ImageConstant.imgGroupBlueGray900),
            fit: BoxFit.cover,
           ),
          ),
          child: Column(
           children: [
            Text(booking.title, style: theme.textTheme.titleMedium),
            SizedBox(height: 11.v),
            Container(
             margin: EdgeInsets.symmetric(horizontal: 40.h),
             padding: EdgeInsets.all(16.h),
             decoration: AppDecoration.fillBlueGray,
             child: QrImageView(
              data: _generateQRData().toString(),
              version: QrVersions.auto,
              size: 200.0,
             ),
            ),
            SizedBox(height: 18.v),
            Divider(color: appTheme.gray700),
            SizedBox(height: 53.v),
            _buildTicketDetails(context),
           ],
          ),
         ),
        ],
       ),
      ),
     ),
    ),
    bottomNavigationBar: _buildDownloadTicket(context),
   ),
  );
 }

 List<Object> _generateQRData() {
  // Generate a unique Booking ID using the uuid package
  String bookingId = Uuid().v4();

  // Create a list to hold the QR code data
  List<Object> qrDataList = [
   "BookingID: $bookingId",
   "Name: ${booking.fullName}",
   "CheckIn: ${_formatDate(booking.checkInDate)}",
   "CheckOut: ${_formatDate(booking.checkOutDate)}",
   "Title: ${booking.title}", // Use the selected hotelName
   "Guest: ${booking.guestCount}",
  ];

  return qrDataList;
 }

 String _formatDate(DateTime date) {
  return "${date.day}/${date.month}/${date.year}";
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
   title: AppbarTitle(text: "Ticket", margin: EdgeInsets.only(left: 16.h)),
  );
 }

 Widget _buildTicketDetails(BuildContext context) {
  // Access properties from the 'booking' object
  return Container(
   padding: EdgeInsets.symmetric(horizontal: 9.h),
   child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
     Padding(
      padding: EdgeInsets.only(left: 7.h),
      child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
        Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
          Text("Name", style: CustomTextStyles.bodyLargeGray40001),
          SizedBox(height: 5.v),
          Text(booking.fullName, style: CustomTextStyles.titleMediumSemiBold_1),
         ],
        ),
        Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
          Text("Phone Number", style: CustomTextStyles.bodyLargeGray40001),
          SizedBox(height: 6.v),
          Text(booking.phone, style: CustomTextStyles.titleMediumSemiBold_1),
         ],
        ),
       ],
      ),
     ),
     SizedBox(height: 30.v),
     Padding(
      padding: EdgeInsets.only(left: 7.h, right: 45.h),
      child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
        Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
          Text("Check in", style: CustomTextStyles.bodyLargeGray40001),
          SizedBox(height: 6.v),
          Text("${booking.checkInDate.day}/${booking.checkInDate.month}/${booking.checkInDate.year}", style: CustomTextStyles.titleMediumSemiBold_1),
         ],
        ),
        Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
          Text("Check out", style: CustomTextStyles.bodyLargeGray40001),
          SizedBox(height: 6.v),
          Text("${booking.checkOutDate.day}/${booking.checkOutDate.month}/${booking.checkOutDate.year}", style: CustomTextStyles.titleMediumSemiBold_1),
         ],
        ),
       ],
      ),
     ),
     SizedBox(height: 30.v),
     Padding(
      padding: EdgeInsets.only(left: 7.h),
      child: Row(
       children: [
        Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
          Text("Title", style: CustomTextStyles.bodyLargeGray40001),
          SizedBox(height: 8.v),
          Text(booking.title, style: CustomTextStyles.titleMediumSemiBold_1),
         ],
        ),
        Padding(
         padding: EdgeInsets.only(left: 28.h),
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Text("Guest", style: CustomTextStyles.bodyLargeGray40001),
           SizedBox(height: 7.v),
           Text(booking.guestCount.toString(), style: CustomTextStyles.titleMediumSourceSansPro),
          ],
         ),
        ),
       ],
      ),
     ),
    ],
   ),
  );
 }

 Widget _buildDownloadTicket(BuildContext context) {
  return CustomElevatedButton(
   text: "Done",
   margin: EdgeInsets.only(left: 24.h, right: 24.h, bottom: 49.v),
   onPressed: () => _onTapButtonDone(context),
  );
 }

 void _onTapButtonDone(BuildContext context) {
  Navigator.pop(context);
 }

 // Navigates back to the previous screen.
 void onTapArrowLeft(BuildContext context) {
  Navigator.pop(context);
 }
}

