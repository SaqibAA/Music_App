import 'package:flutter/material.dart';

import '../../config/config.dart';


class AppButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPressed;
  const AppButton(
      {super.key,
      required this.title,
      required this.onPressed,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: 310,
        decoration: BoxDecoration(
          color: AppColors.appColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: loading
            ? const CircularProgressIndicator()
            : Text(
                title,
                style: const TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
      ),
    );
  }
}
