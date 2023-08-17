import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funica/firebase_helper/firestore.dart';
import 'package:funica/models/category_model.dart';
import 'package:funica/models/product_model.dart';
import 'package:funica/route/app_route.dart';
import 'package:funica/screens/home/components/default_appbar.dart';
import 'package:get/get.dart';

import 'product_details.dart';

class MostPopular extends StatefulWidget {
  const MostPopular({super.key});

  @override
  State<MostPopular> createState() => _MostPopularState();
}

class _MostPopularState extends State<MostPopular> {
  @override
  void initState() {
    getCategoryList();
    _foundProduct = productList;
    super.initState();
  }

  // This list holds the data for the list view
  List<CategoryModel> categoryList = [];
  List<ProductModel> productList = [];
  List<CategoryModel> _foundCategory = [];
  List<ProductModel> _foundProduct = [];

  bool isLoading = false;

  Future<void> getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    categoryList = await FirebaseFirestoreService.instance.getCategory();
    productList = await FirebaseFirestoreService.instance.getProduct();
    setState(() {
      isLoading = false;
      _foundCategory = categoryList;
      _foundProduct = productList;
      // _filterProduct('mac');
    });
  }

  // This function is called whenever the text field changes
  void _filterCategory(String enteredKeyword) {
    setState(() {
      isLoading = true;
    });
    List<CategoryModel> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = categoryList;
    } else {
      results = categoryList
          .where((user) =>
              user.name!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
      setState(() {
        isLoading = false;
      });
    }

    // Refresh the UI
    setState(() {
      _foundCategory = results;
    });
  }

  // This function is called whenever the text field changes
  void _filterProduct(String enteredKeyword) {
    List<ProductModel> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = productList;
    } else {
      results = productList
          .where((user) =>
              user.name!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundProduct = results;
    });
  }

  Future<void> refreshCategoryList() async {
    categoryList = await FirebaseFirestoreService.instance.getCategory();
    productList = await FirebaseFirestoreService.instance.getProduct();
  }

  bool isSearch = false;

  bool isPressed = false;

  void _onTap(int index) {
    setState(() {
      isPressed = !isPressed;
      _filterCategory(categoryList[index].name);
      _filterProduct(_foundProduct[index].name!);
    });
    print(categoryList[index].name);
  }

  @override
  Widget build(BuildContext context) {
    Color containerColor = isPressed ? Colors.black : Colors.white;
    Color textColor = isPressed ? Colors.white : Colors.black;

    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () async {
                await refreshCategoryList();
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                child: Column(
                  children: [
                    DefaultAppBar(
                      title: 'Most Popular',
                      trailing: InkWell(
                        onTap: () {
                          Get.toNamed(AppRoute.searchLayout);
                        },
                        child: const Icon(Icons.search),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 30,
                      child: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ListView.separated(
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  width: 8,
                                );
                              },
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemCount: categoryList.length,
                              itemBuilder: (context, index) {
                                return Categories(
                                  productName: categoryList[index].name,
                                  click: () {
                                    setState(() {
                                      _foundCategory[index].name;
                                    });
                                    print(_foundCategory[index].name);
                                    print(categoryList[index].name);
                                    print(_foundProduct[index].name);
                                  },
                                );
                              },
                            ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: _foundProduct.isEmpty
                          ? const Center(
                              child: Text('Products is empty'),
                            )
                          : GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 20,
                                      crossAxisSpacing: 30,
                                      childAspectRatio: 8 / 14),
                              itemCount: _foundProduct.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.toNamed(
                                      AppRoute.productDetails,
                                      arguments: ProductDetails(
                                        product: _foundProduct,
                                        index: index,
                                      ),
                                    );
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: const Color(0xffe7e7e8),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Stack(
                                            children: [
                                              Center(
                                                child: Hero(
                                                  tag: _foundProduct[index]
                                                      .image!,
                                                  child: Image.network(
                                                    _foundProduct[index].image!,
                                                    fit: BoxFit.contain,
                                                    width: 200,
                                                    height: 200,
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Container(
                                                  width: 36,
                                                  height: 36,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    color: Colors.black87,
                                                  ),
                                                  child: const Center(
                                                    child: Icon(
                                                      Icons.favorite,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _foundProduct[index].name!,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Icon(Icons.star_half),
                                                Text(
                                                  _foundProduct[index].rank!,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey.shade800,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(6),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xffe7e7e8),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                  ),
                                                  child: Text(
                                                      _foundProduct[index]
                                                          .sold!),
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              _foundProduct[index]
                                                  .price!
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

class Categories extends StatefulWidget {
  final String productName;
  final Function() click;

  const Categories({
    super.key,
    required this.productName,
    required this.click,
  });

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  bool isPressed = false;

  void _onTap() {
    setState(() {
      isPressed = !isPressed;
    });
    widget.click();
  }

  @override
  Widget build(BuildContext context) {
    Color containerColor = isPressed ? Colors.black : Colors.white;
    Color textColor = isPressed ? Colors.white : Colors.black;

    return GestureDetector(
      onTap: _onTap,
      child: Container(
        height: 24,
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(36),
          border: Border.all(color: Colors.black, width: 1.5),
        ),
        child: Center(
          child: Text(
            widget.productName,
            style: TextStyle(
              fontSize: 17,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
