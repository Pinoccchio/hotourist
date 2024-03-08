import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotel_app/core/app_export.dart';
import 'package:hotel_app/presentation/booking_ongoing_tab_container_page/booking_ongoing_tab_container_page.dart';
import 'package:hotel_app/presentation/chat_screen/chat_screen.dart';
import 'package:hotel_app/presentation/home_screen_tab_container_page/home_screen_tab_container_page.dart';
import 'package:hotel_app/presentation/profile_settings_page/profile_settings_page.dart';
import 'package:hotel_app/presentation/search_page_tab_container_page/search_page_tab_container_page.dart';
import 'package:hotel_app/widgets/custom_bottom_bar.dart';

import '../booking_ongoing_page/booking_info_model.dart';
//MODIFIED
class HomeScreenContainerScreen extends StatelessWidget {
 HomeScreenContainerScreen({Key? key}) : super(key: key);

 GlobalKey<NavigatorState> navigatorKey = GlobalKey();

 DateTime? currentBackPressTime;

 @override
 Widget build(BuildContext context) {
  mediaQueryData = MediaQuery.of(context);

  return WillPopScope(
   onWillPop: _onWillPop,
   child: SafeArea(
    child: Scaffold(
     body: Navigator(
      key: navigatorKey,
      initialRoute: AppRoutes.homeScreenTabContainerPage,
      onGenerateRoute: (routeSetting) => PageRouteBuilder(
       pageBuilder: (ctx, ani, ani1) => getCurrentPage(routeSetting.name!),
       transitionDuration: Duration(seconds: 0),
      ),
     ),
     bottomNavigationBar: _buildBottomBar(context),
    ),
   ),
  );
 }

 Future<bool> _onWillPop() async {
  return (await showDialog(
   context: navigatorKey.currentContext!,
   builder: (context) => AlertDialog(
    backgroundColor: Color(0xFF24272F),
    title: Text(
     'Are you sure you want to exit the app?',
     style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
     ),
    ),
    actions: <Widget>[
     TextButton(
      onPressed: () => Navigator.of(context).pop(false),
      style: ButtonStyle(
       backgroundColor: MaterialStateProperty.all(Color(0xFF24272F)),
      ),
      child: Text(
       'No',
       style: TextStyle(color: Colors.white),
      ),
     ),
     TextButton(
      onPressed: () {
       SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      },
      style: ButtonStyle(
       backgroundColor: MaterialStateProperty.all(Color(0xFF1AADB6)),
      ),
      child: Text(
       'Yes',
       style: TextStyle(color: Colors.white),
      ),
     ),
    ],
   ),
  )) ??
      false;
 }

 Widget _buildBottomBar(BuildContext context) {
  return CustomBottomBar(
   onChanged: (BottomBarEnum type) {
    Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
   },
  );
 }

 String getCurrentRoute(BottomBarEnum type) {
  switch (type) {
   case BottomBarEnum.Home:
    return AppRoutes.homeScreenTabContainerPage;
   case BottomBarEnum.Chat:
    return AppRoutes.chatScreen;
   case BottomBarEnum.Booking:
    return AppRoutes.bookingOngoingTabContainerPage;
   case BottomBarEnum.Profile:
    return AppRoutes.profileSettingsPage;
   default:
    return "/";
  }
 }

 Widget getCurrentPage(String currentRoute) {
  switch (currentRoute) {
   case AppRoutes.homeScreenTabContainerPage:
    return HomeScreenTabContainerPage();
   case AppRoutes.chatScreen:
    return ChatScreen();
   case AppRoutes.bookingOngoingTabContainerPage:
    return BookingOngoingTabContainerPage();
   case AppRoutes.profileSettingsPage:
    return ProfileSettingsPage();
   default:
    return DefaultWidget();
  }
 }
}