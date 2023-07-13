import 'package:flutter/material.dart';
import 'package:funica/presentation/components/continue_with.dart';
import 'package:funica/presentation/components/my_textfield.dart';
import 'package:funica/presentation/pages/start_page/start_page.dart';

import '../../components/my_button.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  bool isChecked = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  iconUrl: "assets/icons/password.png",
                ),
                const SizedBox(height: 10),

                // Remember me
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      semanticLabel: "remember me",
                      side: const BorderSide(width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      checkColor: Colors.white,
                      activeColor: Colors.black,
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isChecked = !isChecked;
                        });
                      },
                      child: const Text(
                        "Remember me",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),

                // Sign up button
                MyButton(
                  title: "Sign up",
                  onTap: () {},
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
                      onTap: () {
                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const CreateAccount(),
                        //   ),
                        // );
                      },
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
    );
  }
}
