import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:funica/components/my_button.dart';
import 'package:funica/components/verify_code.dart';
import 'package:funica/screens/fill_your_profile/set_your_fingerprint.dart';

import 'components/default_appbar.dart';

class CreateNewPin extends StatelessWidget {
  const CreateNewPin({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Padding(
          padding:
              const EdgeInsets.only(top: kToolbarHeight, left: 20, right: 20),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const DefaultAppbar(
                      icon: const Icon(Icons.arrow_back),
                      title: "Create New PIN",
                    ),
                    const Text(
                      textAlign: TextAlign.center,
                      'Add a PIN number to make your account more secure.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 60),
                    const VerifyCode(),
                    SizedBox(
                        height: MediaQuery.of(context).size.height / 2 >= 300
                            ? 50
                            : MediaQuery.of(context).size.height / 10),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    const Spacer(),
                    // const SizedBox(height: 60),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: MyButton(
                        title: "Continue",
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const SetYourFingerprint()));
                          print('Button pressed continues');
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
