import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_texi_tracker/controller/auth_controller.dart';
import 'package:flutter_texi_tracker/data/repository/repository.dart';
import 'package:flutter_texi_tracker/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  var emergencyCall = '';
  var emergencyMail = '';
  bool canDrive = true;

  final _repository = Get.find<Repository>();

  @override
  void initState() {
    baseSetting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///auth controller
    final controller = Get.find<AuthController>();

    final profileList = {
      DrawerProfileList(
          iconData: 'asset/icons/drawer_icon/dashboard.svg',
          title: 'summery'.tr,
          onPressed: () => Get.toNamed(AppRoutes.summaryPage)),
      DrawerProfileList(
          iconData: 'asset/icons/drawer_icon/vehicles.svg',
          title: 'vehicles'.tr,
          onPressed: () => Get.toNamed(AppRoutes.vehicleScreen)),
      DrawerProfileList(
          iconData: 'asset/icons/drawer_icon/drivers.svg',
          title: 'drivers'.tr,
          onPressed: () => Get.toNamed(AppRoutes.driverScreen)),
    };

    final settingList = {
      // DrawerProfileList(
      //     iconData: 'asset/icons/drawer_icon/profile.svg',
      //     title: 'profile'.tr,
      //     onPressed: () => Get.toNamed(AppRoutes.profilePage)),
      DrawerProfileList(
          iconData: 'asset/icons/drawer_icon/settings.svg',
          title: 'settings'.tr,
          onPressed: () => Get.toNamed(AppRoutes.settingScreen)),
      DrawerProfileList(
          iconData: 'asset/icons/drawer_icon/language.svg',
          title: 'language'.tr,
          onPressed: () => Get.toNamed(AppRoutes.languagePage)),
    };

    final supportLegalList = {
      DrawerProfileList(
          iconData: 'asset/icons/drawer_icon/privacy-policy.svg',
          title: 'privacy_policy'.tr,
          onPressed: () => Get.toNamed(AppRoutes.privacyPolicy)),
      DrawerProfileList(
          iconData: 'asset/icons/drawer_icon/terms-condition.svg',
          title: 'terms_conditions'.tr,
          onPressed: () => Get.toNamed(AppRoutes.termsConditions)),
    };

    return Scaffold(
      backgroundColor: const Color(0x00ffffff),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 35),
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Color(0xFFF7F7F7),
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(22))),
                child: GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.profilePage),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                              backgroundImage: NetworkImage(
                                  '${controller.getUser()?.avatar}'),
                              maxRadius: 55.0),
                          Positioned(
                            right: 10,
                            top: 2,
                            child: Container(
                              padding: const EdgeInsets.all(2.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: canDrive == true
                                      ? Colors.green
                                      : Colors.red),
                              child: canDrive == true
                                  ? const Icon(Icons.check,
                                      size: 16, color: Colors.white)
                                  : const Icon(Icons.clear,
                                      size: 16, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                      Text(controller.getUser()?.name ?? "",
                          style: Get.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w600, height: 2)),
                      Text('${controller.getUser()?.phone}'),
                    ],
                  ),
                ),
              ),
              titleWithBorder(title: 'account'.tr),
              Column(
                children: profileList
                    .map((e) => ListTile(
                        onTap: e.onPressed!,
                        dense: true,
                        title: Text('${e.title}'),
                        leading: SvgPicture.asset('${e.iconData}')))
                    .toList(),
              ),
              titleWithBorder(title: 'settings'.tr),
              Column(
                children: settingList
                    .map((e) => ListTile(
                        onTap: e.onPressed,
                        dense: true,
                        title: Text('${e.title}'),
                        leading: SvgPicture.asset('${e.iconData}')))
                    .toList(),
              ),
              titleWithBorder(title: 'support_legal'.tr),
              ListTile(
                  onTap: () => Get.bottomSheet(
                        Container(
                          padding: const EdgeInsets.all(16),
                          child: Wrap(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: Center(
                                    child: TextButton(
                                      onPressed: () async => await launchUrl(
                                          Uri.parse(
                                              "mailto:$emergencyMail?subject=Emergency%20Support&body=Please%20provide%20details%20here"),
                                          mode: LaunchMode.externalApplication),
                                      child: Column(
                                        children: [
                                          const Icon(
                                            Icons.mail,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Text('E-mail',
                                              style: Get.textTheme.titleMedium
                                                  ?.copyWith(
                                                      color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                  )),
                                  Expanded(
                                      child: Center(
                                          child: TextButton(
                                    onPressed: () async {
                                      launchUrl(
                                          Uri.parse("tel://$emergencyCall"));
                                    },
                                    child: Column(
                                      children: [
                                        const Icon(
                                          Icons.phone,
                                          size: 30,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        Text('Phone',
                                            style: Get.textTheme.titleMedium
                                                ?.copyWith(
                                                    color: Colors.white)),
                                      ],
                                    ),
                                  ))),
                                ],
                              )
                            ],
                          ),
                        ),
                        elevation: 20.0,
                        enableDrag: true,
                        isScrollControlled: true,
                        backgroundColor: Get.theme.primaryColorLight,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0),
                        )),
                      ),
                  dense: true,
                  title: Text('emergency_call'.tr),
                  leading: SvgPicture.asset(
                      'asset/icons/drawer_icon/emergency.svg')),
              Column(
                children: supportLegalList
                    .map((e) => ListTile(
                        onTap: e.onPressed,
                        dense: true,
                        title: Text('${e.title}'),
                        leading: SvgPicture.asset('${e.iconData}')))
                    .toList(),
              ),
              const SizedBox(height: 15),
              ListTile(
                dense: true,
                title: Text('logout'.tr),
                leading: SvgPicture.asset('asset/icons/drawer_icon/logout.svg'),
                onTap: () {
                  ///logout dialog alert
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text(
                            'do_you_want_to_logout'.tr,
                            style: Get.textTheme.headlineMedium,
                          ),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          actionsPadding: const EdgeInsets.only(right: 15.0),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () async {
                                  controller.deleteUser();
                                  Get.back();
                                },
                                child: Text('yes'.tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium)),
                            TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text('no'.tr,
                                    style: Get.textTheme.bodyMedium)),
                          ],
                        );
                      });
                },
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding titleWithBorder({String? title}) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title',
            style: const TextStyle(
                color: Color(0xFF999999), height: 1.6, fontSize: 16),
          ),
          const Divider(),
        ],
      ),
    );
  }

  /// base setting app calling
  Future baseSetting() async {
    final response = await _repository.baseSettings();
    if (response != null) {
      emergencyCall = response.data!.phone!;
      emergencyMail = response.data!.email!;
      setState(() {
        canDrive = response.data!.canDrive!;
      });
    }
  }
}

class DrawerProfileList {
  String? iconData;
  String? title;
  Function()? onPressed;

  DrawerProfileList({this.iconData, this.title, this.onPressed});
}
