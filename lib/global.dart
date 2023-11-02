import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

double width = 0;
double height = 0;

systemUi(Color color) {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: color,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.grey.shade200),
  );
}
