import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_app/architect.dart';

double width = 0;
double height = 0;

TextStyle textStyle([double? size, Color? color, FontWeight? weight]) {
  return TextStyle(
      fontSize: size ?? 14,
      color: color ?? AppColors.blackColor,
      fontWeight: weight ?? FontWeight.normal);
}

systemUi(Color color) {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: color,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.grey.shade200),
  );
}

swithScreenPush(context, screen) {
  return Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, _, __) => screen,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ),
  );
}

swithScreenPushReplacement(context, screen) {
  return Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      pageBuilder: (context, _, __) => screen,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ),
  );
}
