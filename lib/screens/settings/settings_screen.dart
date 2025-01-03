import 'package:flutter/material.dart';
import 'package:addrive/controller/auth_controller.dart';
import 'package:addrive/data/repository/repository.dart';
import 'package:addrive/global/imports/app_imports.dart';
import 'package:addrive/global/widgets/decoration_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController currentPasswordController =
        TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();
    final repository = Get.find<Repository>();
    final authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: context.isDarkMode ? Colors.white : Colors.black),
        title: Text('settings'.tr, style: context.theme.textTheme.labelMedium),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: decoration(context),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('change_password'.tr,
                      style: context.theme.textTheme.labelMedium),
                  const SpaceHeight(height: 16),
                  TextFormFieldWidget(
                    obscureText: true,
                    prefixIconName: Assets.iconsSecurity,
                    controller: currentPasswordController,
                    validator: (val) => val?.isEmpty == true
                        ? 'enter_current_password'.tr
                        : null,
                    hintText: 'current_password'.tr,
                    hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400),
                  ),
                  const SpaceHeight(height: 16),
                  TextFormFieldWidget(
                    obscureText: true,
                    prefixIconName: Assets.iconsSecurity,
                    controller: newPasswordController,
                    validator: (val) =>
                        val?.isEmpty == true ? 'enter_new_password'.tr : null,
                    style: const TextStyle(color: Colors.black, fontSize: 16.0),
                    hintText: 'new_password'.tr,
                    hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400),
                  ),
                  const SpaceHeight(height: 16),
                  TextFormFieldWidget(
                    obscureText: true,
                    prefixIconName: Assets.iconsSecurity,
                    controller: confirmPasswordController,
                    validator: (val) => val?.isEmpty == true
                        ? 'enter_confirm_password'.tr
                        : null,
                    style: const TextStyle(color: Colors.black, fontSize: 16.0),
                    hintText: 'confirm_password'.tr,
                    hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400),
                  ),
                  const SpaceHeight(height: 16),
                  CustomButton(
                    title: 'update'.tr,
                    padding: EdgeInsets.zero,
                    onPressed: () async {
                      final user = authController.getUser();

                      if (formKey.currentState?.validate() == true) {
                        final data = {
                          "user_id": "${user?.id}",
                          "current_password": currentPasswordController.text,
                          "password": newPasswordController.text,
                          "password_confirmation":
                              confirmPasswordController.text,
                        };

                        final message = await repository.updatePassword(data);

                        if (message?.success == true) {
                          await authController.deleteUser();
                          Fluttertoast.showToast(
                              msg: '${message?.message}',
                              backgroundColor: Colors.green);
                          //FlashMsg.success(context, '${message?.message}');
                          Get.back();
                        } else {
                          Fluttertoast.showToast(
                              msg: '${message?.message}',
                              backgroundColor: Colors.red);
                          //FlashMsg.error(context, '${message?.message}');
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
