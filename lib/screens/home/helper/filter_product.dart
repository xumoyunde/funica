import 'package:flutter/material.dart';
import 'package:funica/firebase_helper/firestore.dart';
import 'package:funica/models/product_model.dart';
import 'package:funica/route/app_route.dart';
import 'package:funica/screens/home/components/default_appbar.dart';
import 'package:get/get.dart';

import 'product_details.dart';

class FilterProduct extends StatefulWidget {
  final String productName;
  const FilterProduct({super.key, required this.productName});

  @override
  State<FilterProduct> createState() => _FilterProductState();
}

class _FilterProductState extends State<FilterProduct> {
  bool isLoading = false;

  // This list holds the data for the list view
  List<ProductModel> _foundProduct = [];

  @override
  void initState() {
    getProductList();
    _foundProduct = productList;
    super.initState();
  }

  List<ProductModel> productList = [];

  Future<void> getProductList() async {
    setState(() {
      isLoading = true;
    });

    productList = await FirebaseFirestoreService.instance.getProduct();

    setState(() {
      isLoading = false;
      _foundProduct = productList;
      _runFilter('productName');
    });
  }



  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _foundProduct.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Products is empty'),
                      ElevatedButton(onPressed: (){
                        // print(filterProduct);
                        print(_foundProduct);
                      }, child: const Text("Click me"),),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
                  child: Column(
                    children: [
                      DefaultAppBar(
                        title: 'Filtered',
                        trailing: InkWell(
                          onTap: () {
                          },
                          child: const Icon(Icons.search),
                        ),
                      ),
                      Expanded(
                        child: _foundProduct.isNotEmpty ? GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 30,
                            childAspectRatio: 8 / 14,
                            mainAxisExtent: 300,
                          ),
                          itemCount: _foundProduct.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                  AppRoute.productDetails,
                                  arguments: ProductDetails(
                                      product: _foundProduct, index: index),
                                );
                              },
                              child: SizedBox(
                                height: 800,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                tag: _foundProduct[index].image!,
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
                                                      BorderRadius.circular(50),
                                                  color: Colors.black87
                                                      .withOpacity(0.2),
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
                                                      BorderRadius.circular(6),
                                                ),
                                                child: Text(
                                                    _foundProduct[index].sold!),
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
                              ),
                            );
                          },
                        ) : const Text(
                          'No results found',
                          style: TextStyle(fontSize: 24),
                        ),
                      )
                    ],
                  ),
                ),
    );
  }
}
