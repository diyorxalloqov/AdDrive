import 'package:flutter_texi_tracker/language/language_screen.dart';
import 'package:flutter_texi_tracker/screens/auth/sign_up.dart';
import 'package:flutter_texi_tracker/screens/campaigns/campaigns_fav_list_screen.dart';
import 'package:flutter_texi_tracker/screens/campaigns/campaigns_screen.dart';
import 'package:flutter_texi_tracker/screens/driver_info/view/driver_info_page.dart';
import 'package:flutter_texi_tracker/screens/drivers/drivers_screen.dart';
import 'package:flutter_texi_tracker/screens/google_map_polynie/google_map_poly_line.dart';
import 'package:flutter_texi_tracker/screens/auth/auth_binding.dart';
import 'package:flutter_texi_tracker/screens/auth/user_authenticate.dart';
import 'package:flutter_texi_tracker/screens/about/privacy_policy_screen.dart';
import 'package:flutter_texi_tracker/screens/profile/profile_screen.dart';
import 'package:flutter_texi_tracker/screens/settings/settings_screen.dart';
import 'package:flutter_texi_tracker/screens/splash_screen/splash_screen.dart';
import 'package:flutter_texi_tracker/screens/summery/summery_screen.dart';
import 'package:flutter_texi_tracker/screens/about/terms_conditon_screen.dart';
import 'package:flutter_texi_tracker/screens/vehicles/vehicles_screen.dart';
import 'package:get/get.dart';
import 'app_routes.dart';

class AppPages {
  static var list = [
    GetPage(
        name: AppRoutes.splashScreen,
        page: () => const SplashScreen(),
        binding: AuthBinding(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.signUp,
        page: () => const UserSignUp(),
        binding: AuthBinding(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.profilePage,
        page: () => ProfileScreen(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.summaryPage,
        page: () => SummeryScreen(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.vehicleScreen,
        page: () => VehiclesScreen(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.driverInfoPage,
        page: () => DriverInfoPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.driverScreen,
        page: () => DriversScreen(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.settingScreen,
        page: () => const SettingsScreen(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.privacyPolicy,
        page: () => const PrivacyPolicy(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.termsConditions,
        page: () => const TermsCondition(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.mapPolyLinePage,
        page: () => const MapPolylinePage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.languagePage,
        page: () => const LanguageScreen(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.campaignsScreen,
        page: () => const CampaignsScreen(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.campaignFavListScreen,
        page: () => const CampaignFavListScreen(),
        transition: Transition.cupertino),
  ];
}
