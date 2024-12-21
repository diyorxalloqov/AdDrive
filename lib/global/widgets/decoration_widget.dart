/*
 *  (c) Diyor Xalloqov 2024.8.15 Toshkent, Uzbekistan
 *  github: https://github.com/diyorxalloqov
 *  LinkedIn: https://www.linkedin.com/in/diyor-xalloqov-024b63231/
 *  Telegram: https://t.me/Flutter_dart_developer
 */

import 'package:flutter_texi_tracker/global/imports/app_imports.dart';

BoxDecoration decoration(BuildContext context) {
  return BoxDecoration(
      color: context.theme.colorScheme.primary,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: context.theme.canvasColor,
          blurRadius: 2,
          blurStyle: BlurStyle.outer,
          spreadRadius: 0,
          offset: const Offset(0, 1),
        )
      ]);
}
