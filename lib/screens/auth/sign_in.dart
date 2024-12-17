import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_texi_tracker/app_config/utils.dart';
import 'package:flutter_texi_tracker/generated/assets.dart';
import 'package:flutter_texi_tracker/language/language_screen.dart';
import 'package:flutter_texi_tracker/screens/auth/forget_password/forget_password_screen.dart';
import 'package:flutter_texi_tracker/controller/sign_in_controller.dart';
import 'package:flutter_texi_tracker/widgets/loading.dart';
import 'package:get/get.dart';

class UserSignIn extends StatefulWidget {
  final Function toggleView;

  const UserSignIn({super.key, required this.toggleView});

  @override
  UserSignInState createState() => UserSignInState();
}

class UserSignInState extends State<UserSignIn> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool isLoading = false;
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInUpController>(
      builder: (signInController) {
        return signInController.loading.value
            ? const Loading()
            : Scaffold(
                body: SafeArea(
                  child: Stack(
                    children: [
                      Image.asset(shapeLoginFlow,
                          width: double.infinity, fit: BoxFit.cover),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 22, right: 22, top: 80),
                        child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(Assets.logoLauncherIcon, scale: 4),
                                const SizedBox(height: 20),
                                Text('Sign_in'.tr,
                                    style: Get.textTheme.titleLarge),
                                const SizedBox(height: 20),
                                TextFormField(
                                  textAlignVertical: TextAlignVertical.bottom,
                                  validator: (val) => val!.isEmpty
                                      ? 'enter_email_please'.tr
                                      : null,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16.0),
                                  decoration: InputDecoration(
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    prefixIcon: const Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: Icon(Icons.person, size: 25)),
                                    hintText: 'email_or_phone'.tr,
                                    hintStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  onChanged: (val) {
                                    setState(() {
                                      email = val;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  textAlignVertical: TextAlignVertical.bottom,
                                  obscureText: obscureText,
                                  validator: (val) => val!.isEmpty
                                      ? 'enter_password_please'.tr
                                      : null,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16.0),
                                  decoration: InputDecoration(
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          obscureText = !obscureText;
                                          setState(() {});
                                        },
                                        icon: Icon(obscureText
                                            ? Icons.visibility
                                            : Icons.visibility_off)),
                                    prefixIcon: const Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Icon(CupertinoIcons.padlock_solid,
                                          size: 25),
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
                                Container(
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: InkWell(
                                        onTap: () =>
                                            Get.to(const ForgetPassScreen()),
                                        child: Text(
                                          'forgot_password'.tr,
                                          style: Get.textTheme.bodySmall,
                                        ))),
                                const SizedBox(height: 20.0),
                                GestureDetector(
                                  onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      signInController.userLogin(
                                          email: email, password: password);
                                      setState(() {
                                        isLoading = false;
                                      });
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
                                      'Sign_in'.tr,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    )),
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('don`t_have_account'.tr),
                                    TextButton(
                                        onPressed: () => widget.toggleView(),
                                        child: Text('sign_up'.tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 10,
                        child: OutlinedButton(
                            onPressed: () => Get.to(const LanguageScreen()),
                            style: OutlinedButton.styleFrom(
                                shape: const StadiumBorder()),
                            child: Text(
                              'language'.tr,
                              style: Get.textTheme.titleMedium!
                                  .copyWith(color: const Color(0xFF041E48)),
                            )),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
