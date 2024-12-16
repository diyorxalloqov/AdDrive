import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_texi_tracker/app_config/utils.dart';
import 'package:flutter_texi_tracker/controller/sign_in_controller.dart';
import 'package:flutter_texi_tracker/screens/about/privacy_policy_screen.dart';
import 'package:flutter_texi_tracker/screens/about/terms_conditon_screen.dart';
import 'package:flutter_texi_tracker/widgets/loading.dart';
import 'package:get/get.dart';

class UserSignUp extends StatefulWidget {
  final Function? toggleView;
  const UserSignUp({super.key, this.toggleView});

  @override
  UserSignUpState createState() => UserSignUpState();
}

class UserSignUpState extends State<UserSignUp> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String phone = '';
  String password = '';
  String confirmPassword = '';
  bool isLoading = false;
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInUpController>(
      init: SignInUpController(),
      initState: (_) => SignInUpController(),
      builder: (controller) {
        return controller.loading.value
            ? const Loading()
            : Scaffold(
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Stack(
                        children: [
                          Image.asset(
                            shapeLoginFlow,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 22, right: 22, top: 80),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  adgari,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'sign_up'.tr,
                                  style: Get.textTheme.titleLarge,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  textAlignVertical: TextAlignVertical.bottom,
                                  validator: (val) => val!.isEmpty
                                      ? 'enter_name_please'.tr
                                      : null,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16.0),
                                  decoration: InputDecoration(
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    prefixIcon: const Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Icon(
                                        Icons.person,
                                        size: 25,
                                      ),
                                    ),
                                    hintText: 'username'.tr,
                                    hintStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  onChanged: (val) {
                                    setState(() {
                                      name = val;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                TextFormField(
                                  textAlignVertical: TextAlignVertical.bottom,
                                  validator: (val) => val!.isEmpty
                                      ? 'enter_phone_please'.tr
                                      : null,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16.0),
                                  decoration: InputDecoration(
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    prefixIcon: const Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Icon(
                                        Icons.phone,
                                        size: 25,
                                      ),
                                    ),
                                    hintText: 'phone'.tr,
                                    hintStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  onChanged: (val) {
                                    setState(() {
                                      phone = val;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                TextFormField(
                                  textAlignVertical: TextAlignVertical.bottom,
                                  obscureText: true,
                                  validator: (val) => val!.isEmpty
                                      ? 'enter_password_please'.tr
                                      : null,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16.0),
                                  decoration: InputDecoration(
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    prefixIcon: const Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Icon(
                                        CupertinoIcons.padlock_solid,
                                        size: 25,
                                      ),
                                    ),
                                    hintText: 'password'.tr,
                                    hintStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  onChanged: (val) {
                                    setState(() {
                                      password = val;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                TextFormField(
                                  textAlignVertical: TextAlignVertical.bottom,
                                  obscureText: true,
                                  validator: (val) => val!.isEmpty
                                      ? 'enter_confirm_password'.tr
                                      : null,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16.0),
                                  decoration: InputDecoration(
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    prefixIcon: const Padding(
                                      padding: EdgeInsets.only(right: 16),
                                      child: Icon(
                                        CupertinoIcons.padlock_solid,
                                        size: 25,
                                      ),
                                    ),
                                    hintText: 'confirm_password'.tr,
                                    hintStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  onChanged: (val) {
                                    setState(() {
                                      confirmPassword = val;
                                    });
                                  },
                                ),
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 6,
                                  children: [
                                    Checkbox(
                                        visualDensity:
                                            VisualDensity.comfortable,
                                        value: isSelected,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            isSelected = value!;
                                          });
                                        }),
                                    Text.rich(
                                      TextSpan(
                                        text: 'i_agree_to'.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge
                                            ?.copyWith(
                                                color: Theme.of(context)
                                                    .canvasColor),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'terms'.tr,
                                            style: const TextStyle(
                                                color: Colors.red),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Get.to(const TermsCondition());
                                              },
                                          ),
                                          const TextSpan(text: ' & '),
                                          TextSpan(
                                            text: 'privacy_policy'.tr,
                                            style: const TextStyle(
                                                color: Colors.red),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Get.to(const PrivacyPolicy());
                                              },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      if (isSelected == true) {
                                        controller.userRegistration(
                                            name: name,
                                            phone: phone,
                                            email: email,
                                            password: password,
                                            confirmPassword: confirmPassword);
                                      } else {
                                        Get.snackbar('',
                                            'Please agree to Terms & Privacy policy',
                                            snackPosition:
                                                SnackPosition.BOTTOM);
                                      }
                                    }
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: const Color(0xFF041E48)),
                                    child: Center(
                                        child: Text(
                                      'registration'.tr,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    )),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 20, bottom: 20),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'already_have_account'.tr,
                                        style: Get.textTheme.bodySmall,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          widget.toggleView!();
                                        },
                                        child: Container(
                                          padding:
                                              const EdgeInsets.only(left: 5),
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
                        ],
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }
}
