import 'package:funica/screens/dashboard/dashboard_binding.dart';
import 'package:funica/screens/dashboard/dashboard_screen.dart';
import 'package:funica/screens/fill_your_profile/fill_your_profile.dart';
import 'package:funica/screens/intro/intro.dart';
import 'package:funica/screens/intro/intro_binding.dart';
import 'package:funica/screens/login/create_new_password.dart';
import 'package:funica/screens/login/new_password_binding.dart';
import 'package:funica/screens/toggle/toggle_binding.dart';
import 'package:funica/screens/toggle/toggle_page.dart';
import 'package:get/get.dart';

import 'app_route.dart';

class AppPage {
  static var list = [
    GetPage(
      name: AppRoute.dashboard,
      page: () => DashboardScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoute.login,
      page: () => const TogglePage(),
      binding: ToggleBinding(),
    ),
    GetPage(
      name: AppRoute.createNewPassword,
      page: () => const CreateNewPassword(),
      binding: NewPasswordBinding(),
    ),
    GetPage(
      name: AppRoute.intro,
      page: () => const Intro(),
      binding: IntroBinding(),
    ),
    GetPage(
      name: AppRoute.fill_your_profile,
      page: () => const FillYourProfile(),
      binding: IntroBinding(),
    ),
  ];
}

// class AppPage {
//   static var list = [
//     GetPage(
//       name: AppRoute.dashboard,
//       page: () => const DashboardScreen(),
//       binding: DashboardBinding(),
//     ),
//     GetPage(
//       name: AppRoute.login,
//       page: () => const SplashScreen(),
//       binding: ToggleBinding(),
//     ),
//     GetPage(
//       name: AppRoute.createNewPassword,
//       page: () => const CreateNewPassword(),
//       binding: NewPasswordBinding(),
//     ),
//     GetPage(
//       name: AppRoute.intro,
//       page: () => const Intro(),
//       binding: IntroBinding(),
//     ),
//   ];
// }