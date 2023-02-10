import 'package:flutter/material.dart';
import 'package:flutter_web_application/src/constants/style.dart';
import 'package:flutter_web_application/src/helpers/responsiveness.dart';
import 'package:flutter_web_application/src/widgets/custom_text.dart';

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) =>
    AppBar(
      elevation: 0.0,
      leading: !ResponsiveWidget.isSmallScreen(context)
          ? Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 14),
                  child: Image.asset(
                    'assets/icons/logo.png',
                    width: 28,
                  ),
                )
              ],
            )
          : IconButton(
              onPressed: () {
                key.currentState?.openDrawer();
              },
              icon: const Icon(Icons.menu),
            ),
      title: Row(
        children: [
          Visibility(
            child: CustomText(
              text: 'Dash',
              color: lightGrey,
              weight: FontWeight.bold,
              size: 20,
            ),
          ),
          Expanded(child: Container()),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings,
              color: dark.withOpacity(.7),
            ),
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications,
                  color: dark.withOpacity(.7),
                ),
              ),
              Positioned(
                top: 7,
                right: 7,
                child: Container(
                  width: 12,
                  height: 12,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(color: light, width: 2),
                    borderRadius: BorderRadius.circular(30),
                    color: active,
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: 1,
            height: 22,
            color: lightGrey,
          ),
          const SizedBox(width: 24),
          CustomText(
            text: 'Edilson Mendes',
            color: lightGrey,
          ),
          const SizedBox(width: 16),
          Container(
            decoration: BoxDecoration(
              color: active,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Container(
              padding: const EdgeInsets.all(2),
              margin: const EdgeInsets.all(2),
              child: CircleAvatar(
                backgroundColor: light,
                child: Icon(
                  Icons.person_outline,
                  color: dark,
                ),
              ),
            ),
          )
        ],
      ),
      iconTheme: IconThemeData(color: dark),
      backgroundColor: Colors.transparent,
    );
