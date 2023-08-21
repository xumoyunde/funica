import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class DefaultAppBar extends StatelessWidget {
  final String title;
  final Widget trailing;

  const DefaultAppBar({
    super.key,
    required this.title,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            borderRadius: BorderRadius.circular(50),
            child: const Icon(Icons.arrow_back),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          trailing,
        ],
      ),
    );
  }
}
