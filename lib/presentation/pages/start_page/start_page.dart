import 'package:flutter/material.dart';
import 'package:funica/presentation/components/continue_with.dart';
import 'package:funica/presentation/components/my_button.dart';
import 'package:funica/presentation/pages/register/create_account_page.dart';
import 'package:funica/presentation/screens/intro/intro_screen.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(right: 25, left: 25),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const IntroScreen()),
                      );
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                ),
              ),

              Image.asset(
                "assets/images/lets.png",
                width: 200,
              ),
              const SizedBox(height: 40),

              const Text(
                "Let's you in",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 25),

              // Continue with Facebook
              const SignInWith(
                imageUrl: "assets/icons/facebook.png",
                access: "Facebook",
              ),
              const SizedBox(height: 15),

              // Continue with Google
              const SignInWith(
                imageUrl: "assets/icons/google.png",
                access: "Google",
              ),
              const SizedBox(height: 15),

              // Continue with Apple
              const SignInWith(
                imageUrl: "assets/icons/apple.png",
                access: "Apple",
              ),
              const SizedBox(height: 25),

              // or
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      thickness: .2,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text("or"),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: .2,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              // Sign in with email and password
              MyButton(
                title: "Sign in with email",
                onTap: () {},
              ),
              const SizedBox(height: 25),

              // Don't have an account? Sign up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black45,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const CreateAccount()),);
                    },
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
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
