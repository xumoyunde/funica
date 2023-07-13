import 'package:flutter/material.dart';

class SignInWith extends StatelessWidget {
  final String imageUrl;
  final String access;
  const SignInWith({super.key, required this.imageUrl, required this.access});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12, width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imageUrl,
            fit: BoxFit.cover,
            width: 36,
          ),
          const SizedBox(width: 10),
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: "Continue with ",
                  style: TextStyle(
                    fontFamily: 'comforta',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: access,
                  style: const TextStyle(
                      fontFamily: 'comforta',
                      fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                ),
              ]
            ),
          )
        ],
      ),
    );
  }
}

class SignUpWith extends StatelessWidget {
  final String imageUrl;
  const SignUpWith({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12, width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Image.asset(
        imageUrl,
        fit: BoxFit.cover,
        width: 36,
      ),
    );
  }
}
