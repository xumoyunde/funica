import 'package:flutter/material.dart';

class MyTextfieldpwd extends StatefulWidget {
  final String hintText;
  final String iconUrl;
  final TextEditingController? controller;

  const MyTextfieldpwd({
    super.key,
    required this.hintText,
    required this.iconUrl,
    this.controller,
  });

  @override
  State<MyTextfieldpwd> createState() => _MyTextfieldpwdState();
}

class _MyTextfieldpwdState extends State<MyTextfieldpwd> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xfff5f5f5),
        borderRadius: BorderRadius.circular(18),
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText,
          prefixIcon: Container(
            padding: const EdgeInsets.only(right: 20),
            child:
                Image.asset(widget.iconUrl, color: Colors.black45, width: 25),
          ),
          suffixIcon: Container(
            padding: const EdgeInsets.only(left: 20),
            child: InkWell(
              onTap: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              child: Image.asset(
                obscureText
                    ? 'assets/icons/hidden.png'
                    : 'assets/icons/eye.png',
                color: !obscureText ? Colors.black : Colors.black45,
                width: 25,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyTextfield extends StatelessWidget {
  final String iconUrl;
  final String hintText;
  final TextEditingController? controller;

  const MyTextfield({
    super.key,
    required this.iconUrl,
    required this.hintText,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xfff5f5f5),
        borderRadius: BorderRadius.circular(18),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          prefixIcon: Container(
            padding: const EdgeInsets.only(right: 20),
            child: Image.asset(
              iconUrl,
              color: controller!.text.isEmpty ? Colors.black45 : Colors.black,
              width: 25,
            ),
          ),
        ),
      ),
    );
  }
}
