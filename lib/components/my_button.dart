import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String title;
  final Function() onTap;
  final String? theme;
  const MyButton({super.key, required this.title, required this.onTap, this.theme = 'dark'});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: theme == 'dark' ? Colors.black : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: theme == 'dark' ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
