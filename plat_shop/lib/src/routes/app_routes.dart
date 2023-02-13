import 'package:get/get.dart';
import 'package:merceariaonline/src/binding/cart_binding.dart';
import 'package:merceariaonline/src/binding/home_binding.dart';
import 'package:merceariaonline/src/binding/navigation_binding.dart';
import 'package:merceariaonline/src/binding/order_binding.dart';

import 'package:merceariaonline/src/screen/auth/sign_in_screen.dart';
import 'package:merceariaonline/src/screen/auth/sign_up_screen.dart';
import 'package:merceariaonline/src/screen/base/base_screen.dart';
import 'package:merceariaonline/src/screen/product/product_screen.dart';
import 'package:merceariaonline/src/screen/splash/splash_screen.dart';

abstract class PagesRoutes {
  static const String splashRoute = "/splash";
  static const String signInRoute = "/signIn";
  static const String signUpRoute = "/signUp";
  static const String baseRoutes = "/";
  static const String productRoutes = "/products";
}

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: PagesRoutes.splashRoute,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: PagesRoutes.signInRoute,
      page: () => SignInScreen(),
    ),
    GetPage(
      name: PagesRoutes.signUpRoute,
      page: () => SignUpScreen(),
    ),
    GetPage(
      name: PagesRoutes.baseRoutes,
      page: () => const BaseScreen(),
      bindings: [
        HomeBinding(),
        NavigationBinding(),
        CartBinding(),
        OrdersBinding(),
      ],
    ),
    GetPage(
      name: PagesRoutes.productRoutes,
      page: () => ProductScreen(),
    )
  ];
}
