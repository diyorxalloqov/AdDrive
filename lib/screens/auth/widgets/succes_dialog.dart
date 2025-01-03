/*
 *  (c) Diyor Xalloqov 2024.8.15 Toshkent, Uzbekistan
 *  github: https://github.com/diyorxalloqov
 *  LinkedIn: https://www.linkedin.com/in/diyor-xalloqov-024b63231/
 *  Telegram: https://t.me/Flutter_dart_developer
 */

import 'package:addrive/global/imports/app_imports.dart';

void showSuccessRegisterDialog(BuildContext context,
    {required VoidCallback onPressed}) {
  showAdaptiveDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog.adaptive(
            content: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: context.theme.colorScheme.primary),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SpaceHeight(height: 36),
                  Image.asset(Assets.imagesSuccess),
                  const SpaceHeight(height: 6),
                  Text('success'.tr,
                      style: context.theme.textTheme.labelMedium?.copyWith(
                          fontSize: 18, fontWeight: FontWeight.w700)),
                  const SpaceHeight(height: 16),
                  Text('success_register'.tr,
                      textAlign: TextAlign.center,
                      style: context.theme.textTheme.labelMedium),
                  const SpaceHeight(height: 16),
                  CustomButton(onPressed: onPressed, title: "next".tr),
                  const SpaceHeight(height: 28)
                ],
              ),
            ),
          ));
}
