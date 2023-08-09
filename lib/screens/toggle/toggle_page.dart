import 'package:flutter/material.dart';
import 'package:funica/screens/login/login_page.dart';
import 'package:funica/screens/register/create_account_page.dart';

class TogglePage extends StatefulWidget {
  const TogglePage({super.key});

  @override
  State<TogglePage> createState() => _TogglePageState();
}

class _TogglePageState extends State<TogglePage> {
  // initially, show the login page
  bool showloginPage = true;

  void toggleScreen () {
    setState(() {
      showloginPage = !showloginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showloginPage){
      return LoginPage(showRegisterPage: toggleScreen);
    } else {
      return CreateAccount(showLoginPage: toggleScreen);
    }
  }
}
