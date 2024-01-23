import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hotel_app/presentation/edit_profile_screen/edit_profile_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotel_app/core/app_export.dart';
import 'package:hotel_app/widgets/app_bar/appbar_leading_image.dart';
import 'package:hotel_app/widgets/app_bar/appbar_title.dart';
import 'package:hotel_app/widgets/app_bar/appbar_trailing_image.dart';
import 'package:hotel_app/widgets/app_bar/custom_app_bar.dart';
import 'package:hotel_app/widgets/custom_elevated_button.dart';
import 'package:hotel_app/widgets/custom_switch.dart';

import '../../services/notif_service.dart';
import '../chat_screen/chat_screen.dart';
import '../notifications_screen/notifications_screen.dart';

class ProfileSettingsPage extends StatefulWidget {
 const ProfileSettingsPage({Key? key}) : super(key: key);

 @override
 _ProfileSettingsPageState createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
 bool isSelectedSwitch = false;
 User? currentUser;
 int unreadNotificationsCount = 0;

 @override
 void initState() {
  super.initState();
  currentUser = FirebaseAuth.instance.currentUser;
  // Fetch unread notifications count
  _fetchUnreadNotificationsCount();
 }

 _fetchUnreadNotificationsCount() async {
  final currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
   final notifications = await NotificationService().getNotificationsForUser(currentUser.uid);
   setState(() {
    unreadNotificationsCount = notifications.where((doc) => !doc['read']).length;
   });
  }
 }

 Widget _buildProfile(BuildContext context) {
  String photoURL = currentUser?.photoURL ?? 'lib/assets/default_profile.png';

  return Align(
   alignment: Alignment.center,
   child: Container(
    margin: EdgeInsets.only(top: 124.v),
    height: 189.v,
    width: 181.h,
    child: Column(
     mainAxisAlignment: MainAxisAlignment.center,
     children: [
      SizedBox(
       height: 120.adaptSize,
       width: 120.adaptSize,
       child: CircleAvatar(
        radius: 60.h,
        backgroundImage: photoURL.isNotEmpty
            ? NetworkImage(photoURL)
            : AssetImage('lib/assets/default_profile.png') as ImageProvider,
       ),
      ),
      SizedBox(height: 10.v),
      FittedBox(
       fit: BoxFit.scaleDown,
       child: Text(
        currentUser?.displayName ?? "",
        style: theme.textTheme.headlineSmall,
        textAlign: TextAlign.center,
       ),
      ),
      SizedBox(height: 11.v),
      Text(
       currentUser?.email ?? "",
       style: CustomTextStyles.titleSmallWhiteA700,
       textAlign: TextAlign.center,
      ),
     ],
    ),
   ),
  );
 }


 Widget _buildProfileButton({
  required String text,
  required String imagePath,
  required VoidCallback onPressed,
 }) {
  return Column(
   children: [
    CustomElevatedButton(
     height: 28.v,
     width: 114.h,
     text: text,
     leftIcon: Container(
      margin: EdgeInsets.only(right: 10.h),
      child: CustomImageView(
       imagePath: imagePath,
       height: 28.adaptSize,
       width: 28.adaptSize,
      ),
     ),
     buttonStyle: CustomButtonStyles.none,
     buttonTextStyle: CustomTextStyles.titleMediumSemiBold_1,
     onPressed: onPressed,
    ),
    SizedBox(height: 10.v), // Adjust the spacing between buttons as needed
   ],
  );
 }

 Widget build(BuildContext context) {
  mediaQueryData = MediaQuery.of(context);
  return SafeArea(
   child: Scaffold(
    appBar: _buildAppBar(context),
    body: SingleChildScrollView(
     child: Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 30.h),
      child: Column(
       crossAxisAlignment: CrossAxisAlignment.center,
       children: [
        // Move the profile information to the top center
        _buildProfile(context),
        SizedBox(height: 50.v),
        // Align the buttons to the left
        Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
          _buildProfileButton(
           text: "Edit Profile",
           imagePath: ImageConstant.imgUser,
           onPressed: () {
            onTapEditProfile(context);
           },
          ),
          SizedBox(height: 20.v),
          /*
          _buildProfileButton(
           text: "Payment",
           imagePath: ImageConstant.imgIconlyCurvedWallet,
           onPressed: () {

           },
          ),
           */
          SizedBox(height: 20.v),
          _buildProfileButton(
           text: "Notifications",
           imagePath: ImageConstant.imgIcons,
           onPressed: () {
            onTapNotification(context);
           },
          ),
          SizedBox(height: 20.v),
          /*
          _buildProfileButton(
           text: "Security",
           imagePath: ImageConstant.imgCheckmarkWhiteA700,
           onPressed: () {
            onTapSecurity(context);
           },
          ),
           */
          SizedBox(height: 20.v),
          Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
            GestureDetector(
             onTap: () {
              onTapLogout(context);
             },
             child: Padding(
              padding: EdgeInsets.only(left: 20.h, top: 5.v),
              child: Text(
               "Logout",
               style: CustomTextStyles.titleMediumRed400,
              ),
             ),
            ),
           ],
          ),
          SizedBox(height: 30.v),
         ],
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
   height: 50.v,
   leadingWidth: 56.h,
   leading: AppbarLeadingImage(
    imagePath: 'lib/images/logo.png',
    margin: EdgeInsets.only(left: 24.h, top: 9.v, bottom: 9.v),
    onTap: () {
     print("Clicked!");
    },
   ),
   title: AppbarTitle(text: "Profile", margin: EdgeInsets.only(left: 16.h)),
  );
 }

 Widget _buildDarkTheme(BuildContext context) {
  return Row(
   children: [
    CustomImageView(
     imagePath: ImageConstant.imgEye,
     height: 28.adaptSize,
     width: 28.adaptSize,
    ),
    Padding(
     padding: EdgeInsets.only(left: 20.h, top: 2.v, bottom: 3.v),
     child: Text(
      "Dark Theme",
      style: CustomTextStyles.titleMediumSemiBold_1,
     ),
    ),
    Spacer(),
    CustomSwitch(value: isSelectedSwitch, onChange: (value) {
     setState(() {
      isSelectedSwitch = value;
     });
    }),
   ],
  );
 }

 onTapEditProfile(BuildContext context) {
  Navigator.push(
   context,
   MaterialPageRoute(
    builder: (context) => EditProfileScreen(),
   ),
  );
 }

 /*
 onTapNotifications(BuildContext context) {
  Navigator.push(
   context,
   MaterialPageRoute(
    builder: (context) => NotificationsScreen(),
   ),
  );
 }
  */

 onTapSecurity(BuildContext context) {
  Navigator.pushNamed(context, AppRoutes.securityScreen);
 }

 onTapNotification(BuildContext context) {
  Navigator.push(
   context,
   MaterialPageRoute(
    builder: (context) => NotificationsScreen(updateUnreadCount: _fetchUnreadNotificationsCount)
   ),
  );
 }

 onTapLogout(BuildContext context) async {
  try {
   await FirebaseAuth.instance.signOut();
   await GoogleSignIn().signOut();

   String userName = FirebaseAuth.instance.currentUser?.displayName ?? 'User';

   /*
   NotificationService().simpleNotificationShow(
    title: 'Logout Successful',
    body: 'Goodbye, $userName! You have been successfully logged out.',
   );
    */

   // Exit the app
   SystemNavigator.pop();

  } catch (e) {
   print("Error signing out: $e");
  }
 }
}