import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:funica/components/continue_with.dart';
import 'package:funica/components/my_textfield.dart';
import 'package:funica/components/remember_me.dart';
import 'package:funica/constants/constants.dart';
import 'package:funica/firebase_helper/firebase_auth.dart';
import 'package:funica/route/app_route.dart';
import 'package:funica/screens/dashboard/dashboard_screen.dart';
import 'package:funica/screens/lets_you_in/start_page.dart';
import 'package:get/get.dart';

import '../../components/my_button.dart';
import 'forgot_password.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;

  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isChecked = false;

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(right: 25.0, left: 25.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 18),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const StartPage(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // Company logo
                  Image.asset(
                    "assets/icons/funica.png",
                    width: 120,
                    height: 120,
                  ),
                  const SizedBox(height: 25),

                  // Create your account
                  const Text(
                    "Login to Your Account",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 25),

                  // email text field
                  MyTextfield(
                    controller: _emailController,
                    hintText: "Email",
                    iconUrl: "assets/icons/email.png",
                  ),
                  const SizedBox(height: 10),

                  // password text field
                  MyTextfieldpwd(
                    controller: _passwordController,
                    hintText: "Password",
                  ),
                  const SizedBox(height: 10),

                  // Remember me
                  const RememberMe(),
                  const SizedBox(height: 10),

                  // Sign in button
                  MyButton(
                    title: "Sign in",
                    onTap: () async {
                      String email = _emailController.text.trim();
                      String password = _passwordController.text;
                      if (loginValidation(email, password)) {
                        try {
                          final auth = FirebaseAuth.instance;
                          await auth.signInWithEmailAndPassword(
                            email: email,  // Use the email variable here
                            password: password,
                          );
                          // Authentication successful, navigate to the next screen
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => DashboardScreen()),  // Replace with your desired screen
                          );
                        } on FirebaseAuthException catch (e) {
                          showMessage(e.code.toString());
                        }
                      }
                    },
                  ),

                  const SizedBox(height: 25),

                  // Forgot the password?
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ForgotPassword()));
                    },
                    child: const Text(
                      "Forgot the password?",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),

                  // or continue with
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: .5,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text("or continue with"),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: .5,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Sign up with
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SignUpWith(
                        imageUrl: "assets/icons/facebook.png",
                      ),
                      SignUpWith(
                        imageUrl: "assets/icons/google.png",
                      ),
                      SignUpWith(
                        imageUrl: "assets/icons/apple.png",
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),

                  // Already have an account? Sign in
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black45,
                        ),
                      ),
                      InkWell(
                        onTap: widget.showRegisterPage,
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> singIn() async {
    try {
      final auth = FirebaseAuth.instance;
      auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (_) => DashboardScreen()));
    } on FirebaseAuthException catch (e) {
      showMessage(e.toString());
    }
  }
}
