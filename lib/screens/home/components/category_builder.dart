import 'package:flutter/material.dart';

class CategoryBuilder extends StatelessWidget {
  final Function() click;
  final String name;

  // Add this parameter
  final String selectedCategory;

  const CategoryBuilder(
      {super.key,
      required this.click,
      required this.name,
      required this.selectedCategory});

  @override
  Widget build(BuildContext context) {

    // Compare the name and selectedCategory to determine the color
    Color containerColor = name == selectedCategory ? Colors.black : Colors.white;
    Color textColor = name == selectedCategory ? Colors.white : Colors.black;

    return GestureDetector(
      onTap: click,
      child: Container(
        height: 24,
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(36),
          border: Border.all(color: Colors.black, width: 1.5),
        ),
        child: Center(
          child: Text(
            name,
            style: TextStyle(
              fontSize: 17,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
