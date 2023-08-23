import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:funica/constants/constants.dart';
import 'package:funica/models/banner_model.dart';
import 'package:funica/models/category_model.dart';
import 'package:funica/models/color_model.dart';
import 'package:funica/models/product_model.dart';
import 'package:funica/models/user_model.dart';

class FirebaseFirestoreService {
  static FirebaseFirestoreService instance = FirebaseFirestoreService();

  // Get a reference to the Firestore instance
  final _firestore = FirebaseFirestore.instance;

  Future<List<BannerModel>> getBanners() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('banners').get();

      List<BannerModel> bannerList =
          snapshot.docs.map((e) => BannerModel.fromJson(e.data())).toList();
      return bannerList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<List<CategoryModel>> getCategory() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('category').get();

      List<CategoryModel> categoryList =
          snapshot.docs.map((e) => CategoryModel.fromJson(e.data())).toList();
      return categoryList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<UserModel> getUserInformation() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
    await _firestore.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();

    return UserModel.fromJson(snapshot.data()!);
  }

  Future<List<ProductModel>> getProduct() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
      await _firestore.collectionGroup('product').get();

      List<ProductModel> productList =
      snapshot.docs.map((e) => ProductModel.fromJson(e.data())).toList();
      return productList;
    } catch (e) {
      showMessage(e.toString());
      print(e);
      return [];
    }
  }


  // Future<List<ColorModel>> getColor() async {
  //   try {
  //
  //     QuerySnapshot<Map<String, dynamic>> snapshot =
  //     await _firestore.collection('color').get();
  //
  //     List<ColorModel> colorList =
  //     snapshot.docs.map((e) => ColorModel.fromJson(e.data())).toList();
  //     return colorList;
  //   } catch (e) {
  //     showMessage(e.toString());
  //     return [];
  //   }
  // }
}
