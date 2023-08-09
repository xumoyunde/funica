import 'package:flutter/material.dart';

class RememberMe extends StatefulWidget {
  const RememberMe({super.key});

  @override
  State<RememberMe> createState() => _RememberMeState();
}

class _RememberMeState extends State<RememberMe> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          semanticLabel: "remember me",
          side: const BorderSide(width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          checkColor: Colors.white,
          activeColor: Colors.black,
          value: isChecked,
          onChanged: (value) {
            setState(() {
              isChecked = value!;
            });
          },
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isChecked = !isChecked;
            });
          },
          child: const Text(
            "Remember me",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w900,
            ),
          ),
        )
      ],
    );
  }
}
