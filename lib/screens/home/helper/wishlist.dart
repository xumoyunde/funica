import 'package:flutter/material.dart';
import 'package:funica/screens/home/components/default_appbar.dart';
import 'package:funica/screens/home/components/popular_product.dart';
import 'package:funica/screens/home/components/product.dart';

class WishlistScreen extends StatelessWidget {
  WishlistScreen({super.key});

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
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 30,
                    childAspectRatio: 8 / 12),
                itemCount: product.length,
                itemBuilder: (BuildContext context, int index) {
                  return Product(
                    title: product[index]['title'],
                    sold: product[index]['sold'],
                    rank: product[index]['rank'] + ' |',
                    price: product[index]['price'],
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
