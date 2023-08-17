import 'package:funica/screens/dashboard/dashboard_binding.dart';
import 'package:funica/screens/dashboard/dashboard_screen.dart';
import 'package:funica/screens/fill_your_profile/fill_your_profile.dart';
import 'package:funica/screens/home/helper/filter_product.dart';
import 'package:funica/screens/home/helper/most_popular.dart';
import 'package:funica/screens/home/helper/notification.dart';
import 'package:funica/screens/home/helper/product_details.dart';
import 'package:funica/screens/home/helper/search_layout.dart';
import 'package:funica/screens/home/helper/special_offers.dart';
import 'package:funica/screens/home/helper/wishlist.dart';
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
      // binding: ToggleBinding(),
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
      name: AppRoute.notification,
      page: () => const NotificationScreen(),
    ),
    GetPage(
      name: AppRoute.wishlist,
      page: () => WishlistScreen(),
    ),
    GetPage(
      name: AppRoute.specialOffers,
      page: () => SpecialOffers(),
    ),
    GetPage(
      name: AppRoute.mostPopular,
      page: () => MostPopular(),
    ),
    GetPage(
      name: AppRoute.productDetails,
      page: () {
        ProductDetails prodd = Get.arguments;
        return prodd;
      },
    ),
    GetPage(
      name: AppRoute.searchLayout,
      page: () => SearchLayout()
    ),
    GetPage(
      name: AppRoute.filter,
      page: () {
        FilterProduct filterProduct = Get.arguments;
        return filterProduct;
      },
    ),
  ];
}