/*
 *  (c) Diyor Xalloqov 2024.8.15 Toshkent, Uzbekistan
 *  github: https://github.com/diyorxalloqov
 *  LinkedIn: https://www.linkedin.com/in/diyor-xalloqov-024b63231/
 *  Telegram: https://t.me/Flutter_dart_developer
 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_texi_tracker/app_config/app_config.dart';
import 'package:flutter_texi_tracker/core/keys.dart';
import 'package:flutter_texi_tracker/data/local_data/shared_preference.dart';
import 'package:flutter_texi_tracker/generated/assets.dart';
import 'package:flutter_texi_tracker/global/language_dialog.dart';
import 'package:flutter_texi_tracker/global/widgets/custom_button.dart';
import 'package:flutter_texi_tracker/screens/auth/sign_in.dart';
import 'package:flutter_texi_tracker/screens/auth/user_authenticate.dart';
import 'package:flutter_texi_tracker/widgets/space_widget.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart'
    hide PermissionStatus;

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late PageController _pageController;
  int currentPage = 0;

  final List<String> _icons = [
    Assets.iconsOnboarding1,
    Assets.iconsOnboarding2
  ];
  final List<String> _title = ["onboarding1", "onboarding2"];
  final List<String> _desc = ["onboarding1_desc", 'onboarding2_desc'];

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  final Location location = Location();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (v) {
          setState(() {
            currentPage = v;
          });
        },
        itemCount: _icons.length,
        itemBuilder: (context, index) {
          return SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SpaceHeight(height: 1),
                Column(
                  children: [
                    SvgPicture.asset(_icons[index]),
                    const SpaceHeight(height: 80),
                    Text(_title[index].tr,
                        style: context.theme.textTheme.bodyLarge),
                    const SpaceHeight(height: 16),
                    Text(_desc[index].tr,
                        textAlign: TextAlign.center,
                        style: context.theme.textTheme.headlineSmall),
                    const SpaceHeight(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _title.length,
                        (index) => Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: ShapeDecoration(
                            color: currentPage == index
                                ? CustomColors().mainColor(1)
                                : context.theme.shadowColor,
                            shape: const OvalBorder(),
                          ),
                        ),
                      ),
                    ),
                    const SpaceHeight(height: 10),
                    currentPage == 0
                        ? TextButton(
                            onPressed: () => showLanguageDialog(context),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: CustomColors().blackColor(0.1)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text('select_lang'.tr,
                                    style: context.theme.textTheme.bodyLarge
                                        ?.copyWith(fontSize: 18)),
                              ),
                            ))
                        : const SizedBox.shrink()
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: CustomButton(
                    onPressed: () async {
                      if (currentPage < _icons.length - 1) {
                        _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut);
                      } else {
                        location
                            .hasPermission()
                            .then((permissionGrantedResult) async {
                          print(permissionGrantedResult);
                          if (permissionGrantedResult ==
                              PermissionStatus.granted) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const UserSignIn()),
                                (route) => false);
                            setBool(Keys.onBoarding, true);
                          } else if (permissionGrantedResult ==
                              PermissionStatus.deniedForever) {
                            openAppSettings();
                          } else if (permissionGrantedResult ==
                              PermissionStatus.denied) {
                            await location
                                .requestPermission()
                                .then((permissionGrantedResult) {
                              if (permissionGrantedResult ==
                                  PermissionStatus.granted) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const UserSignIn()),
                                    (route) => false);
                                setBool(Keys.onBoarding, true);
                              } else {
                                openAppSettings();
                              }
                            });
                          } else {
                            await location
                                .requestPermission()
                                .then((permissionGrantedResult) {
                              if (permissionGrantedResult ==
                                  PermissionStatus.granted) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const UserSignIn()),
                                    (route) => false);
                                setBool(Keys.onBoarding, true);
                              }
                            });
                          }
                        });
                        // await
                      }
                    },
                    title: currentPage == _icons.length - 1
                        ? 'turn'.tr
                        : 'next'.tr,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
