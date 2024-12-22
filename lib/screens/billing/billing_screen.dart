/*
 *  (c) Diyor Xalloqov 2024.8.15 Toshkent, Uzbekistan
 *  github: https://github.com/diyorxalloqov
 *  LinkedIn: https://www.linkedin.com/in/diyor-xalloqov-024b63231/
 *  Telegram: https://t.me/Flutter_dart_developer
 */

import 'package:flutter_texi_tracker/global/imports/app_imports.dart';
import 'package:flutter_texi_tracker/global/widgets/decoration_widget.dart';

class BillingScreen extends StatelessWidget {
  const BillingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BoxDecoration decorationUsed = decoration(context).copyWith(
      boxShadow: [
        BoxShadow(
            color: CustomColors().blackColor(0.4),
            blurRadius: 3,
            blurStyle: BlurStyle.solid)
      ],
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    );
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              child: Container(
            height: App(context).appHeight(210),
            decoration: decoration(context).copyWith(
                color: CustomColors().mainColor(1),
                boxShadow: [],
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(40),
                    bottomLeft: Radius.circular(40))),
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Iyun 19 - Iyun 25',
                    style: context.theme.textTheme.labelLarge
                        ?.copyWith(fontSize: 14, fontWeight: FontWeight.w500)),
                const SpaceHeight(height: 4),
                Text('\$ 2,144.06',
                    style: context.theme.textTheme.labelLarge
                        ?.copyWith(fontSize: 32, fontWeight: FontWeight.w700)),
                const SpaceHeight(height: 30)
              ],
            ),
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SpaceHeight(height: 190),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: decorationUsed,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('1 oy davomida',
                                style: context.theme.textTheme.bodyLarge
                                    ?.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700)),
                            const SpaceHeight(height: 6),
                            Text('10 000 km',
                                style: context.theme.textTheme.displayLarge
                                    ?.copyWith(fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ),
                    const SpaceWidth(width: 16),
                    Expanded(
                      child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: decorationUsed,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Bugungi',
                                  style: context.theme.textTheme.bodyLarge
                                      ?.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700)),
                              const SpaceHeight(height: 6),
                              Text('100 km',
                                  style: context.theme.textTheme.displayLarge
                                      ?.copyWith(fontWeight: FontWeight.w600)),
                            ],
                          )),
                    ),
                  ],
                ),
                const SpaceHeight(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: decorationUsed,
                  // child: Column(
                  //   children: [],
                  // ),
                ),
                const SpaceHeight(height: 30),
                Text('billing_hour'.tr,
                    style: context.theme.textTheme.bodyLarge
                        ?.copyWith(fontSize: 14, fontWeight: FontWeight.w700)),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
