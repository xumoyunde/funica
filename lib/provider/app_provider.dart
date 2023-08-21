import 'package:flutter/cupertino.dart';
import 'package:funica/models/product_model.dart';

class AppProvider with ChangeNotifier {
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
    _cartProductList.add(productModel);
    notifyListeners();
  }

  void removeFavouriteProduct(ProductModel productModel) {
    _cartProductList.remove(productModel);
    notifyListeners();
  }

  List<ProductModel> get getFavouriteList => _cartProductList;
}
