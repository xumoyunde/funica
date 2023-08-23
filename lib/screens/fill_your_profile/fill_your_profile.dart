import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:funica/components/my_button.dart';
import 'package:funica/components/my_textfield.dart';
import 'package:funica/constants/constants.dart';
import 'package:funica/firebase_helper/auth_controller.dart';
import 'package:funica/screens/dashboard/dashboard_screen.dart';
import 'package:funica/screens/fill_your_profile/components/default_appbar.dart';
import 'package:funica/screens/fill_your_profile/create_new_pin.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../main.dart';

class FillYourProfile extends StatefulWidget {
  final String email;
  final String password;

  const FillYourProfile(
      {super.key, required this.email, required this.password});

  @override
  State<FillYourProfile> createState() => _FillYourProfileState();
}

class _FillYourProfileState extends State<FillYourProfile> {
  String? _image;

  String dropdownValue = "Male";

  final _nameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _dobController = TextEditingController();
  final _phoneController = TextEditingController();
  final _genderController = TextEditingController();
  final _emailController = TextEditingController();

  void signUp(BuildContext context) {
    DateTime? dob;
    if (_dobController.text.isNotEmpty) {
      dob = DateTime.tryParse(_dobController.text);
    }

    // Store user details in Firestore database
    FirebaseFirestore.instance.collection('users').doc().set({
      'name': _nameController.text,
      'nickname': _nicknameController.text,
      'dob': dob,
      'email': _emailController.text,
      'phone': _phoneController.text,
      'gender': _genderController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: kToolbarHeight, right: 20, left: 20),
          child: Column(
            children: [
              const DefaultAppbar(
                icon: Icon(Icons.arrow_back),
                title: "Fill Your Profile",
              ),
              const SizedBox(height: 20),

              // Profile image
              Stack(
                children: [
                  _image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * .3),
                          child: Image.file(
                            File(_image!),
                            width: MediaQuery.of(context).size.height * .2,
                            height: MediaQuery.of(context).size.height * .2,
                            fit: BoxFit.cover,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * .3),
                          child: Image.asset(
                            'assets/images/person.png',
                            width: 200,
                          ),
                        ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    width: 40,
                    child: MaterialButton(
                      padding: const EdgeInsets.only(left: 5),
                      elevation: 1,
                      onPressed: () {
                        _showBottomSheet();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      color: Colors.black,
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // Full name text field
              TextFieldWithSuffix(
                title: "Full Name",
                controller: _nameController,
              ),
              const SizedBox(height: 18),

              // Nickname text field
              TextFieldWithSuffix(
                title: "Nickname",
                controller: _nicknameController,
              ),
              const SizedBox(height: 18),

              TextFieldWithSuffix(
                title: 'Date of Birth',
                icon: Icon(Icons.date_range),
                controller: _dobController,
              ),
              const SizedBox(height: 18),

              TextFieldWithSuffix(
                title: 'Email',
                icon: Icon(Icons.email_outlined),
                controller: _emailController,
              ),
              const SizedBox(height: 18),

              PhoneNumberField(
                controller: _phoneController,
              ),
              const SizedBox(height: 18),

              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xfff5f5f5),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      spreadRadius: 2,
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                        _genderController.text = newValue;
                      });
                    },
                    items: <String>["Male", "Female", "Other"]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 18),

              MyButton(
                title: "Continue",
                onTap: () {
                  try {
                    if (_nameController.text.isNotEmpty &&
                        _nicknameController.text.isNotEmpty &&
                        _dobController.text.isNotEmpty &&
                        _emailController.text.isNotEmpty &&
                        _phoneController.text.isNotEmpty &&
                        _genderController.text.isNotEmpty &&
                        _emailController.text.trim() == widget.email) {
                      AuthController authController = AuthController();
                      authController.signUp(_emailController.text.trim(),
                          widget.password, _nameController.text.trim());
                    } else {
                      showMessage(
                          'Passwords do not match or validation failed');
                    }
                  } on FirebaseAuthException catch (e) {
                    showMessage(e.code.toString());
                  }
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * .03, bottom: MediaQuery.of(context).size.height * .1),
            children: [
              const Text(
                'Profil rasmini tanlang',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(20),
                        shape: const CircleBorder(),
                        backgroundColor: Colors.white,
                        fixedSize: Size(MediaQuery.of(context).size.width * .3, MediaQuery.of(context).size.height * .15)),
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? image = await picker.pickImage(
                          source: ImageSource.gallery, imageQuality: 80);
                      if (image != null) {
                        log('Image Path: ${image.path} -- MimeType: ${image.mimeType}');
                        setState(() {
                          _image = image.path;
                        });
                        Navigator.pop(context);
                      }
                    },
                    child: Image.asset(
                      'assets/icons/add_image.png',
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(20),
                        shape: const CircleBorder(),
                        backgroundColor: Colors.white,
                        fixedSize: Size(MediaQuery.of(context).size.width * .3, MediaQuery.of(context).size.height * .15)),
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? image = await picker.pickImage(
                          source: ImageSource.camera, imageQuality: 80);
                      if (image != null) {
                        log('Image Path: ${image.path}');
                        setState(() {
                          _image = image.path;
                        });
                        Navigator.pop(context);
                      }
                    },
                    child: Image.asset(
                      'assets/icons/camera.png',
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }
}
