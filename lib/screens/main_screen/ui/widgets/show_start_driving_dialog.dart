/*
 *  (c) Diyor Xalloqov 2024.8.15 Toshkent, Uzbekistan
 *  github: https://github.com/diyorxalloqov
 *  LinkedIn: https://www.linkedin.com/in/diyor-xalloqov-024b63231/
 *  Telegram: https://t.me/Flutter_dart_developer
 */

import 'package:flutter_texi_tracker/global/imports/app_imports.dart';
import 'package:lottie/lottie.dart' as lotte;

void showStartDrivingDialog(
    bool isDriving,
    OwnerProfileController historyController,
    User user,
    LocationController controller) {
  Get.defaultDialog(
      title: isDriving ? 'stop_driving'.tr : 'start_driving'.tr,
      barrierDismissible: false,
      backgroundColor: Get.theme.colorScheme.primary,
      confirmTextColor: Colors.black54,
      cancelTextColor: Colors.black54,
      content: Column(
        children: [
          lotte.Lottie.asset(Assets.lotteCarLotte),
          Text('${isDriving ? 'stop_drive'.tr : 'start_drive'.tr}?',
              style: Get.theme.textTheme.headlineSmall),
        ],
      ),
      textConfirm: 'yes'.tr,
      textCancel: 'no'.tr,
      onConfirm: () async {
        Get.back();

        if (isDriving) {
          ///get driving stop moving
          controller.getDriverStopMoving(user.id);

          ///when driver stop driving
          ///we have update driving
          ///history data
          await historyController.getDrivingHistory();
        } else {
          controller.getDriverStartMoving(user.id);
        }

        final map = {
          'is_driving': isDriving ? 0 : 1,
          'last_login': Timestamp.now().seconds,
          'uid': '${user.id}'
        };

        controller.updateUserData(map: map, uid: user.id);
      },
      onCancel: () {
        Get.back();
      });
}
