/*
 *  (c) Diyor Xalloqov 2024.8.15 Toshkent, Uzbekistan
 *  github: https://github.com/diyorxalloqov
 *  LinkedIn: https://www.linkedin.com/in/diyor-xalloqov-024b63231/
 *  Telegram: https://t.me/Flutter_dart_developer
 */

import 'package:flutter/material.dart';
import 'package:flutter_texi_tracker/app_config/app_config.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  const CustomButton(
      {super.key,
      this.padding,
      this.borderRadius,
      this.onPressed,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              disabledBackgroundColor: CustomColors().mainColor(0.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 8)),
              backgroundColor: CustomColors().mainColor(1)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
            ),
          )),
    );
  }
}
