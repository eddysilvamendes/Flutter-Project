import 'package:flutter/widgets.dart';
import 'package:flutter_web_application/src/constants/controllers.dart';
import 'package:flutter_web_application/src/routing/pages.dart';
import 'package:flutter_web_application/src/routing/router.dart';

Navigator localNavigator() => Navigator(
      key: navigationController.navigationKey,
      initialRoute: overViewPageRoute,
      onGenerateRoute: generateRoute,
    );
