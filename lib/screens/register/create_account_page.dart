import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:funica/components/continue_with.dart';
import 'package:funica/components/my_textfield.dart';
import 'package:funica/components/remember_me.dart';
import 'package:funica/constants/constants.dart';
import 'package:funica/route/app_route.dart';
import 'package:funica/screens/fill_your_profile/fill_your_profile.dart';
import 'package:funica/screens/lets_you_in/start_page.dart';

import '../../components/my_button.dart';

class CreateAccount extends StatefulWidget {
  final VoidCallback showLoginPage;

  const CreateAccount({super.key, required this.showLoginPage});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _nextScreen(BuildContext context) async {
    try {
      if (signUpValidation(_emailController.text, _passwordController.text,
          _confirmPasswordController.text)) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FillYourProfile()));
        print('successful');
      } else {
        // Show error message to the user
        showMessage('Passwords do not match or validation failed');
      }
    } on FirebaseAuthException catch (e) {
      // Show specific error message based on the exception code
      showMessage(e.code.toString());
    }

  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 25.0, left: 25.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                    "Create Your Account",
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

                  // password text field
                  MyTextfieldpwd(
                    controller: _confirmPasswordController,
                    hintText: "Confirm Password",
                  ),
                  const SizedBox(height: 10),

                  // Remember me
                  const RememberMe(),
                  const SizedBox(height: 10),

                  // Sign up button
                  MyButton(
                    title: "Sign up",
                    onTap: () {
                      _nextScreen(context);
                    },
                  ),
                  const SizedBox(height: 25),

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
                        onTap: widget.showLoginPage,
                        child: const Text(
                          "Sign in",
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
}
