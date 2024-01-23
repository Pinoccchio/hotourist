import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hotel_app/core/app_export.dart';
import 'package:hotel_app/presentation/forgot_password_screen/forgot_password_screen.dart';
import 'package:hotel_app/presentation/forgot_password_type_otp_screen/forgot_password_type_otp_screen.dart';
import 'package:hotel_app/widgets/custom_checkbox_button.dart';
import 'package:hotel_app/widgets/custom_elevated_button.dart';
import 'package:hotel_app/widgets/custom_text_form_field.dart';
import '../../services/auth_service.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 11.v),
            child: Column(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgArrowLeft,
                  height: 28.adaptSize,
                  width: 28.adaptSize,
                  alignment: Alignment.centerLeft,
                  onTap: () {
                    onTapImgArrowLeft(context);
                  },
                ),
                SizedBox(height: 70.v),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 281.h,
                    margin: EdgeInsets.only(right: 99.h),
                    child: Text(
                      "Login to your\nAccount",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.displayMedium!.copyWith(height: 1.50),
                    ),
                  ),
                ),
                SizedBox(height: 21.v),
                _buildLoginForm(context),
                SizedBox(height: 57.v),
                _buildOrDivider(context),
                SizedBox(height: 33.v),
                _buildSocial(context),
                SizedBox(height: 49.v),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 1.v),
                      child: Text("Don’t have an account?", style: CustomTextStyles.bodyMediumGray50_1),
                    ),
                    GestureDetector(
                      onTap: () {
                        onTapTxtSignUp(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.h),
                        child: Text("Sign up", style: theme.textTheme.titleSmall),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.v),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFormField(
          controller: emailController,
          hintText: "Email",
          textInputType: TextInputType.emailAddress,
          prefix: Container(
            margin: EdgeInsets.fromLTRB(20.h, 20.v, 12.h, 20.v),
            child: CustomImageView(
              imagePath: ImageConstant.imgCheckmark,
              height: 20.adaptSize,
              width: 20.adaptSize,
            ),
          ),
          prefixConstraints: BoxConstraints(maxHeight: 60.v),
          contentPadding: EdgeInsets.only(top: 21.v, right: 30.h, bottom: 21.v),
        ),
        SizedBox(height: 24.v),
        CustomTextFormField(
          controller: passwordController,
          hintText: "Password",
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.visiblePassword,
          prefix: Container(
            margin: EdgeInsets.fromLTRB(20.h, 20.v, 12.h, 20.v),
            child: CustomImageView(
              imagePath: ImageConstant.imgLock,
              height: 20.adaptSize,
              width: 20.adaptSize,
            ),
          ),
          suffix: GestureDetector(
            onTap: () {
              // Toggle password visibility
              setState(() {
                isPasswordVisible = !isPasswordVisible;
              });
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(30.h, 20.v, 20.h, 20.v),
              child: CustomImageView(
                height: 20.adaptSize,
                imagePath: isPasswordVisible
                    ? 'lib/images/imgEye.png'
                    : 'lib/images/imgEyeClosed.png',
                width: 20.adaptSize,
              ),
            ),
          ),
          prefixConstraints: BoxConstraints(maxHeight: 60.v),
          suffixConstraints: BoxConstraints(maxHeight: 60.v),
          obscureText: !isPasswordVisible,
          contentPadding: EdgeInsets.symmetric(vertical: 21.v),
        ),
        SizedBox(height: 24.v),
        CustomElevatedButton(
          text: "Sign In",
          onPressed: () => onTapSignIn(context),
        ),
        SizedBox(height: 28.v),
        Align(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              onTapTxtForgotThePassword(context);
            },
            child: Text(
              "Forgot the password?",
              style: CustomTextStyles.titleMediumPrimarySemiBold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrDivider(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 11.v, bottom: 9.v),
            child: SizedBox(
              width: 96.h,
              child: Divider(),
            ),
          ),
          Text("or continue with", style: CustomTextStyles.titleMediumGray50),
          Padding(
            padding: EdgeInsets.only(top: 11.v, bottom: 9.v),
            child: SizedBox(
              width: 96.h,
              child: Divider(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocial(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 38.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              await onTapSignInWithGoogle(context);
            },
            child: Container(
              height: 60.v,
              width: 88.h,
              padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 17.v),
              decoration: AppDecoration.outlineGray.copyWith(borderRadius: BorderRadiusStyle.roundedBorder16),
              child: CustomImageView(
                imagePath: ImageConstant.imgFrame, // Use the Google image
                height: 24.adaptSize,
                width: 24.adaptSize,
                alignment: Alignment.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> onTapSignIn(BuildContext context) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 20),
                  Text("Loading"),
                ],
              ),
            ),
          );
        },
      );

      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      Navigator.of(context).pop(); // Close the loading dialog

      if (userCredential.user != null) {
        // Check and sign in the user
        await checkAndSignInUser(context, userCredential.user!.email!);
      }
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop(); // Close the loading dialog
      print('FirebaseAuthException - Error Code: ${e.code}');

      switch (e.code) {
      // Handle different authentication errors as needed
        case 'invalid-email':
          _showErrorDialog(
            context,
            'Invalid Email',
            'Please enter a valid email address.',
          );
          break;
        case 'invalid-credential':
          _showErrorDialog(
            context,
            'Invalid Credential',
            'Please double-check your email or password.',
          );
          break;
        case 'user-not-found':
          _showErrorDialog(
            context,
            'User Not Found',
            'The provided email address is not registered.',
          );
          break;
        case 'wrong-password':
          _showErrorDialog(
            context,
            'Incorrect Password',
            'Please double-check your password and try again.',
          );
          break;
        case 'too-many-requests':
          _showErrorDialog(
            context,
            'Too Many Requests',
            'You have exceeded the maximum number of login attempts. Please try again later.',
          );
          break;
        default:
          _showErrorDialog(
            context,
            'Sign In Failed',
            'An error occurred during sign-in. Please try again.',
          );
          break;
      }
    } catch (e) {
      // Handle other exceptions if needed
      print('Unexpected error during sign-in: $e');
    }
  }

  Future<void> onTapSignInWithGoogle(BuildContext context) async {
    try {
      // Sign out the current user
      await FirebaseAuth.instance.signOut();

      // Sign out Google account
      await GoogleSignIn().signOut();

      // Assuming you have a method signInWithGoogle in your AuthService
      await AuthService().signInWithGoogle();

      // Check if the user already exists in Firestore
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        await checkAndSignInUser(context, currentUser.email!);
      }
    } catch (e) {
      print('Google Sign-In Error: $e');
      // Handle the error as needed
    }
  }

  Future<void> checkAndSignInUser(BuildContext context, String email) async {
    final firestore = FirebaseFirestore.instance;
    try {
      final userDoc = firestore
          .collection('HotelApp')
          .doc('Users')
          .collection('User_Profile')
          .doc(email);

      // Check if the document already exists
      final docSnapshot = await userDoc.get();

      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data()!;
        if (data.containsKey('fullName') &&
            data.containsKey('nickname') &&
            data.containsKey('gender') &&
            data.containsKey('email') &&
            data.containsKey('dateOfBirth') &&
            data.containsKey('phoneNumber')) {
          // User has required fields, sign them in
          await signInUser(email);
          // Navigate to home page
          Navigator.pushReplacementNamed(context, AppRoutes.homeScreenContainerScreen);
        } else {
          // User is missing required fields, navigate to fill profile
          Navigator.pushReplacementNamed(context, AppRoutes.fillProfileScreen);
        }
      } else {
        // Document doesn't exist, navigate to fill profile for new users
        Navigator.pushReplacementNamed(context, AppRoutes.fillProfileScreen);
      }
    } catch (e) {
      print('Error checking user in Firestore: $e');
      rethrow;
    }
  }

  void onTapImgArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  Future<void> signInUser(String email) async {
    // Implement your sign-in logic here if needed
    // This can be useful if you have a custom sign-in method or need to perform additional actions on sign-in
  }

  void onTapTxtForgotThePassword(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ForgotPasswordTypeOtpScreen(),
      ),
    );
  }

  void onTapTxtSignUp(BuildContext context) {
    print('Sign Up tapped'); // Print a message for verification
    Navigator.pushNamed(context, AppRoutes.signUpBlankScreen);
  }

  void _showErrorDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1AADB6),
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'OK',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}