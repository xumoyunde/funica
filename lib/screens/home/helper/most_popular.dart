import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funica/firebase_helper/firestore.dart';
import 'package:funica/models/category_model.dart';
import 'package:funica/models/product_model.dart';
import 'package:funica/route/app_route.dart';
import 'package:funica/screens/home/components/category_builder.dart';
import 'package:funica/screens/home/components/default_appbar.dart';
import 'package:get/get.dart';

import 'product_details.dart';

class MostPopular extends StatefulWidget {
  const MostPopular({super.key});

  @override
  State<MostPopular> createState() => _MostPopularState();
}

class _MostPopularState extends State<MostPopular> {
  List<CategoryModel> _categoryList = [];
  List<ProductModel> _productList = [];
  List<ProductModel> _filteredProductList = [];

  bool isLoading = false;

  Future<void> getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    _categoryList = await FirebaseFirestoreService.instance.getCategory();
    _categoryList.shuffle();
    _categoryList.insert(0, CategoryModel(name: 'All', id: ''));

    _productList = await FirebaseFirestoreService.instance.getProduct();
    setState(() {
      isLoading = false;
      _filteredProductList = _productList;
    });
  }

  @override
  void initState() {
    getCategoryList();
    super.initState();
  }

  bool isPressed = false;

  String selectedCategory = 'All';

  // This function is called whenever the category is selected
  void filterProductsByCategory(String enteredKeyword) {
    setState(() {
      isLoading = true;
    });
    List<ProductModel> products = [];
    if (enteredKeyword == 'All') {
      // if the keyword is 'All', show all products
      products = _productList;
      setState(() {
        isLoading = false;
      });
    } else {
      // otherwise, filter by category id
      products = _productList
          .where((product) => product.category == enteredKeyword)
          .toList();
      setState(() {
        isLoading = false;
      });
    }

    // Refresh the UI
    setState(() {
      _filteredProductList = products;
    });
  }

  Future<void> refreshCategoryList() async {
    setState(() {
      isLoading = true;
    });

    _categoryList.clear();
    _productList.clear();
    _filteredProductList.clear();

    _categoryList = await FirebaseFirestoreService.instance.getCategory();
    _categoryList.insert(0, CategoryModel(name: 'All', id: ''));
    _productList = await FirebaseFirestoreService.instance.getProduct();

    setState(() {
      isLoading = false;
    _filteredProductList = _productList;
    });
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
                    // This is the list view where you display the categories
                    SizedBox(
                      height: 30,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 8,
                          );
                        },
                        itemCount: _categoryList.length,
                        itemBuilder: (context, index) {
                          return CategoryBuilder(
                            name: _categoryList[index].name,
                            selectedCategory: selectedCategory,
                            click: () {
                              filterProductsByCategory(
                                  _categoryList[index].name);
                              setState(() {
                                selectedCategory = _categoryList[index].name;
                              });
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: _filteredProductList.isEmpty
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
                              itemCount: _filteredProductList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.toNamed(
                                      AppRoute.productDetails,
                                      arguments: ProductDetails(
                                        product: _filteredProductList[index],
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
                                                  tag: _filteredProductList[
                                                          index]
                                                      .image!,
                                                  child: Image.network(
                                                    _filteredProductList[index]
                                                        .image!,
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
                                              _filteredProductList[index].name!,
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
                                                  _filteredProductList[index]
                                                      .rank!,
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
                                                      _filteredProductList[
                                                              index]
                                                          .sold!),
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              _filteredProductList[index]
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
