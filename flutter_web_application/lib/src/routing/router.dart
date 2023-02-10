import 'package:flutter/material.dart';
import 'package:flutter_web_application/src/pages/clients/clients.dart';
import 'package:flutter_web_application/src/pages/drivers/drivers.dart';
import 'package:flutter_web_application/src/pages/overview/overview.dart';
import 'package:flutter_web_application/src/routing/pages.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case overViewPageRoute:
      return _getPageRoute(const OverviewScreen());
    case driversPageRoute:
      return _getPageRoute(const DriversScreen());
    case clientsPageRoute:
      return _getPageRoute(const ClientsScreen());
    default:
      return _getPageRoute(const OverviewScreen());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
