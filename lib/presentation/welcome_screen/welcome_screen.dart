import 'package:flutter/material.dart';
import 'package:hotel_app/core/app_export.dart';

import '../../services/auth_service.dart';
import '../home_screen_container_screen/home_screen_container_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  // Check if the user is logged in
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();

    // Check if the user is logged in
    isLoggedIn = AuthService().isUserLoggedIn();

    // Start a timer to navigate after 5 seconds
    Future.delayed(Duration(seconds: 5), () {
      _navigateToNextScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return GestureDetector(
      onTap: _navigateToNextScreen,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                children: [
                  CustomImageView(
                    imagePath: 'lib/images/logo.png',
                    height: 164.v,
                    width: 167.h,
                    margin: EdgeInsets.only(left: 120, top: 200, right: 120),
                  ),
                  SizedBox(height: 76.v),
                  _buildWelcomeSection(context),
                  SizedBox(height: 5.v),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome to",
            style: theme.textTheme.displayMedium,
          ),
          SizedBox(height: 23.v),
          Text(
            "Hotourist",
            style: theme.textTheme.displayLarge,
          ),
          SizedBox(height: 40.v),
          Container(
            width: 319.h,
            margin: EdgeInsets.only(right: 44.h),
            child: Text(
              "Empower your journeys using our standalone app created by CIT students as their final project. It reflects their unwavering dedication, striving to elevate your hotel experience.",
              style: CustomTextStyles.titleMediumSemiBold_1.copyWith(
                height: 1.50,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToNextScreen() {
    if (isLoggedIn) {
      print("User already logged in");
      // If logged in, go directly to HomeScreenContainerScreen
      Navigator.pushReplacementNamed(context, AppRoutes.homeScreenContainerScreen);
    } else {
      // If not logged in, go to onboarding screen
      Navigator.pushReplacementNamed(context, AppRoutes.onboardingOneScreen);
    }
  }
}