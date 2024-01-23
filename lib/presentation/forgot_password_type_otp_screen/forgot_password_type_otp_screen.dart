import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/core/app_export.dart';
import 'package:hotel_app/widgets/app_bar/appbar_leading_image.dart';
import 'package:hotel_app/widgets/app_bar/appbar_title.dart';
import 'package:hotel_app/widgets/app_bar/custom_app_bar.dart';
import 'package:hotel_app/widgets/custom_elevated_button.dart';

class ForgotPasswordTypeOtpScreen extends StatefulWidget {
 ForgotPasswordTypeOtpScreen({Key? key}) : super(key: key);

 @override
 _ForgotPasswordTypeOtpScreenState createState() =>
     _ForgotPasswordTypeOtpScreenState();
}

class _ForgotPasswordTypeOtpScreenState
    extends State<ForgotPasswordTypeOtpScreen> {
 final _emailController = TextEditingController();

 @override
 Widget build(BuildContext context) {
  MediaQueryData mediaQueryData = MediaQuery.of(context);

  return Scaffold(
   appBar: _buildAppBar(context),
   body: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
     const Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: Text(
       'Enter your email and we will send you a password reset link',
       textAlign: TextAlign.center,
      ),
     ),
     const SizedBox(height: 10),
     // email textfield
     Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
       controller: _emailController, // Access input
       obscureText: false, // Hide characters (T/F)
       style: TextStyle(color: Colors.black),
       decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
         borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
         borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        fillColor: Colors.grey.shade200,
        filled: true,
        hintText: "Enter your email",
        hintStyle: TextStyle(
            color: Colors.grey[500]), // Hints
       ),
      ),
     ),
     const SizedBox(height: 10),
     // Verify button
     _buildResetPasswordButton(context),
    ],
   ),
  );
 }

 // Section Widget
 PreferredSizeWidget _buildAppBar(BuildContext context) {
  return CustomAppBar(
   leadingWidth: 52.0, // Assuming 52 is a constant value
   leading: AppbarLeadingImage(
    imagePath: ImageConstant.imgArrowLeft,
    margin: EdgeInsets.only(left: 24.0, top: 11.0, bottom: 16.0),
    onTap: () {
     onTapArrowLeft(context);
    },
   ),
   title: AppbarTitle(
       text: "Forgot Password", margin: EdgeInsets.only(left: 16.0)),
  );
 }

 // Section Widget
 Widget _buildResetPasswordButton(BuildContext context) {
  return CustomElevatedButton(
   text: "Reset Password",
   margin: EdgeInsets.only(left: 24.0, right: 24.0, bottom: 49.0),
   onPressed: () => passwordReset(context),
  );
 }

 Future<void> passwordReset(BuildContext context) async {
  try {
   await FirebaseAuth.instance
       .sendPasswordResetEmail(email: _emailController.text.trim());
   _showMessageDialog(
       context, "SUCCESS", "Password reset link sent to your email.");
  } on FirebaseAuthException catch (e) {
   print("FIREBASE_AUTH_ERROR: $e");

   String errorMessage = "An error occurred. Please try again later.";

   if (e.code == 'invalid-email') {
    errorMessage = 'Invalid email. Please provide a valid email address.';
   } else if (e.code == 'user-not-found') {
    errorMessage = 'User not found. Please check your email address.';
   }

   _showMessageDialog(context, 'ERROR', errorMessage);
  } catch (e) {
   print("GENERAL_ERROR: $e");
   _showMessageDialog(context, 'ERROR', 'An unexpected error occurred.');
  }
 }

 void _showMessageDialog(BuildContext context, String title, String message) {
  showDialog(
   context: context,
   builder: (BuildContext context) {
    return AlertDialog(
     backgroundColor: Color(0xFF24272F),
     title: Text(
      title,
      style: TextStyle(color: Colors.white),
     ),
     content: Text(
      message,
      style: TextStyle(color: Colors.white),
     ),
     actions: <Widget>[
      TextButton(
       onPressed: () {
        Navigator.of(context).pop();
       },
       style: TextButton.styleFrom(
        backgroundColor: Color(0xFF1AADB6),
        primary: Colors.white,
       ),
       child: Text('OK'),
      ),
     ],
    );
   },
  );
 }

 // Navigates back to the previous screen.
 onTapArrowLeft(BuildContext context) {
  Navigator.pop(context);
 }
}