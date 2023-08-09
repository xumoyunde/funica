import 'package:funica/screens/intro/intro.dart';
import 'package:get/get.dart';

class IntroBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(const Intro());
  }

}