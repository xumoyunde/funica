import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:funica/constants/constants.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  // Firebase auth instance
  final _auth = FirebaseAuth.instance;

  // User stream
  Stream<User?> get user => _auth.authStateChanges();

  // User id
  String? get userId => _auth.currentUser?.uid;

  // Is logged in
  var isLogged = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Listen to user stream and update isLogged value
    user.listen((User? user) {
      if (user == null) {
        isLogged.value = false;
      } else {
        isLogged.value = true;
      }
    });
  }

  // Sign in with email and password
  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      isLogged.value = true;
    } catch (e) {
      // Handle errors
      print(e);
      // Get the error code from the exception
      String errorCode = e.hashCode.toString();
      // Get the error message from the function
      String errorMessage = getMessageFromErrorCode(errorCode);
      // Show the error message on the screen
      Get.snackbar('Error', errorMessage, backgroundColor: Colors.redAccent, colorText: Colors.black);
    }
  }


  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      isLogged.value = false;
    } catch (e) {
      // Handle errors
      print(e);
    }
  }


}
