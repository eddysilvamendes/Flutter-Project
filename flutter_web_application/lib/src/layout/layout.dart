import 'package:flutter/material.dart';
import 'package:flutter_web_application/src/helpers/responsiveness.dart';
import 'package:flutter_web_application/src/widgets/large_screen.dart';
import 'package:flutter_web_application/src/widgets/side_menu.dart';
import 'package:flutter_web_application/src/widgets/small_screen.dart';
import 'package:flutter_web_application/src/widgets/top_nav_bar.dart';

class SiteLayout extends StatelessWidget {
  SiteLayout({super.key});
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      extendBodyBehindAppBar: true,
      appBar: topNavigationBar(context, scaffoldkey),
      drawer: const Drawer(
        child: SideMenu(),
      ),
      body: const ResponsiveWidget(
        largeScreen: LargeScreen(),
        smallScreen: SmallScreen(),
      ),
    );
  }
}
