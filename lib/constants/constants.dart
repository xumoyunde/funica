import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Builder(
      builder: (context) {
        return SizedBox(
          width: 100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(
                color: Colors.redAccent,
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                margin: EdgeInsets.only(left: 7),
                child: Text('Loading...'),
              ),
            ],
          ),
        );
      },
    ),
  );
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
}

String getMessageFromErrorCode(String errorCode) {
  switch (errorCode) {
    case 'invalid-email':
      return 'Invalid Email';
    case 'user-not-found':
      return 'User Not Found';
    case 'wrong-password':
      return 'Wrong Password';
    case 'user-disabled':
      return 'User Disabled';
    case 'too-many-requests':
      return 'Too Many Requests, Please try again later';
    case 'network-request-failed':
      return 'Network Request Failed';
    default:
      return 'An error occurred. Please try again later.';
  }
}

bool loginValidation(String email, String password) {
  if (email.isEmpty) {
    showMessage('Fields Cannot Be Empty');
    return false;
  } else if (password.isEmpty) {
    showMessage('Fields Cannot Be Empty');
    return false;
  } else {
    return true;
  }
}

bool signUpValidation(String email, String password, String confirmPassword) {
  if (email.isNotEmpty &&
      password.isNotEmpty &&
      confirmPassword.isNotEmpty &&
      password == confirmPassword) {
    return true;
  } else if (password != confirmPassword) {
    showMessage('Passwords cannot be different');
    return false;
  } else {
    showMessage('Fields Cannot Be Empty');
    return false;
  }
}

bool fillYourProfileValidation(String name, String nickname, String dob,
    String email, String phone, String gender) {
  if (name.isNotEmpty &&
      dob.isNotEmpty &&
      email.isNotEmpty &&
      phone.isNotEmpty &&
      gender.isNotEmpty) {
    return true;
  } else {
    showMessage('Fields Cannot Be Empty');
    return false;
  }
}
