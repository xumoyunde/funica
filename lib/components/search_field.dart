import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final Widget suffix;
  const SearchField({super.key, required this.suffix});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Color(0xfff4f4f4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Search",
          prefixIcon: Icon(Icons.search),
          suffixIcon: suffix
        ),
      ),
    );
  }
}
