import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:funica/components/loading.dart';
import 'package:funica/constants/constants.dart';
import 'package:funica/route/app_route.dart';
import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // You can handle the sign-in success here if needed.
      print('Sign-in successful: ${userCredential.user!.uid}');
    } catch (e) {
      // Handle sign-in errors here.
      print('Sign-in error: $e');
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // You can handle the sign-in success here if needed.
      print('Sign-in successful: ${userCredential.user!.uid}');
    } catch (e) {
      // Handle sign-in errors here.
      print('Sign-in error: $e');
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

