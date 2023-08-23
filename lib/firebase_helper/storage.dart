import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  static FirebaseStorageService instance = FirebaseStorageService();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadUserImage(File image) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    TaskSnapshot taskSnapshot = await _storage.ref(uid).putFile(image).snapshot;
    String imageUrl = await taskSnapshot.ref.getDownloadURL();
    return imageUrl;
  }
}