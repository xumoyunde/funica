import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:funica/presentation/screens/intro/intro.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late FlutterGifController controller;

  @override
  void initState() {
    super.initState();
    controller = FlutterGifController(vsync: this);
    controller.repeat(min: 0, max: 18, period: const Duration(milliseconds: 1500));
    Future.delayed( const Duration(seconds: 2), ()=> Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context)=> const Intro())
    ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/logo.png', width: 40,),
                const SizedBox(width: 6),
                const Text(
                  "Funica",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: const Alignment(0, .75),
            child: GifImage(
              controller: controller,
              image: const AssetImage('assets/gif/loading.gif'),
              width: 48,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

