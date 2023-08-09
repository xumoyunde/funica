import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:funica/firebase_helper/firebase_auth.dart';
import 'package:funica/screens/dashboard/dashboard_screen.dart';
import 'package:funica/screens/home/home_screen.\dart';
import 'package:funica/screens/splash/splash_screen.dart';
import 'package:funica/screens/toggle/toggle_page.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';
import 'route/app_page.dart';
import 'route/app_route.dart';

/// ********************** SEASON 1 *********************** ///
// Splash Screen - Completed successfully 12.07.2023
// Intro Screen - Completed successfully 12.07.2023
// Let's you in - Completed successfully 13.07.2023
// Create Your Account - Completed successfully 13.07.2023
// Login to Your Account - Completed successfully 14.07.2023
// Fill Your Profile - Completed successfully 15.07.2023 Completed 31.07.2023
// Create New PIN - Completed successfully 01.08.2023
// Set Your Fingerprint - Completed successfully 01.08.2023
// Forgot Password - Completed successfully 02.08.2023
// Create New Password - Completed successfully 02.08.2023
// Home Page - Completed successfully 28.07.2023
// Notification - Completed successfully 28.07.2023
// My Wishlist - Completed successfully 31.07.2023

/// ********************** SEASON 2 *********************** ///
// Special Offers - Started 02.08.2023
// Most Popular
// Search
// Sort & Filter
// Filtered
// Product Screen
// Rate
// My Cart
// Checkout
// Shipping Address
// Choose Shipping
// Add Promo
// Payment Methods
// Enter Your PIN
// Order Successfully

late Size mq;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if(snapshot.hasError){
              return Center(child: Text(snapshot.error.toString()),);
            } else if(snapshot.hasData && snapshot.data != null){
              return DashboardScreen();
            } else {
              return const TogglePage();
            }
          }
        },
      ),
    );
  }
}
