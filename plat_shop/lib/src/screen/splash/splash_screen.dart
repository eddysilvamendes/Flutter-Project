import 'package:flutter/material.dart';
import 'package:merceariaonline/src/config/constom_colors.dart';
import 'package:merceariaonline/src/screen/home/components/app_name.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              CustomColors.customSwatchColor,
              CustomColors.buttomColor,
              CustomColors.customSwatchColor.shade700,
              //CustomColors.customContrastColor,
            ],
          )),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              AppName(
                color: Colors.white,
                size: 40,
              ),
              /* SizedBox(height: 10),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(
                  Colors.white,
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
