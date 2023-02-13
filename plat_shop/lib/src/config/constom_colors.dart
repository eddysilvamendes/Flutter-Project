import 'package:flutter/material.dart';

Map<int, Color> _swatchOpacity = {
  50: const Color.fromRGBO(0, 0, 254, .1),
  100: const Color.fromRGBO(0, 0, 254, .2),
  200: const Color.fromRGBO(0, 0, 254, .3),
  300: const Color.fromRGBO(0, 0, 254, .4),
  400: const Color.fromRGBO(0, 0, 254, .5),
  500: const Color.fromRGBO(0, 0, 254, .6),
  600: const Color.fromRGBO(0, 0, 254, .7),
  700: const Color.fromRGBO(0, 0, 254, .8),
  800: const Color.fromRGBO(0, 0, 254, .9),
  900: const Color.fromRGBO(0, 0, 254, 1),
};

abstract class CustomColors {
  static Color customContrastColor = const Color(0xFFff6d6e);
  static Color buttomColor = const Color(0xFF32A060);
  static MaterialColor color = MaterialColor(0xFF0080ff, _swatchOpacity);
  static MaterialColor customSwatchColor =
      MaterialColor(0xFF32A060, _swatchOpacity);
}
