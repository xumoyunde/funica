import 'package:flutter/material.dart';

class SeeAll extends StatelessWidget {
  final String title;
  final Function() onClick;
  const SeeAll({super.key, required this.title, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        InkWell(
          onTap: onClick,
          child: const Text(
            'See All',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
