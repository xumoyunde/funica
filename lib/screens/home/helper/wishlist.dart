import 'package:flutter/material.dart';
import 'package:funica/firebase_helper/firestore.dart';
import 'package:funica/models/category_model.dart';
import 'package:funica/models/product_model.dart';
import 'package:funica/provider/app_provider.dart';
import 'package:funica/screens/home/components/category_builder.dart';
import 'package:funica/screens/home/components/default_appbar.dart';
import 'package:funica/screens/home/components/product.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {



  @override
  Widget build(BuildContext context) {
    // _categoryList.add(CategoryModel(name: 'All', id: ''));

    AppProvider appProvider = Provider.of<AppProvider>(context);

    bool isFavourite = false;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            DefaultAppBar(
              title: 'My Wishlist',
              trailing: InkWell(
                child: const Icon(Icons.search),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 25),
            // SizedBox(
            //   height: 30,
            //   child: ListView.builder(
            //     scrollDirection: Axis.horizontal,
            //     physics: const BouncingScrollPhysics(),
            //     itemCount: _categoryList.length,
            //     itemBuilder: (context, index) {
            //       return CategoryBuilder(
            //           name: _categoryList[index].name,
            //           selectedCategory: selectedCategory,
            //           click: () {
            //             filterProductsByCategory(_categoryList[index].name);
            //             setState(() {
            //               selectedCategory = _categoryList[index].name;
            //             });
            //           });
            //     },
            //   ),
            // ),
            Expanded(
              child: GridView.builder(
                physics: BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 30,
                    childAspectRatio: 8 / 12),
                itemCount: appProvider.getFavouriteList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Product(
                    favouriteClick: (){
                      setState(() {
                        appProvider.getFavouriteList[index].isFavourite =
                        !appProvider.getFavouriteList[index].isFavourite;
                      });
                      if (appProvider.getFavouriteList[index].isFavourite == false) {
                        appProvider.removeFavouriteProduct(appProvider.getFavouriteList[index]);
                      }
                      print(appProvider.getFavouriteList[index].isFavourite);
                    },
                    product: appProvider.getFavouriteList[index],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
