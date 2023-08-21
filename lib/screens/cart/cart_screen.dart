import 'package:flutter/material.dart';
import 'package:funica/provider/app_provider.dart';
import 'package:funica/route/app_route.dart';
import 'package:funica/screens/cart/components/cart_item.dart';
import 'package:funica/screens/home/components/default_appbar.dart';
import 'package:funica/screens/home/helper/product_details.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);

    return Scaffold(
        body: Stack(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/icons/funica.png',
                    width: 30,
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'My Cart',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {},
                    child: const Icon(
                      Icons.search,
                      size: 30,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: appProvider.getCartProductList.isEmpty
                    ? Center(
                        child: Text('Cart is Empty'),
                      )
                    : ListView.separated(
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 10);
                        },
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: appProvider.getCartProductList.length,
                        itemBuilder: (context, index) {
                          return CartItem(
                            click: () {
                              Get.toNamed(
                                AppRoute.productDetails,
                                arguments: ProductDetails(
                                  product:
                                      appProvider.getCartProductList[index],
                                ),
                              );
                            },
                            productModel: appProvider.getCartProductList[index],
                          );
                        },
                      ),
              )
            ],
          ),
        )
      ],
    ));
  }
}
