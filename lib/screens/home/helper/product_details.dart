import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:funica/components/my_button.dart';
import 'package:funica/models/product_model.dart';
import 'package:funica/provider/app_provider.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'dart:math' as math;

class ProductDetails extends StatefulWidget {
  final List<ProductModel> product;
  final int index;
  const ProductDetails({super.key, required this.product, required this.index});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int _currentIndex = 0;
  int qty = 0;
  int selectedColor = 0;


  @override
  Widget build(BuildContext context) {
    final String image = widget.product[widget.index].image!;
    final String name = widget.product[widget.index].name!;
    final String rank = widget.product[widget.index].rank!;
    final String sold = widget.product[widget.index].sold!;
    final String description = widget.product[widget.index].description!;
    bool isFavourite = widget.product[widget.index].isFavourite!;
    final ProductModel product = widget.product[widget.index];
    // final List<ColorModel> color = widget.product[widget.index].color!;

    return Scaffold(
      backgroundColor: const Color(0xfff4f4f4),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 20.0, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back),
              ),
              Column(
                children: [
                  Hero(
                    tag: image,
                    child: CarouselSlider(
                      items: widget.product
                          .map((e) => Image.network(image))
                          .toList(),
                      options: CarouselOptions(
                          viewportFraction: 1,
                          aspectRatio: 16 / 9,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          }),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              name,
                              softWrap: true,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                widget.product[widget.index].isFavourite =
                                    !widget.product[widget.index].isFavourite!;
                              });
                              print(isFavourite);
                            },
                            icon: Image.asset(
                              isFavourite
                                  ? 'assets/icons/favourite_red.png'
                                  : 'assets/icons/favourite.png',
                              width: 30,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: const Color(0xffe7e7e8),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              sold,
                            ),
                          ),
                          const SizedBox(width: 20),
                          const Icon(Icons.star_half),
                          const SizedBox(width: 5),
                          Text(
                            rank,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                      const Divider(height: 20),
                      // const SizedBox(height: 20),
                      const Text(
                        'Description',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      ReadMoreText(
                        trimLines: 2,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'View more',
                        trimExpandedText: 'View less',
                        description,
                        moreStyle: const TextStyle(fontWeight: FontWeight.bold),
                        lessStyle: const TextStyle(fontWeight: FontWeight.bold),
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Color',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      // Row(
                      //   children: [
                      //     Container(
                      //       width: 36,
                      //       height: 36,
                      //       decoration: BoxDecoration(
                      //         color: Colors.lightBlue,
                      //         borderRadius: BorderRadius.circular(50),
                      //       ),
                      //     ),
                      //     const SizedBox(width: 10),
                      //     Container(
                      //       width: 36,
                      //       height: 36,
                      //       decoration: BoxDecoration(
                      //         color: Colors.pink,
                      //         borderRadius: BorderRadius.circular(50),
                      //       ),
                      //     ),
                      //     const SizedBox(width: 10),
                      //     Container(
                      //       width: 36,
                      //       height: 36,
                      //       decoration: BoxDecoration(
                      //         color: Colors.deepOrangeAccent,
                      //         borderRadius: BorderRadius.circular(50),
                      //       ),
                      //     ),
                      //     const SizedBox(width: 10),
                      //     Container(
                      //       width: 36,
                      //       height: 36,
                      //       decoration: BoxDecoration(
                      //         color: Colors.teal,
                      //         borderRadius: BorderRadius.circular(50),
                      //       ),
                      //     ),
                      //     const SizedBox(width: 10),
                      //     Container(
                      //       width: 36,
                      //       height: 36,
                      //       decoration: BoxDecoration(
                      //         color: Colors.orange,
                      //         borderRadius: BorderRadius.circular(50),
                      //       ),
                      //     ),
                      //   ],
                      // ),

                      SizedBox(
                        height: 40,
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return const SizedBox(width: 10);
                          },
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: (){
                                setState(() {
                                  selectedColor = index;
                                });
                              },
                              child: CircleAvatar(
                                backgroundColor: Color(
                                        (math.Random().nextDouble() * 0xFFFFFF)
                                            .toInt())
                                    .withOpacity(1.0),
                                child: Stack(
                                  children: [
                                    selectedColor == index ? Center(
                                      child: Icon(Icons.done, color: Colors.white,),
                                    ): SizedBox(),
                                    Container(
                                      width: 36,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          const Text(
                            'Quantity',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 20),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 7),
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
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

                      const Spacer(),
                      const Divider(height: 30),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total price',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey.shade700),
                              ),
                              const Text(
                                '\$280.00',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 200,
                            child: MyButton(
                              title: 'Add to Cart',
                              onTap: () {
                                AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
                                appProvider.addCartProduct(product);
                                Get.snackbar('Successfully', 'Added to cart', backgroundColor: Colors.redAccent, colorText: Colors.black);
                                print('\n');
                                print('\n');
                                print('\n');
                                print('*********************************************');
                                print(appProvider.getCartProductList);
                                print('*********************************************');
                                print('\n');
                                print('\n');
                                print('\n');
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
