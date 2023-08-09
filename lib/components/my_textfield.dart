import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class MyTextfieldpwd extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;

  const MyTextfieldpwd({
    super.key,
    required this.hintText,
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
                Image.asset('assets/icons/password.png', color: Colors.black45, width: 25),
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



class TextFieldWithSuffix extends StatelessWidget {
  final String title;
  final Icon? icon;
  final TextEditingController? controller;
  const TextFieldWithSuffix({super.key, this.icon, required this.title, this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xfff5f5f5),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 2,
            blurRadius: 8,
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: title,
          suffixIcon: icon == null ? null : Container(
            padding: const EdgeInsets.only(left: 20),
            child: icon,
          ),
        ),
      ),
    );
  }
}

class PhoneNumberField extends StatelessWidget {
  final TextEditingController? controller;
  const PhoneNumberField({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xfff5f5f5),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 2,
            blurRadius: 8,
          ),
        ],
      ),
      child: IntlPhoneField(
        controller: controller,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Phone Number',
        ),
      ),
    );
  }
}




