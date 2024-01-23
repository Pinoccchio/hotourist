import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import the services library
import 'package:firebase_core/firebase_core.dart';
import 'package:hotel_app/core/app_export.dart';
import 'package:hotel_app/presentation/fill_profile_screen/fill_profile_screen.dart';
import 'package:hotel_app/presentation/forgot_password_screen/forgot_password_screen.dart';
import 'package:hotel_app/presentation/home_screen_container_screen/home_screen_container_screen.dart';
import 'package:hotel_app/presentation/my_bookmarks_screen/widgets/bookmark_provider.dart';
import 'package:hotel_app/presentation/onboarding_one_screen/onboarding_one_screen.dart';
import 'package:hotel_app/presentation/onboarding_three_screen/onboarding_three_screen.dart';
import 'package:hotel_app/presentation/onboarding_two_screen/onboarding_two_screen.dart';
import 'package:hotel_app/presentation/sign_in_screen/sign_in_screen.dart';
import 'package:hotel_app/presentation/sign_up_blank_screen/sign_up_blank_screen.dart';
import 'package:hotel_app/presentation/splash_screen/splash_screen.dart';
import 'package:hotel_app/services/notif_service.dart';
import 'package:hotel_app/theme/theme_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebaseApp();

  // Initialize NotificationService
  NotificationService().initNotification();

  // Set preferred orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  // Initialize SharedPreferences
  await SharedPreferences.getInstance();

  // Set the status bar color and navigation bar color
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(0xFF35383F),
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Color(0xFF1AADB6),
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);

  ThemeHelper().changeTheme('primary');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BookmarkProvider()),
        // Add other providers here if needed
      ],
      child: const MyApp(),
    ),
  );
}

Future<void> initializeFirebaseApp() async {
  FirebaseOptions options = const FirebaseOptions(
    apiKey: "AIzaSyC4eHN3QdECaAYeH7KVOx6tjE9yKs70uFU",
    authDomain: "hoteltourist-app.firebaseapp.com",
    appId: "1:1092759701323:web:0c5a123e97a9b3180d4ace",
    messagingSenderId: "1092759701323",
    projectId: "hoteltourist-app",
    storageBucket: "hoteltourist-app.appspot.com",
  );
  await Firebase.initializeApp(
    options: options,
    name: "hoteltourist-app", // Set the default app name here
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      title: 'hotel_app',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splashScreen,
      routes: {
        AppRoutes.onboardingOneScreen: (context) => OnboardingOneScreen(),
        AppRoutes.onboardingTwoScreen: (context) => OnboardingTwoScreen(),
        AppRoutes.onboardingThreeScreen: (context) => OnboardingThreeScreen(),
        AppRoutes.splashScreen: (context) => SplashScreen(),
        AppRoutes.signInScreen: (context) => SignInScreen(),
        AppRoutes.homeScreenContainerScreen: (context) => HomeScreenContainerScreen(),
        AppRoutes.forgotPasswordScreen: (context) => ForgotPasswordScreen(),
        AppRoutes.signUpBlankScreen: (context) => SignUpBlankScreen(),
        AppRoutes.fillProfileScreen: (context) => FillProfileScreen(),
        // Add other routes as needed
      },
    );
  }
}