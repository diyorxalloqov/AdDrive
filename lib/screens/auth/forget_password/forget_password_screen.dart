import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_texi_tracker/app_config/utils.dart';
import 'package:flutter_texi_tracker/data/repository/repository.dart';
import 'package:flutter_texi_tracker/global/imports/app_imports.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({super.key});

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  final _formKey = GlobalKey<FormState>();
  final Repository _repository = Get.find();
  final emailController = TextEditingController();

  Future postForgetPass(email) async {
    final data = {
      'email': email.text.trim(),
    };
    final response = await _repository.forgetPass(data);

    if (response['success'] == true) {
      await Fluttertoast.showToast(msg: '${response['message']}');
      Get.back();
    }
    if (kDebugMode) {
      print(response);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(shapeLoginFlow,
                width: double.infinity, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.only(left: 32.0, top: 80, right: 32),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(adgari, height: 150, fit: BoxFit.cover),
                      const SizedBox(height: 40),
                      Text('forget_password'.tr,
                          style: context.theme.textTheme.bodyLarge),
                      const SizedBox(height: 20),
                      Text(
                          'we_will_send_verification_code_to_your_phone_to_reset_your_password'
                              .tr,
                          style: context.theme.textTheme.headlineSmall),
                      const SizedBox(height: 30),
                      TextFormFieldWidget(
                          controller: emailController,
                          validator: (val) => val?.isEmpty == true
                              ? 'enter_email_please'.tr
                              : null,
                          hintText: 'email_or_phone'.tr),
                      const SizedBox(height: 24),
                      CustomButton(
                          onPressed: () async {
                            setState(() {
                              if (_formKey.currentState!.validate()) {
                                postForgetPass(emailController);
                              }
                            });
                          },
                          padding: EdgeInsets.zero,
                          title: 'send'.tr),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text('skip_i_will_confirm_later'.tr,
                                style: context.theme.textTheme.bodySmall),
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  'Sign_in'.tr,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
