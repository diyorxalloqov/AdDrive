/*
 *  (c) Diyor Xalloqov 2024.8.15 Toshkent, Uzbekistan
 *  github: https://github.com/diyorxalloqov
 *  LinkedIn: https://www.linkedin.com/in/diyor-xalloqov-024b63231/
 *  Telegram: https://t.me/Flutter_dart_developer
 */

/*
 *  (c) Diyor Xalloqov 2024.8.15 Toshkent, Uzbekistan
 *  github: https://github.com/diyorxalloqov
 *  LinkedIn: https://www.linkedin.com/in/diyor-xalloqov-024b63231/
 *  Telegram: https://t.me/Flutter_dart_developer
 */

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_texi_tracker/controller/location_controller.dart';
import 'package:flutter_texi_tracker/global/imports/app_imports.dart';
import 'package:flutter_texi_tracker/global/widgets/decoration_widget.dart';
import 'package:flutter_texi_tracker/screens/billing/billing_screen.dart';
import 'package:flutter_texi_tracker/screens/drawers/drawers_screen.dart';
import 'package:flutter_texi_tracker/screens/home/driver_welcome_screen.dart';
import 'package:flutter_texi_tracker/screens/main_screen/cubit/location_cubit.dart';
import 'package:flutter_texi_tracker/screens/profile/profile_screen.dart';
import 'package:flutter_texi_tracker/utils/enums/status.dart';

GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _screens = [
    const BillingScreen(),
    const DriverHomeScreen(),
    ProfileScreen()
  ];

  int _currentScreen = 1;

  @override
  void initState() {
    context.read<LocationCubit>().listenLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const Drawer(child: DrawerScreen()),
      body: _screens[_currentScreen],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BlocBuilder<LocationCubit, LocationState>(
        builder: (context, state) {
          return GetBuilder<LocationController>(
              initState: (_) => LocationController(),
              builder: (controller) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 19, vertical: 12),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: GetBuilder<LocationController>(
                          builder: (controller) {
                            return IconButton(
                                onPressed: () {
                                  if (1 != 1 /*isDriving*/) {
                                    controller.onDrivingModeCameraPosition();
                                  } else {
                                    controller.onStopModeCameraPosition();
                                  }
                                },
                                icon: SvgPicture.asset(Assets.iconsLocation));
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: App(context).appHeight(200),
                      decoration: decoration(context).copyWith(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(20))),
                      child: Column(
                        children: [
                          const SpaceHeight(height: 22),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const SpaceWidth(width: 1),
                              Text(
                                  state.locationStatus == ActionStatus.isLoading
                                      ? 'success_location'.tr
                                      : state.locationStatus ==
                                              ActionStatus.isSuccess
                                          ? "${'distance'.tr} 0 ${"km".tr}"
                                          : 'turn_on_location'.tr,
                                  style: context.theme.textTheme.bodyLarge
                                      ?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 22)),
                              state.locationStatus != ActionStatus.isSuccess
                                  ? GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () => context
                                          .read<LocationCubit>()
                                          .location
                                          .requestService(),
                                      child: SvgPicture.asset(
                                          Assets.iconsLocationSettings))
                                  : const SizedBox.shrink(),
                            ],
                          ),
                          const SpaceHeight(height: 40),
                          Row(
                            mainAxisAlignment: _currentScreen == 1
                                ? MainAxisAlignment.center
                                : MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: GestureDetector(
                                  onTap: () => setState(() {
                                    _currentScreen = 0;
                                  }),
                                  behavior: HitTestBehavior.opaque,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 18, horizontal: 20),
                                    decoration: ShapeDecoration(
                                        shape: OvalBorder(
                                            side: BorderSide(
                                                width: 0.4,
                                                color: context.theme.colorScheme
                                                    .inversePrimary))),
                                    child:
                                        SvgPicture.asset(Assets.iconsBilling),
                                  ),
                                ),
                              ),
                              _currentScreen == 1
                                  ? Expanded(
                                      child: CustomButton(
                                          onPressed: state.locationStatus ==
                                                  ActionStatus.isSuccess
                                              ? () {}
                                              : null,
                                          borderRadius: 24,
                                          title: "start".tr))
                                  : GestureDetector(
                                      onTap: () => setState(() {
                                        _currentScreen = 1;
                                      }),
                                      behavior: HitTestBehavior.opaque,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 18, horizontal: 20),
                                        decoration: ShapeDecoration(
                                            shape: OvalBorder(
                                                side: BorderSide(
                                                    width: 0.4,
                                                    color: context
                                                        .theme
                                                        .colorScheme
                                                        .inversePrimary))),
                                        child: SvgPicture.asset(
                                            Assets.iconsHome,
                                            width: 24),
                                      ),
                                    ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: GestureDetector(
                                  onTap: () => setState(() {
                                    _currentScreen = 2;
                                  }),
                                  behavior: HitTestBehavior.opaque,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 18, horizontal: 20),
                                    decoration: ShapeDecoration(
                                        shape: OvalBorder(
                                            side: BorderSide(
                                                width: 0.4,
                                                color: context.theme.colorScheme
                                                    .inversePrimary))),
                                    child: SvgPicture.asset(
                                        Assets.iconsProfileBlack),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                );
              });
        },
      ),
    );
  }
}
