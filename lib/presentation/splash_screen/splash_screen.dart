import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/core/app_export.dart';
import '../welcome_screen/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
  }

  Future<void> _checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      // If there is an internet connection, navigate to the welcome screen
      _navigateToWelcomeScreen();
    } else {
      // If there is no internet connection, show a message and close the app
      _showNoInternetDialog();
    }
  }

  void _navigateToWelcomeScreen() {
    // Add a delay to simulate the splash screen
    Future.delayed(Duration(seconds: 5), () {
      // Navigate to the welcome screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => WelcomeScreen(),
        ),
      );
    });
  }

  void _showNoInternetDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1AADB6), // Set the background color of the dialog
        title: Text(
          'No Internet Connection',
          style: TextStyle(color: Colors.white), // Set the text color of the title
        ),
        content: Text(
          'Please connect to the internet and try again.',
          style: TextStyle(color: Colors.white), // Set the text color of the content
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Close the app when there is no internet connection
              exit(0);
            },
            child: Text(
              'OK',
              style: TextStyle(color: Colors.white), // Set the text color of the button
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 5.v),
          child: Column(
            children: [
              Spacer(
                flex: 48,
              ),
              Container(
                decoration: AppDecoration.outlineBlackF,
                child: Text(
                  "Hotourist ",
                  style: theme.textTheme.displayMedium,
                ),
              ),
              Spacer(
                flex: 51,
              ),
              Text(
                "Merico, Panganiban, Villanueva 2024",
                style: theme.textTheme.titleSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}