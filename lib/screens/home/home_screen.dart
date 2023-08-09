import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:funica/components/search_field.dart';
import 'package:funica/firebase_helper/firestore.dart';
import 'package:funica/models/banner_model.dart';
import 'package:funica/models/product_model.dart';
import 'package:funica/screens/home/helper/most_popular.dart';
import 'package:funica/screens/home/helper/special_offers.dart';

import 'components/banner_card.dart';
import 'components/popular_product.dart';
import 'components/see_all.dart';
import 'helper/notification.dart';
import 'package:flutter/material.dart';

import 'components/product_category.dart';
import 'helper/wishlist.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late List<Widget> _bannerList;
  bool isLoading = false;

  @override
  void initState() {
    // _bannerList = [
    //   const BannerCard(
    //     discount: '25%',
    //     period: "Today's Special!",
    //     description: 'Get discount for every order, only valid for today',
    //     image: 'assets/images/chair.png',
    //   ),
    //   const BannerCard(
    //     discount: '14%',
    //     period: "Today's Special!",
    //     description: 'Get discount for every order',
    //     image: 'assets/images/sofa.png',
    //   ),
    //   const BannerCard(
    //     discount: '',
    //     period: "Today's Special!",
    //     description: 'Find discounts for today',
    //   ),
    // ];
    getBannerList();
    super.initState();
  }

  List<BannerModel> bannerList = [];
  List<ProductModel> productList = [];

  Future<void> getBannerList() async {
    setState(() {
      isLoading = true;
    });
    bannerList = await FirebaseFirestoreService.instance.getBanners();
    productList = await FirebaseFirestoreService.instance.getProduct();
    productList.shuffle();
    setState(() {
      isLoading = false;
    });
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

  final List<Widget> _popularProduct = [
    const PopularProduct(
      productName: 'All',
    ),
    const PopularProduct(
      productName: 'Sofa',
    ),
    const PopularProduct(
      productName: 'Chair',
    ),
    const PopularProduct(
      productName: 'Table',
    ),
    const PopularProduct(
      productName: 'Kitchen',
    ),
    const PopularProduct(
      productName: 'Chair',
    ),
    const PopularProduct(
      productName: 'Chair',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    String? name =
        FirebaseAuth.instance.currentUser!.displayName ?? "Unknown User";
    final getData = FirebaseFirestore.instance.collection('users').get();

    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset('assets/images/person.png'),
                      ),
                      title: const Text(
                        'Good Morning',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black38,
                        ),
                      ),
                      subtitle: Text(
                        name,
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
                            icon: Image.asset(
                              'assets/icons/notification.png',
                              width: 28,
                              height: 28,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          const NotificationScreen()));
                            },
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => WishlistScreen()));
                            },
                            icon: Image.asset(
                              'assets/icons/favourite.png',
                              width: 32,
                              height: 35,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    const SearchField(),
                    const SizedBox(height: 25),
                    SeeAll(
                      title: 'Special Offers',
                      onClick: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => SpecialOffers()));
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
                                          child: Image.network(
                                            e.image,
                                            fit: BoxFit.cover,
                                          ),
                                        )
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => MostPopular()));
                      },
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 30,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: _popularProduct.length,
                        itemBuilder: (context, index) {
                          return _popularProduct[index];
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    productList.isEmpty
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
                            itemCount: productList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                height: 400,
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
                                              child: Image.network(
                                                productList[index].image!,
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
                                                      BorderRadius.circular(50),
                                                  color: Colors.black87.withOpacity(0.2),
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
                                            productList[index].name!,
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
                                                productList[index].rank!,
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
                                                    productList[index].sold!),
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            productList[index]
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
                          )
                  ],
                ),
              ),
            ),
    );
  }
}
