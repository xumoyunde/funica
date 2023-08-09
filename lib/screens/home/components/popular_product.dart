import 'package:flutter/material.dart';

class PopularProduct extends StatefulWidget {
  final String productName;
  const PopularProduct({Key? key, required this.productName}) : super(key: key);

  @override
  _PopularProductState createState() => _PopularProductState();
}

class _PopularProductState extends State<PopularProduct> {
  bool isPressed = false;

  void _onTap() {
    setState(() {
      isPressed = !isPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color containerColor = isPressed ? Colors.black : Colors.white;
    Color textColor = isPressed ? Colors.white : Colors.black;

    return GestureDetector(
      onTap: _onTap,
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
            widget.productName,
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
