import 'package:flutter/material.dart';

import '../../config/config.dart';

class Utils {
  static snackBarSuccessfull(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: AppColors.appColor,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      content: SelectableText(
        message,
        style: const TextStyle(color: AppColors.whiteColor),
      ),
    ));
  }

  static snackBarError(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.redAccent,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      content: SelectableText(
        message,
        style: const TextStyle(color: AppColors.whiteColor),
      ),
    ));
  }
}
