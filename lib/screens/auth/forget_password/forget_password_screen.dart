import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_texi_tracker/app_config/utils.dart';
import 'package:flutter_texi_tracker/data/repository/repository.dart';
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
  var response;

  Future postForgetPass(email) async {
    final data = {
      'email': email.text.trim(),
    };
    response = await _repository.forgetPass(data);

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
                          style: Get.textTheme.displayLarge!
                              .copyWith(fontWeight: FontWeight.w400)),
                      const SizedBox(height: 20),
                      Text(
                        'we_will_send_verification_code_to_your_phone_to_reset_your_password'
                            .tr,
                        style: Get.textTheme.bodyLarge!
                            .copyWith(fontWeight: FontWeight.w400, height: 1.4),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: emailController,
                        textAlignVertical: TextAlignVertical.center,
                        validator: (val) => val?.isEmpty == true
                            ? 'enter_email_please'.tr
                            : null,
                        style: const TextStyle(
                            color: Colors.black, fontSize: 16.0),
                        decoration: InputDecoration(
                          counter: const Offstage(),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          prefixIcon: const Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Icon(Icons.phone, size: 20),
                          ),
                          hintText: 'email_or_phone'.tr,
                          hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            if (_formKey.currentState!.validate()) {
                              postForgetPass(emailController);
                            }
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: const Color(0xFF041E48)),
                          child: Center(
                              child: Text(
                            'send'.tr,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          )),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'skip_i_will_confirm_later'.tr,
                              style: Get.textTheme.bodySmall,
                            ),
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
