import 'package:flutter/material.dart';

class Product extends StatelessWidget {
  final String title;
  final String sold;
  final String rank;
  final String price;

  const Product({
    super.key,
    required this.title,
    required this.sold,
    required this.rank,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
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
                  child: Image.asset(
                    'assets/images/chair.png',
                    fit: BoxFit.cover,
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
                title,
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
                    rank,
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
                    child: Text(sold),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Text(
                price,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
