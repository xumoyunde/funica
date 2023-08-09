import 'package:flutter/material.dart';

class BottomBarItem extends StatelessWidget {
  final Function() onTap;
  final String image;
  final String title;

  const BottomBarItem({
    super.key,
    required this.onTap,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            image,
            fit: BoxFit.cover,
            width: 32,
          ),
          const SizedBox(height: 5),
          Text(title),
        ],
      ),
    );
  }
}
