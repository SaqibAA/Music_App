import 'package:flutter/material.dart';

Map<int, Color> color = {
  50: const Color.fromRGBO(65, 212, 119, .1),
  100: const Color.fromRGBO(65, 212, 119, .2),
  200: const Color.fromRGBO(65, 212, 119, .3),
  300: const Color.fromRGBO(65, 212, 119, .4),
  400: const Color.fromRGBO(65, 212, 119, .5),
  500: const Color.fromRGBO(65, 212, 119, .6),
  600: const Color.fromRGBO(65, 212, 119, .7),
  700: const Color.fromRGBO(65, 212, 119, .8),
  800: const Color.fromRGBO(65, 212, 119, .9),
  900: const Color.fromRGBO(65, 212, 119, 1),
};

class AppColors {
  static MaterialColor appColorFull = MaterialColor(0xFF41D477, color);
  static const Color appColor = Color(0XFF41D477);
  static const Color blackColor = Color(0XFF373737);
  static const Color whiteColor = Color(0XFFFFFFFF);
  static const Color greyColor = Color(0XFFF5F5F5);
  static const Color lightBlack = Color(0XFF808080);
}