import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:funica/firebase_helper/firestore.dart';
import 'package:funica/firebase_helper/storage.dart';
import 'package:funica/models/product_model.dart';
import 'package:funica/models/user_model.dart';

class AppProvider with ChangeNotifier {
  late UserModel _userModel;

  UserModel get getUserInformation => _userModel;

  //************** ITEM CART **************//
  List<ProductModel> _cartProductList = [];

  void addCartProduct(ProductModel productModel) {
    _cartProductList.add(productModel);
    notifyListeners();
  }

  void removeCartProduct(ProductModel productModel) {
    _cartProductList.remove(productModel);
    notifyListeners();
  }

  List<ProductModel> get getCartProductList => _cartProductList;

  //************** FAVORITE **************//
  List<ProductModel> _favouriteList = [];

  void addFavouriteProduct(ProductModel productModel) {
    _favouriteList.add(productModel);
    notifyListeners();
  }

  void removeFavouriteProduct(ProductModel productModel) {
    _favouriteList.remove(productModel);
    notifyListeners();
  }

  List<ProductModel> get getFavouriteList => _favouriteList;

  void getUserInfoFirebase() async {
    _userModel = await FirebaseFirestoreService.instance.getUserInformation();
    notifyListeners();
  }

  void updateUserInfoFirebase(UserModel userModel, File? file) async {
    if (file == null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userModel.id)
          .set(userModel.toJson());
    } else {
      String imageUrl =
          await FirebaseStorageService.instance.uploadUserImage(file);
      _userModel = userModel.copyWith(image: imageUrl);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_userModel!.id)
          .set(_userModel!.toJson());
      notifyListeners();
    }
  }
}
