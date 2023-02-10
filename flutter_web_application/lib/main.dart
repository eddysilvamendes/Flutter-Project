import 'package:flutter/material.dart';
import 'package:flutter_web_application/src/constants/style.dart';
import 'package:flutter_web_application/src/controllers/navigation_controller.dart';
import 'package:flutter_web_application/src/layout/layout.dart';
import 'package:flutter_web_application/src/pages/404/error.dart';
import 'package:flutter_web_application/src/pages/authtentication/authentication.dart';
import 'package:flutter_web_application/src/routing/pages.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_web_application/src/controllers/menu_controller.dart';

void main() {
  Get.put(SideMenuController());
  Get.put(NavigationController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: authenticationPageRoute,
      unknownRoute: GetPage(
        name: '/not-found',
        page: () => const PageNotFound(),
        transition: Transition.fadeIn,
      ),
      getPages: [
        GetPage(
          name: rootRoute,
          page: () => SiteLayout(),
        ),
        GetPage(
          name: authenticationPageRoute,
          page: () => const AuthenticationScreen(),
        ),
      ],
      title: 'Flutter Web',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: light,
        textTheme: GoogleFonts.mulishTextTheme(
          Theme.of(context).textTheme,
        ).apply(
          bodyColor: Colors.black,
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
          },
        ),
        useMaterial3: true,
      ),
    );
  }
}
