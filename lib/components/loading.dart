import 'package:flutter/material.dart';
import 'package:funica/controller/gif_image.dart';
import 'package:funica/route/app_route.dart';
import 'package:get/get.dart';

class Loading extends StatefulWidget {
  final String where;
  const Loading({super.key, required this.where});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 3000), (){
      return Get.toNamed(widget.where); // Use widget.where to specify the destination route
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 800),
      curve: Curves.fastLinearToSlowEaseIn,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Center(
              child: Expanded(
                child: Container(
                  padding: const EdgeInsets.all(40),
                  height: MediaQuery.of(context).size.height/2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(36),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Image.asset('assets/icons/loading.png', width: 156, height: 156,),
                      const SizedBox(height: 20),
                      const Text(
                        'Congratulations!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        textAlign: TextAlign.center,
                        'Your account is ready to use. You will be redirected to the Home page in a few seconds.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Expanded(child: GifImages(
                        width: 100,
                      )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
