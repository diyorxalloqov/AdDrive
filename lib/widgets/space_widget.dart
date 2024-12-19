/*
 *  (c) Diyor Xalloqov 2024.8.15 Toshkent, Uzbekistan
 *  github: https://github.com/diyorxalloqov
 *  LinkedIn: https://www.linkedin.com/in/diyor-xalloqov-024b63231/
 *  Telegram: https://t.me/Flutter_dart_developer
 */

import 'package:flutter/material.dart';
import 'package:flutter_texi_tracker/app_config/app_config.dart';

class SpaceHeight extends StatelessWidget {
  final double height;
  const SpaceHeight({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: App(context).appHeight(height));
  }
}

class SpaceWidth extends StatelessWidget {
  final double width;
  const SpaceWidth({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: App(context).appWidth(width));
  }
}
