import 'package:flutter/material.dart';
import 'package:funica/models/product_model.dart';
import 'package:funica/provider/app_provider.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CartItem extends StatefulWidget {
  final ProductModel productModel;
  final Function() click;

  const CartItem({super.key, required this.productModel, required this.click});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  double qty = 0;

  @override
  void initState() {
    qty = widget.productModel.qty ?? 0;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ProductModel product = widget.productModel;

    return GestureDetector(
      onTap: widget.click,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.network(
                  widget.productModel.image,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.productModel.name,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            AppProvider appProvider = Provider.of<AppProvider>(
                                context,
                                listen: false);
                            appProvider.removeCartProduct(product);
                            Get.snackbar('Message', 'Removed from Cart',
                                backgroundColor: Colors.redAccent,
                                colorText: Colors.white);
                          },
                          child: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          width: 17,
                          height: 17,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.blueGrey,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Blue Grey',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$${widget.productModel.price}",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xfff4f4f4),
                          ),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  if (qty > 0) {
                                    setState(() {
                                      qty--;
                                    });
                                  }
                                },
                                child: const Icon(Icons.remove),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                NumberFormat('00').format(qty),
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 10),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    qty++;
                                  });
                                },
                                child: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
