import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:funica/firebase_helper/auth_controller.dart';
import 'package:funica/route/app_route.dart';
import 'package:funica/screens/cart/cart_screen.dart';
import 'package:funica/screens/home/home_screen.dart';
import 'package:funica/screens/profile/profile_screen.dart';
import 'package:funica/screens/toggle/toggle_page.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: IndexedStack(
          // index: controller.tabIndex,
          index: tabIndex,
          children: [
            const HomeScreen(),
            const CartScreen(),
            const Text('Hello world cart'),
            Container(
              child: Center(
                child: MaterialButton(
                  onPressed: (){
                    AuthController().signOut();
                    Get.toNamed(AppRoute.login);
                  },
                ),
              ),
            ),
            ProfileScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabIndex,
        selectedLabelStyle: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            tabIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Image.asset(
              tabIndex == 0
                  ? 'assets/icons/bottom_navigation_bar_icons/home_with_background.png'
                  : 'assets/icons/bottom_navigation_bar_icons/home.png',
              width: 32,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Cart',
            icon: Image.asset(
              tabIndex == 1
                  ? 'assets/icons/bottom_navigation_bar_icons/cart_with_background.png'
                  : 'assets/icons/bottom_navigation_bar_icons/cart.png',
              width: 32,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Order',
            icon: Image.asset(
              tabIndex == 2
                  ? 'assets/icons/bottom_navigation_bar_icons/orders_with_background.png'
                  : 'assets/icons/bottom_navigation_bar_icons/orders.png',
              width: 32,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Wallet',
            icon: Image.asset(
              tabIndex == 3
                  ? 'assets/icons/bottom_navigation_bar_icons/wallet_with_background.png'
                  : 'assets/icons/bottom_navigation_bar_icons/wallet.png',
              width: 32,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Image.asset(
              tabIndex == 4
                  ? 'assets/icons/bottom_navigation_bar_icons/profile_with_background.png'
                  : 'assets/icons/bottom_navigation_bar_icons/profile.png',
              width: 32,
            ),
          ),
        ],
      ),
    );
  }
}
