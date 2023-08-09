import 'package:get/get.dart';

class ToggleController extends GetxController {
  static ToggleController instance = Get.find();

  var tabIndex = 0;

  void updateIndex(int index) {
    tabIndex = index;
    update();
  }
}
