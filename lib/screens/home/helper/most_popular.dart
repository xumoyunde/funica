import 'package:flutter/material.dart';
import 'package:funica/firebase_helper/firestore.dart';
import 'package:funica/models/category_model.dart';
import 'package:funica/models/product_model.dart';
import 'package:funica/screens/home/components/default_appbar.dart';
import 'package:funica/screens/home/components/popular_product.dart';
import 'package:funica/screens/home/components/product.dart';

class MostPopular extends StatefulWidget {
  MostPopular({super.key});

  @override
  State<MostPopular> createState() => _MostPopularState();
}

class _MostPopularState extends State<MostPopular> {
  @override
  void initState() {
    getCategoryList();
    super.initState();
  }

  List<ProductModel> productList = [];
  List<CategoryModel> categoryList = [];

  bool isLoading = false;

  Future<void> getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    categoryList = await FirebaseFirestoreService.instance.getCategory();
    productList = await FirebaseFirestoreService.instance.getProduct();
    setState(() {
      isLoading = false;
    });
  }

  final List<Map<String, dynamic>> product = [
    {
      "title": "Shiny Wooden Chair",
      "rank": "4.6",
      "sold": "6.641 sold",
      "price": "\$115.00"
    },
    {
      "title": "Bedroom Lamp",
      "rank": "4.8",
      "sold": "7.461 sold",
      "price": "\$40.00"
    },
    {
      "title": "Marble Flower Vase",
      "rank": "4.8",
      "sold": "6.378 sold",
      "price": "\$90.00"
    },
    {
      "title": "Knife Package",
      "rank": "4.5",
      "sold": "5.372 sold",
      "price": "\$125.00"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Column(
                children: [
                  const DefaultAppBar(
                    title: 'Most Popular',
                    trailing: Icon(Icons.search),
                  ),
                  SizedBox(
                    height: 30,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: categoryList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 24,
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(36),
                            border: Border.all(color: Colors.black, width: 1.5),
                          ),
                          child: Center(
                            child: Text(
                              categoryList[index].name,
                              style: const TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: productList.isEmpty
                        ? const Center(
                            child: Text('Products is empty'),
                          )
                        : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 20,
                                    crossAxisSpacing: 30,
                                    childAspectRatio: 8 / 12),
                            itemCount: productList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffe7e7e8),
                                        borderRadius: BorderRadius.circular(12),
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
                                                borderRadius: BorderRadius.circular(50),
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
                                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                          mainAxisAlignment: MainAxisAlignment.start,
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
                                              padding: const EdgeInsets.all(6),
                                              decoration: BoxDecoration(
                                                color: const Color(0xffe7e7e8),
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                              child: Text(productList[index].sold!),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          productList[index].price!.toString(),
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
