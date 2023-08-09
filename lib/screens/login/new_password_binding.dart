import 'package:funica/screens/login/create_new_password.dart';
import 'package:funica/screens/toggle/toggle_page.dart';
import 'package:get/get.dart';

class NewPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(const CreateNewPassword());
  }

}