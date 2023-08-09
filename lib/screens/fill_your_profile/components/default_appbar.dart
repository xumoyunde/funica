import 'package:flutter/material.dart';

class DefaultAppbar extends StatelessWidget {
  final Icon icon;
  final String title;

  const DefaultAppbar({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: icon,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        )
      ],
    );
  }
}
