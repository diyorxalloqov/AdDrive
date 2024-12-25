/*
 *  (c) Diyor Xalloqov 2024.8.15 Toshkent, Uzbekistan
 *  github: https://github.com/diyorxalloqov
 *  LinkedIn: https://www.linkedin.com/in/diyor-xalloqov-024b63231/
 *  Telegram: https://t.me/Flutter_dart_developer
 */

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_texi_tracker/controller/auth_controller.dart';
import 'package:flutter_texi_tracker/global/imports/app_imports.dart';
import 'package:flutter_texi_tracker/global/widgets/decoration_widget.dart';
import 'package:flutter_texi_tracker/screens/billing/billing_screen.dart';
import 'package:flutter_texi_tracker/screens/drawers/drawers_screen.dart';
import 'package:flutter_texi_tracker/screens/home/driver_welcome_screen.dart';
import 'package:flutter_texi_tracker/screens/main_screen/cubit/location_cubit.dart';
import 'package:flutter_texi_tracker/screens/main_screen/ui/widgets/show_start_driving_dialog.dart';
import 'package:flutter_texi_tracker/screens/profile/profile_screen.dart';
import 'package:flutter_texi_tracker/services/firebase_location_service.dart';
import 'package:flutter_texi_tracker/utils/enums/status.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_texi_tracker/model/user_profile.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final historyController = Get.find<OwnerProfileController>();
  BitmapDescriptor? carIcon;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    context.read<LocationCubit>().listenLocation();

    Future.delayed(const Duration(seconds: 3), () async {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        LocationController controller = Get.find<LocationController>();
        AuthController authController = Get.find<AuthController>();
        User user = authController.getUser()!;

        controller.startListening();
        controller.addLocationDataToLocal();
        controller.deleteDataAndSendToServer(uid: user.id);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final firebaseLocationService =
        Provider.of<FirebaseLocationService>(context);
    AuthController authController = Get.find<AuthController>();

    return Init(
        firebaseLocationService: firebaseLocationService,
        user: authController.getUser()!,
        scaffoldKey: scaffoldKey,
        historyController: historyController);
  }
}

class Init extends StatefulWidget {
  final FirebaseLocationService firebaseLocationService;
  final User user;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final OwnerProfileController historyController;
  const Init(
      {super.key,
      required this.firebaseLocationService,
      required this.scaffoldKey,
      required this.historyController,
      required this.user});

  @override
  State<Init> createState() => _InitState();
}

class _InitState extends State<Init> {
  int _currentScreen = 1;

