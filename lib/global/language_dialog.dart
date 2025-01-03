/*
 *  (c) Diyor Xalloqov 2024.8.15 Toshkent, Uzbekistan
 *  github: https://github.com/diyorxalloqov
 *  LinkedIn: https://www.linkedin.com/in/diyor-xalloqov-024b63231/
 *  Telegram: https://t.me/Flutter_dart_developer
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:addrive/controller/language_controller.dart';
import 'package:addrive/widgets/space_widget.dart';
import 'package:get/get.dart';

void showLanguageDialog(BuildContext context) {
  showAdaptiveDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => const LanguageDialog());
}

class LanguageDialog extends StatelessWidget {
  const LanguageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageController>(
        init: LanguageController(),
        builder: (controller) {
          return CupertinoAlertDialog(
            title: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Tilni tanlang!',
                    style: context.theme.textTheme.bodyLarge),
                const SpaceHeight(height: 10),
                Text('Выберите язык!',
                    style: context.theme.textTheme.bodyLarge),
              ],
            ),
            content: Column(
              children: [
                CupertinoButton(
                    child: Text('Uzbek tili',
                        style: context.theme.textTheme.displayMedium),
                    onPressed: () {
                      controller.onLanguageChange(languageCode: 'uz', index: 0);
                      Navigator.of(context).maybePop();
                    }),
                CupertinoButton(
                    child: Text('Русский язык',
                        style: context.theme.textTheme.displayMedium),
                    onPressed: () {
                      controller.onLanguageChange(languageCode: 'ru', index: 1);
                      Navigator.of(context).maybePop();
                    })
              ],
            ),
          );
        });
  }
}
