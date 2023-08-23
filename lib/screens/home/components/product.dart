import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:funica/models/product_model.dart';
import 'package:funica/route/app_route.dart';
import 'package:funica/screens/home/helper/product_details.dart';
import 'package:get/route_manager.dart';

class Product extends StatelessWidget {
  final ProductModel product;
  final Function() favouriteClick;
  const Product({
    super.key,
    required this.product, required this.favouriteClick,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        Get.toNamed(AppRoute.productDetails, arguments: ProductDetails(product: product));
      },
      child: Column(
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
                    child: Hero(
                      tag: product.image,
                      child: CachedNetworkImage(
                        imageUrl: product.image,
                        fit: BoxFit.contain,
                        width: 200,
                        height: 200,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: favouriteClick,
                      child: Container(
                        padding: EdgeInsets.all(6),
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.black87
                              .withOpacity(0.2),
                        ),
                        child: Center(
                          child: Image.asset('assets/icons/favourite_red.png',),
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
                Expanded(
                  child: Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.star_half),
                    Text(
                      product.rank!,
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
                      child: Text(product.sold!),
                    )
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  product.price.toString(),
                  style: TextStyle(
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
  }
}
