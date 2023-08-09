import 'package:funica/screens/toggle/toggle_page.dart';
import 'package:get/get.dart';

class ToggleBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TogglePage());
  }

}