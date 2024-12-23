import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_texi_tracker/app_theme/theme.dart';

extension ThemesData on BuildContext {
  bool get isDark => Platform.isIOS
      ? CupertinoTheme.of(this).brightness == Brightness.dark
      : Theme.of(this).brightness == Brightness.dark;
}

// SchedulerBinding.instance.platformDispatcher.platformBrightness;
// var brightness = View.of(context).platformDispatcher.platformBrightness;

extension GetThemes on BuildContext {
  ThemeData get theme => isDark ? AppTheme().darkTheme : AppTheme().lightTheme;
}
