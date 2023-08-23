import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funica/firebase_helper/auth_controller.dart';
import 'package:funica/firebase_helper/storage.dart';
import 'package:funica/models/user_model.dart';
import 'package:funica/provider/app_provider.dart';
import 'package:funica/route/app_route.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'components/my_list_tile.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // String? _image;
  bool light = true;
  File? image;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // app bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/icons/funica.png',
                    width: 30,
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Center(
                        child: Icon(Icons.more_horiz_outlined),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // profile image
              Stack(
                children: [
                  image != null
                      ? CircleAvatar(
                          radius: 70,
                          backgroundImage: FileImage(image!),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.height * .3),
                          child: Image.asset(
                            'assets/images/person.png',
                            width: 120,
                          ),
                        ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    width: 30,
                    height: 30,
                    child: MaterialButton(
                      padding: const EdgeInsets.only(left: 2),
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
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // user name
              Text(
                appProvider.getUserInformation.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),

              // user email
              Text(
                appProvider.getUserInformation.email,
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              Divider(height: 30),
              MyListTile(
                title: 'Edit Profile',
                leading: Icon(Icons.person_outline),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              MyListTile(
                title: 'Address',
                leading: Icon(Icons.location_on_outlined),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              MyListTile(
                title: 'Notification',
                leading: Icon(Icons.notifications_none),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              MyListTile(
                title: 'Payment',
                leading: Icon(Icons.payments_outlined),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              MyListTile(
                title: 'Security',
                leading: Icon(Icons.security_outlined),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              MyListTile(
                title: 'Language',
                leading: Icon(Icons.language_outlined),
                subTitle: 'English(US)',
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              MyListTile(
                click: () {},
                title: 'Dark Mode',
                leading: Icon(Icons.remove_red_eye_outlined),
                trailing: SizedBox(
                  height: 10,
                  child: Switch(
                    // This bool value toggles the switch.
                    value: light,
                    activeColor: Colors.red,
                    onChanged: (bool value) {
                      // This is called when the user toggles the switch.
                      setState(() {
                        light = value;
                      });
                    },
                  ),
                ),
              ),
              MyListTile(
                title: 'Privacy Policy',
                leading: Icon(Icons.lock_outline),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              MyListTile(
                title: 'Help Center',
                leading: Icon(Icons.data_usage),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              MyListTile(
                title: 'Invite Friends',
                leading: Icon(CupertinoIcons.person_3),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              MyListTile(
                click: () {
                  AuthController().signOut();
                  Get.toNamed(AppRoute.login);
                },
                title: 'Logout',
                leading: Icon(
                  Icons.logout,
                  color: Colors.redAccent,
                ),
                trailing: null,
                color: Colors.redAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void takePicture(ImageSource source) async {
    XFile? value =
        await ImagePicker().pickImage(source: source, imageQuality: 40);
    if (value != null) {
      setState(() {
        image = File(value.path);
      });
    }
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
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * .03,
              bottom: MediaQuery.of(context).size.height * .1),
          children: [
            // title
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
                // image in gallery
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20),
                      shape: const CircleBorder(),
                      backgroundColor: Colors.white,
                      fixedSize: Size(MediaQuery.of(context).size.width * .3,
                          MediaQuery.of(context).size.height * .15)),
                  onPressed: () async {
                    // final ImagePicker picker = ImagePicker();
                    // final XFile? image = await picker.pickImage(
                    //     source: ImageSource.gallery, imageQuality: 80);
                    // if (image != null) {
                    //   setState(() {
                    //     _image = image.path;
                    //   });
                    //   Navigator.pop(context);
                    // }

                    takePicture(ImageSource.gallery);
                    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
                    UserModel userModel = appProvider.getUserInformation;
                    appProvider.updateUserInfoFirebase(userModel, image);
                    Get.snackbar("Update", "Successfully updated profile image",
                        backgroundColor: Colors.blueAccent,
                        colorText: Colors.white);
                    print("succesfully image update");
                  },
                  child: Image.asset(
                    'assets/icons/add_image.png',
                  ),
                ),

                // image with camera
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20),
                      shape: const CircleBorder(),
                      backgroundColor: Colors.white,
                      fixedSize: Size(MediaQuery.of(context).size.width * .3,
                          MediaQuery.of(context).size.height * .15)),
                  onPressed: () async {
                    takePicture(ImageSource.camera);
                  },
                  child: Image.asset(
                    'assets/icons/camera.png',
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
