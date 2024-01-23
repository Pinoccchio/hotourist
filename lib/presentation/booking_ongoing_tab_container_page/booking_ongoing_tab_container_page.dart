import 'package:flutter/material.dart';
import 'package:hotel_app/core/app_export.dart';
import 'package:hotel_app/presentation/booking_cancelled_page/booking_cancelled_page.dart';
import 'package:hotel_app/presentation/booking_completed_page/booking_completed_page.dart';
import 'package:hotel_app/presentation/booking_ongoing_page/booking_ongoing_page.dart';
import 'package:hotel_app/widgets/app_bar/appbar_leading_image.dart';
import 'package:hotel_app/widgets/app_bar/appbar_title.dart';
import 'package:hotel_app/widgets/app_bar/appbar_trailing_image.dart';
import 'package:hotel_app/widgets/app_bar/custom_app_bar.dart';

import '../booking_ongoing_page/booking_info_model.dart';
import '../home_screen_page/hotel_class/hotel_list_model.dart';

class BookingOngoingTabContainerPage extends StatefulWidget {// Pass a List<BookingInfo> instead of a single BookingInfo
 const BookingOngoingTabContainerPage({Key? key})
     : super(key: key);

 @override
 BookingOngoingTabContainerPageState createState() =>
     BookingOngoingTabContainerPageState();
}

class BookingOngoingTabContainerPageState
    extends State<BookingOngoingTabContainerPage>
    with TickerProviderStateMixin {
 late TabController tabviewController;

 @override
 void initState() {
  super.initState();
  tabviewController = TabController(length: 3, vsync: this);
 }

 @override
 Widget build(BuildContext context) {
  MediaQueryData mediaQueryData = MediaQuery.of(context);

  return SafeArea(
   child: Scaffold(
    appBar: _buildAppBar(context),
    body: SizedBox(
     width: double.maxFinite,
     child: Column(
      children: [
       SizedBox(height: 30.v),
       _buildTabview(context),
       SizedBox(
        height: 667.v,
        child: TabBarView(
         controller: tabviewController,
         children: [
          BookingOngoingPage(),
          BookingCompletedPage(),
          BookingCancelledPage(),
         ],
        ),
       ),
      ],
     ),
    ),
   ),
  );
 }

 // Section Widget
 PreferredSizeWidget _buildAppBar(BuildContext context) {
  return CustomAppBar(
   height: 50.v,
   leadingWidth: 56.h,
   leading: AppbarLeadingImage(
    imagePath: 'lib/images/logo.png',
    margin: EdgeInsets.only(left: 24.h, top: 9.v, bottom: 9.v),
    onTap: () {
     print("Clicked!");
    },
   ),
   title: AppbarTitle(
    text: "My Bookings",
    margin: EdgeInsets.only(left: 16.h),
   ),
  );
 }

 // Section Widget
 Widget _buildTabview(BuildContext context) {
  return Container(
   height: 45.v,
   width: 380.h,
   child: TabBar(
    controller: tabviewController,
    labelPadding: EdgeInsets.zero,
    labelColor: appTheme.whiteA700,
    labelStyle: TextStyle(
     fontSize: 16.fSize,
     fontFamily: 'Urbanist',
     fontWeight: FontWeight.w600,
    ),
    unselectedLabelColor: theme.colorScheme.primary,
    unselectedLabelStyle: TextStyle(
     fontSize: 16.fSize,
     fontFamily: 'Urbanist',
     fontWeight: FontWeight.w600,
    ),
    indicator: BoxDecoration(
     color: theme.colorScheme.primary,
     borderRadius: BorderRadius.circular(22.h),
    ),
    tabs: [
     Tab(child: Text("Ongoing")),
     Tab(child: Text("Completed")),
     Tab(child: Text("Cancelled")),
    ],
   ),
  );
 }
}
