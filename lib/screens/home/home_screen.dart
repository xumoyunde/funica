import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:funica/components/search_field.dart';
import 'package:funica/firebase_helper/firestore.dart';
import 'package:funica/models/banner_model.dart';
import 'package:funica/models/category_model.dart';
import 'package:funica/models/product_model.dart';
import 'package:funica/provider/app_provider.dart';
import 'package:funica/route/app_route.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'components/category_builder.dart';
import 'components/see_all.dart';
import 'package:flutter/material.dart';

import 'components/product_category.dart';
import 'helper/product_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  bool isLoading = false;

  @override
  void initState() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getUserInfoFirebase();
    getBannerList();
    super.initState();
  }

  List<BannerModel> bannerList = [];
  List<ProductModel> _productList = [];
  List<CategoryModel> _categoryList = [];
  List<ProductModel> _filteredProductList = [];

  // List<ColorModel> colorList = [];

  Future<void> getBannerList() async {
    setState(() {
      isLoading = true;
    });
    bannerList = await FirebaseFirestoreService.instance.getBanners();

    _categoryList = await FirebaseFirestoreService.instance.getCategory();
    _categoryList.shuffle();
    _categoryList.insert(0, CategoryModel(name: 'All', id: ''));

    _productList = await FirebaseFirestoreService.instance.getProduct();
    setState(() {
      isLoading = false;
      _filteredProductList = _productList;
    });
  }

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

  Future<void> refreshData() async {
    bannerList = await FirebaseFirestoreService.instance.getBanners();
    _productList = await FirebaseFirestoreService.instance.getProduct();
  }

  static List<Widget> list = [
    const ProductCategory(
      icon: Icon(Icons.chair),
      productName: "Sofa",
    ),
    const ProductCategory(
      icon: Icon(Icons.table_bar),
      productName: "Table",
    ),
    const ProductCategory(
      icon: Icon(Icons.kitchen),
      productName: "Kitchen",
    ),
    const ProductCategory(
      icon: Icon(Icons.laptop_mac),
      productName: "Laptop",
    ),
    const ProductCategory(
      icon: Icon(Icons.phone_android),
      productName: "Phone",
    ),
    const ProductCategory(
      icon: Icon(Icons.book),
      productName: "Book",
    ),
    const ProductCategory(
      icon: Icon(Icons.print),
      productName: "Printer",
    ),
    const ProductCategory(
      icon: Icon(Icons.more_horiz_outlined),
      productName: "Others",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // final getData = FirebaseFirestore.instance.collection('users').get();

    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GestureDetector(
              onTap: FocusScope.of(context).unfocus,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: appProvider.getUserInformation.image == null
                              ? Image.asset('assets/images/person.png')
                              : CachedNetworkImage(
                                  imageUrl:
                                      appProvider.getUserInformation.image!),
                        ),
                        title: const Text(
                          'Good Morning',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black38,
                          ),
                        ),
                        subtitle: Text(
                          appProvider.getUserInformation.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                Get.toNamed(AppRoute.notification);
                              },
                              icon: Image.asset(
                                'assets/icons/notification.png',
                                width: 28,
                                height: 28,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Get.toNamed(AppRoute.wishlist);
                              },
                              icon: Image.asset(
                                'assets/icons/favourite.png',
                                width: 28,
                                height: 26,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      SearchField(
                        onChanged: (query) {},
                        suffix: const Icon(CupertinoIcons.settings_solid),
                      ),
                      const SizedBox(height: 25),
                      SeeAll(
                        title: 'Special Offers',
                        onClick: () {
                          Get.toNamed(AppRoute.specialOffers);
                        },
                      ),
                      const SizedBox(height: 25),
                      Column(
                        children: [
                          CarouselSlider(
                            options: CarouselOptions(
                                autoPlay: true,
                                enlargeCenterPage: true,
                                aspectRatio: 18 / 8,
                                viewportFraction: 1,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _currentIndex = index;
                                  });
                                }),
                            items: bannerList
                                .map(
                                  (e) => AspectRatio(
                                    aspectRatio: 18 / 8,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25, vertical: 15),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffe7e7e8),
                                        borderRadius: BorderRadius.circular(32),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  e.discount,
                                                  style: const TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  e.period,
                                                  style: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  e.description,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                              child: CachedNetworkImage(
                                            imageUrl: e.image,
                                            placeholder: (context, url) =>
                                                const Center(
                                                    child:
                                                        CircularProgressIndicator()),
                                          ))
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: bannerList.map((e) {
                              int index = bannerList.indexOf(e);
                              return Container(
                                width: _currentIndex == index ? 20 : 6,
                                height: 6,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 2),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(29),
                                  color: _currentIndex == index
                                      ? const Color.fromRGBO(0, 0, 0, 0.9)
                                      : const Color.fromRGBO(0, 0, 0, 0.4),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemCount: list.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        // add this
                        itemBuilder: (context, index) {
                          return list[index];
                        },
                      ),
                      const SizedBox(height: 25),
                      SeeAll(
                        title: 'Most Popular',
                        onClick: () {
                          Get.toNamed(AppRoute.mostPopular);
                        },
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: 30,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) {
                            return const SizedBox(
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
                      _filteredProductList.isEmpty
                          ? const Center(
                              child: Text('Products is empty'),
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 30,
                                childAspectRatio: 8 / 14,
                                mainAxisExtent: 300,
                              ),
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
                                  child: SizedBox(
                                    height: 400,
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
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        _filteredProductList[
                                                                index]
                                                            .image,
                                                    fit: BoxFit.contain,
                                                    width: 200,
                                                    height: 200,
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
                                                      color: Colors.black87
                                                          .withOpacity(0.2),
                                                    ),
                                                    child: Center(
                                                      child: InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            _filteredProductList[
                                                                        index]
                                                                    .isFavourite =
                                                                !_filteredProductList[
                                                                        index]
                                                                    .isFavourite;
                                                          });
                                                          if (_filteredProductList[
                                                                  index]
                                                              .isFavourite) {
                                                            appProvider
                                                                .addFavouriteProduct(
                                                                    _filteredProductList[
                                                                        index]);
                                                          } else {
                                                            appProvider
                                                                .removeFavouriteProduct(
                                                                    _filteredProductList[
                                                                        index]);
                                                          }
                                                          print(
                                                              _filteredProductList[
                                                                      index]
                                                                  .isFavourite);
                                                        },
                                                        child: Image.asset(
                                                          _filteredProductList[
                                                                      index]
                                                                  .isFavourite
                                                              ? 'assets/icons/favourite_red.png'
                                                              : 'assets/icons/favourite.png',
                                                          width: 20,
                                                        ),
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
                                                _filteredProductList[index]
                                                    .name,
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
                                                      color:
                                                          Colors.grey.shade800,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(6),
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xffe7e7e8),
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
                                                    .price
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
                            ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