  //* logut dan keyingi error ni to'g'irlash

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        return StreamBuilder<DriverProfile>(
            stream:
                widget.firebaseLocationService.getUserProfile(widget.user.id),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return const Scaffold(body: Loading());
              }
              if (snapshot.hasData) {
                bool isDriving = snapshot.data?.isDriving == 1 ? true : false;

                return Scaffold(
                    drawer: const Drawer(child: DrawerScreen()),
                    key: widget.scaffoldKey,
                    extendBodyBehindAppBar: true,
                    appBar: PreferredSize(
                        preferredSize: const Size(double.infinity, 200),
                        child: SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () => widget.scaffoldKey.currentState
                                      ?.openDrawer(),
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: decoration(context),
                                    child: Icon(Icons.menu,
                                        color: context.theme.canvasColor),
                                  ),
                                ),
                                _currentScreen == 1
                                    ? GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        child: Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: decoration(context),
                                          child: Text.rich(TextSpan(children: [
                                            TextSpan(
                                                text: '\$',
                                                style: context.theme.textTheme
                                                    .displayLarge
                                                    ?.copyWith(fontSize: 22)),
                                            TextSpan(
                                                text: '1',
                                                style: context
                                                    .theme.textTheme.labelMedium
                                                    ?.copyWith(
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.w700))
                                          ])),
                                        ),
                                      )
                                    : _currentScreen == 0
                                        ? Text('billing'.tr,
                                            style: context
                                                .theme.textTheme.labelLarge)
                                        : Text('profile'.tr,
                                            style: context
                                                .theme.textTheme.bodyLarge
                                                ?.copyWith(fontSize: 20)),
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  // onTap: () => ,
                                  child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: decoration(context),
                                      child: SvgPicture.asset(
                                          Assets.iconsNotification,
                                          width: 24,
                                          height: 24)),
                                )
                              ],
                            ),
                          ),
                        )),
                    body: IndexedStack(
                      index: _currentScreen,
                      children: [
                        const BillingScreen(),
                        DriverHomeScreen(
                            historyController: widget.historyController,
                            isDriving: isDriving,
                            state: state,
                            user: widget.user),
                        ProfileScreen()
                      ],
                    ),
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.centerDocked,
                    floatingActionButton: GetBuilder<LocationController>(
                        initState: (_) => LocationController(),
                        builder: (controller) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                decoration: decoration(context).copyWith(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(20))),
                                child: Column(
                                  children: [
                                    const SpaceHeight(height: 22),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        isDriving
                                            ? Image.asset(
                                                'asset/icons/markers/car_icon_animated.gif',
                                                width: 50)
                                            : const SpaceWidth(width: 52),
                                        Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.end,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                      state.locationStatus ==
                                                              ActionStatus
                                                                  .isLoading
                                                          ? 'success_location'
                                                              .tr
                                                          : state.locationStatus ==
                                                                  ActionStatus
                                                                      .isSuccess
                                                              ? "${'distance'.tr} ${controller.liveLocationData.value != null ? controller.liveLocationData.value?.distance : ''} ${"km".tr}"
                                                              : 'turn_on_location'
                                                                  .tr,
                                                      style: context.theme
                                                          .textTheme.bodyLarge
                                                          ?.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 20)),
                                                  Text(
                                                      controller.driveAddress
                                                          .toString(),
                                                      style: context
                                                          .theme
                                                          .textTheme
                                                          .headlineSmall),
                                                ],
                                              ),
                                            ]),
                                        state.locationStatus !=
                                                ActionStatus.isSuccess
                                            ? SizedBox(
                                                width: 30,
                                                child: GestureDetector(
                                                    behavior:
                                                        HitTestBehavior.opaque,
                                                    onTap: () => context
                                                        .read<LocationCubit>()
                                                        .location
                                                        .requestService(),
                                                    child: SvgPicture.asset(Assets
                                                        .iconsLocationSettings)),
                                              )
                                            : const SpaceWidth(width: 32),
                                      ],
                                    ),
                                    const SpaceHeight(height: 40),
                                    Row(
                                      mainAxisAlignment: _currentScreen == 1
                                          ? MainAxisAlignment.center
                                          : MainAxisAlignment.spaceAround,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: GestureDetector(
                                            onTap: () => setState(() {
                                              _currentScreen = 0;
                                            }),
                                            behavior: HitTestBehavior.opaque,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 18,
                                                      horizontal: 20),
                                              decoration: ShapeDecoration(
                                                  color: _currentScreen == 0
                                                      ? CustomColors()
                                                          .mainColor(0.2)
                                                      : null,
                                                  shape: OvalBorder(
                                                      side: BorderSide(
                                                          width: 0.4,
                                                          color: context
                                                              .theme
                                                              .colorScheme
                                                              .inversePrimary))),
                                              child: SvgPicture.asset(
                                                  Assets.iconsBilling),
                                            ),
                                          ),
                                        ),
                                        _currentScreen == 1
                                            ? Expanded(
                                                child: CustomButton(
                                                    onPressed: state
                                                                .locationStatus ==
                                                            ActionStatus
                                                                .isSuccess
                                                        ? () => showStartDrivingDialog(
                                                            isDriving,
                                                            widget
                                                                .historyController,
                                                            widget.user,
                                                            controller)
                                                        : null,
                                                    borderRadius: 24,
                                                    title: isDriving
                                                        ? 'stop'.tr
                                                        : 'start'.tr))
                                            : GestureDetector(
                                                onTap: () => setState(() {
                                                  _currentScreen = 1;
                                                }),
                                                behavior:
                                                    HitTestBehavior.opaque,
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 18,
                                                      horizontal: 20),
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: GestureDetector(
                                            onTap: () => setState(() {
                                              _currentScreen = 2;
                                            }),
                                            behavior: HitTestBehavior.opaque,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 18,
                                                      horizontal: 20),
                                              decoration: ShapeDecoration(
                                                  color: _currentScreen == 2
                                                      ? CustomColors()
                                                          .mainColor(0.2)
                                                      : null,
                                                  shape: OvalBorder(
                                                      side: BorderSide(
                                                          width: 0.4,
                                                          color: context
                                                              .theme
                                                              .colorScheme
                                                              .inversePrimary))),
                                              child: SvgPicture.asset(
                                                  Assets.iconsProfileBlack),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SpaceHeight(height: 20),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }));
              }
              return Container();
            });
      },
    );
  }
}
