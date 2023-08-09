import 'package:flutter/material.dart';

class ProductCategory extends StatelessWidget {
  final Widget icon;
  final String productName;

  const ProductCategory(
      {super.key,
      required this.icon,
      required this.productName,});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Color(0xffe7e7e8),
          ),
          child: icon,
        ),
        const SizedBox(height: 2),
        Text(
          productName,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}
