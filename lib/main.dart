import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:funica/presentation/screens/splash/splash_screen.dart';

// Splash Screen - Completed successfully
// Intro Screen - Completed successfully
// Let's you in - Completed successfully
// Create Your Account - Completed successfully
// Login to Your Account
// Fill Your Profile
// Create New PIN
// Set Your Fingerprint
// Forgot Password
// Create New Password
// Home Page
// Notification
// My Wishlist

late Size mq;

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "comforta",
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
