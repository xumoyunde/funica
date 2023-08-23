import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:funica/components/loading.dart';
import 'package:funica/constants/constants.dart';
import 'package:funica/models/user_model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  // Firebase auth instance
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

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

  Future<void> signUp(String email, String password, String name) async {
    try{
      Loading(where: 'Sign Up',);
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      UserModel userModel = UserModel(id: userCredential.user!.uid, name: name, email: email, image: null);

      _firestore.collection('users').doc(userModel.id).set(userModel.toJson());
      Get.back();
    } on FirebaseAuthException catch(e){
      Get.snackbar('Sign Up ERRoR', e.code);
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
