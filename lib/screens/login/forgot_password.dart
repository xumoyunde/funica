import 'package:flutter/material.dart';
import 'package:funica/components/loading.dart';
import 'package:funica/components/my_button.dart';
import 'package:funica/components/verify_code.dart';
import 'package:funica/route/app_route.dart';
import 'package:funica/screens/fill_your_profile/components/default_appbar.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(
            top: kToolbarHeight,
            right: 20,
            left: 20,
          ),
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const DefaultAppbar(
                  icon: Icon(Icons.arrow_back),
                  title: 'Forgot Password',
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10,
                ),
                const Text(
                  textAlign: TextAlign.center,
                  'Code has been send to +1 111 *******99',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10,
                ),
                const VerifyCode(),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10,
                ),
                const Text(
                  textAlign: TextAlign.center,
                  'Resend code in 55 s',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
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
                          title: "Verify",
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const Loading(
                                  where: AppRoute.createNewPassword,
                                );
                              },
                            );
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
      ),
    );
  }
}
