import 'dart:io';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_texi_tracker/global/imports/app_imports.dart';
import 'package:flutter_texi_tracker/screens/auth/widgets/succes_dialog.dart';

class UserSignUp extends StatefulWidget {
  const UserSignUp({super.key});

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
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }

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
                      child: Padding(
                        padding: const EdgeInsets.only(left: 22, right: 22),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: Icon(
                                      Platform.isIOS
                                          ? Icons.arrow_back_ios
                                          : Icons.arrow_back,
                                      color: context.theme.canvasColor)),
                            ),
                            Image.asset(Assets.logoLauncherIcon,
                                color: CustomColors().mainColor(1),
                                scale: 3,
                                alignment: Alignment.center),
                            const SpaceHeight(height: 20),
                            Text('sign_up'.tr,
                                style: Get.textTheme.labelMedium),
                            const SpaceHeight(height: 20),
                            TextFormFieldWidget(
                              controller: _nameController,
                              validator: (val) =>
                                  val!.isEmpty ? 'enter_name_please'.tr : null,
                              prefixIconName: Assets.iconsProfile,
                              hintText: 'username'.tr,
                              onChanged: (val) {
                                setState(() {
                                  name = val;
                                });
                              },
                            ),
                            const SpaceHeight(height: 20),
                            TextFormFieldWidget(
                              controller: _phoneController,
                              validator: (val) =>
                                  val!.isEmpty ? 'enter_phone_please'.tr : null,
                              prefixIconName: Assets.iconsPhone,
                              hintText: 'phone'.tr,
                              onChanged: (val) {
                                setState(() {
                                  phone = val;
                                });
                              },
                            ),
                            const SpaceHeight(height: 20.0),
                            TextFormFieldWidget(
                              controller: _emailController,
                              validator: (val) =>
                                  val!.isEmpty ? 'enter_email_please'.tr : null,
                              prefixIconName: Assets.iconsEmail,
                              hintText: 'email'.tr,
                              onChanged: (val) {
                                setState(() {
                                  email = val;
                                });
                              },
                            ),
                            const SpaceHeight(height: 20.0),
                            TextFormFieldWidget(
                              controller: _passwordController,
                              validator: (val) => val!.isEmpty
                                  ? 'enter_password_please'.tr
                                  : null,
                              prefixIconName: Assets.iconsSecurity,
                              hintText: 'password'.tr,
                              onChanged: (val) {
                                setState(() {
                                  password = val;
                                });
                              },
                            ),
                            const SpaceHeight(height: 20.0),
                            TextFormFieldWidget(
                              controller: _confirmPasswordController,
                              validator: (val) => val!.isEmpty
                                  ? 'enter_confirm_password'.tr
                                  : null,
                              prefixIconName: Assets.iconsSecurity,
                              hintText: 'confirm_password'.tr,
                              onChanged: (val) {
                                setState(() {
                                  confirmPassword = val;
                                });
                              },
                            ),
                            const SpaceHeight(height: 20.0),
                            // Wrap(
                            //   crossAxisAlignment: WrapCrossAlignment.center,
                            //   spacing: 6,
                            //   children: [
                            //     Checkbox(
                            //         visualDensity: VisualDensity.comfortable,
                            //         value: isSelected,
                            //         onChanged: (bool? value) {
                            //           setState(() {
                            //             isSelected = value!;
                            //           });
                            //         }),
                            //     Text.rich(
                            //       TextSpan(
                            //         text: 'i_agree_to'.tr,
                            //         style: Theme.of(context)
                            //             .textTheme
                            //             .headlineLarge
                            //             ?.copyWith(
                            //                 color:
                            //                     Theme.of(context).canvasColor),
                            //         children: <TextSpan>[
                            //           TextSpan(
                            //             text: 'terms'.tr,
                            //             style:
                            //                 const TextStyle(color: Colors.red),
                            //             recognizer: TapGestureRecognizer()
                            //               ..onTap = () {
                            //                 Get.to(const TermsCondition());
                            //               },
                            //           ),
                            //           const TextSpan(text: ' & '),
                            //           TextSpan(
                            //             text: 'privacy_policy'.tr,
                            //             style:
                            //                 const TextStyle(color: Colors.red),
                            //             recognizer: TapGestureRecognizer()
                            //               ..onTap = () {
                            //                 Get.to(const PrivacyPolicy());
                            //               },
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    height: 1,
                                    width: 10,
                                    color: CustomColors().mainColor(1)),
                                const SpaceWidth(width: 20),
                                Text('or'.tr,
                                    style: context.theme.textTheme.labelMedium
                                        ?.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400)),
                                const SpaceWidth(width: 20),
                                Container(
                                    height: 1,
                                    width: 10,
                                    color: CustomColors().mainColor(1))
                              ],
                            ),
                            const SpaceHeight(height: 20.0),
                            GestureDetector(
                              onTap: () => googleSignIn(context),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: context.theme.dividerColor
                                          .withOpacity(0.1),
                                      width: 1),
                                ),
                                child:
                                    Image.asset(Assets.imagesGoogle, width: 30),
                              ),
                            ),
                            const SpaceHeight(height: 120.0),
                            CustomButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // if (isSelected == true) {

                                    controller.userRegistration(
                                        name: name,
                                        phone: phone,
                                        email: email,
                                        password: password,
                                        confirmPassword: confirmPassword);

                                    // } else {
                                    //   Get.snackbar('',
                                    //       'Please agree to Terms & Privacy policy',
                                    //       snackPosition: SnackPosition.BOTTOM);
                                    // }
                                  }
                                },
                                padding: EdgeInsets.zero,
                                title: 'registration'.tr),
                            const SpaceHeight(height: 20)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }
}
