import 'package:flutter/material.dart';
import 'package:flutter_web_application/src/layout/layout.dart';
import 'package:flutter_web_application/src/pages/404/error.dart';
import 'package:flutter_web_application/src/pages/authtentication/authentication.dart';
import 'package:flutter_web_application/src/pages/category/category.dart';
import 'package:flutter_web_application/src/pages/clients/clients.dart';
import 'package:flutter_web_application/src/pages/product/drivers.dart';
import 'package:flutter_web_application/src/pages/overview/overview.dart';
import 'package:flutter_web_application/src/routing/pages.dart';
import 'package:get/get.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case overViewPageRoute:
      return _getPageRoute(const OverviewScreen());
    case productPageRoute:
      return _getPageRoute(const DriversScreen());
    case contactPageRoute:
      return _getPageRoute(const ClientsScreen());
    case categoryPageRoute:
      return _getPageRoute(const CategoryPage());
    default:
      return _getPageRoute(const OverviewScreen());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: rootRoute,
      page: () => SiteLayout(),
    ),
    GetPage(
      name: authenticationPageRoute,
      page: () => AuthenticationScreen(),
    ),
    GetPage(
      name: '/not-found',
      page: () => const PageNotFound(),
      transition: Transition.fadeIn,
    ),
  ];
}
