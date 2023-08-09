import 'package:flutter/material.dart';

class BannerCard extends StatelessWidget {
  final String discount;
  final String period;
  final String description;
  final String? image;

  const BannerCard({
    super.key,
    required this.discount,
    required this.period,
    required this.description,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 18/8,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        decoration: BoxDecoration(
          color: const Color(0xffe7e7e8),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    discount,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    period,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: image == null
                  ? Container()
                  : Image.asset(
                      image!,
                      fit: BoxFit.cover,
                    ),
            )
          ],
        ),
      ),
    );
  }
}
