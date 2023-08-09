import 'package:flutter/material.dart';
import 'package:funica/components/loading.dart';
import 'package:funica/components/my_button.dart';
import 'package:funica/components/my_textfield.dart';
import 'package:funica/components/remember_me.dart';
import 'package:funica/route/app_route.dart';
import 'package:funica/screens/fill_your_profile/components/default_appbar.dart';

class CreateNewPassword extends StatelessWidget {
  const CreateNewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.only(top: kToolbarHeight, left: 20, right: 20),
        child: Column(
          children: [
            const DefaultAppbar(
              icon: Icon(Icons.arrow_back),
              title: 'Create New Password',
            ),
            const SizedBox(height: 40),
            Image.asset(
              'assets/icons/new_password.png',
              width: 160,
              height: 160,
            ),
            const SizedBox(height: 40),
            const Text(
              'Create Your New Password',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            MyTextfieldpwd(
              hintText: 'New Password',
              controller: TextEditingController(),
            ),
            const SizedBox(height: 20),
            MyTextfieldpwd(
              hintText: 'Confirm New Password',
              controller: TextEditingController(),
            ),
            const SizedBox(height: 20),
            const RememberMe(),
            const SizedBox(height: 60),
            MyButton(
              title: 'Continue',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const Loading(
                      where: AppRoute.dashboard,
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
