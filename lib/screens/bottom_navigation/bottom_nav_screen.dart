import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_texi_tracker/app_config/utils.dart';
import 'package:flutter_texi_tracker/screens/campaigns/campaigns_fav_list_screen.dart';
import 'package:flutter_texi_tracker/screens/drawers/drawers_screen.dart';
import 'package:flutter_texi_tracker/screens/home/driver_welcome_screen.dart';
import 'package:flutter_texi_tracker/screens/history/history_screen.dart';
import 'package:flutter_texi_tracker/screens/payment/payment_screen.dart';
import 'package:flutter_texi_tracker/screens/profile/profile_screen.dart';
import 'package:flutter_texi_tracker/screens/vehicles/vehicles_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class BottomNavScreen extends StatelessWidget {
  const BottomNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PersistentTabController controller;

    controller = PersistentTabController(initialIndex: 0);

    List<Widget> buildScreens() {
      return [
        const DriverHomeScreen(),
        HistoryScreen(),
        // const PaymentScreen(),
        VehiclesScreen(isBottomNavbar: true),
        ProfileScreen(
          isAppBarVisible: false,
        )
      ];
    }

    List<PersistentBottomNavBarItem> navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home_outlined),
          title: ('home'.tr),
          activeColorPrimary: CupertinoColors.black,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.arrow_counterclockwise),
          title: ('history'.tr),
          activeColorPrimary: CupertinoColors.black,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.directions_car_filled),
          title: ('car'.tr),
          activeColorPrimary: CupertinoColors.black,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.person),
          title: ('profile'.tr),
          activeColorPrimary: CupertinoColors.black,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
      ];
    }

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          adgari,
          scale: 4,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black, size: 25.0),
      ),
      drawer: const Drawer(
        child: DrawerScreen(),
      ),
      body: PersistentTabView(context,
          controller: controller,
          screens: buildScreens(),
          items: navBarsItems(),
          confineToSafeArea: true,
          backgroundColor: Colors.white,
          handleAndroidBackButtonPress: true,
          resizeToAvoidBottomInset: true,
          stateManagement: true,
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(10.0),
            colorBehindNavBar: Colors.white,
          ),
          navBarStyle: NavBarStyle.style1),
    );
  }
}
