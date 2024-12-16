import 'package:flutter/material.dart';
import 'package:flutter_texi_tracker/app_config/utils.dart';
import 'package:flutter_texi_tracker/controller/registration_controller.dart';
import 'package:flutter_texi_tracker/generated/assets.dart';
import 'package:flutter_texi_tracker/language/language_screen.dart';
import 'package:flutter_texi_tracker/screens/auth/content/auth_form_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegistrationProvider(),
      child: Consumer<RegistrationProvider>(builder: (context, provider, _) {
        return Scaffold(
          body: Form(
            key: provider.formKey,
            child: SafeArea(
              child: Stack(
                children: [
                  Image.asset(
                    shapeLoginFlow,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 22, right: 22, top: 40),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(Assets.logoLauncherIcon, scale: 4),
                            const SizedBox(height: 16.0),
                            Text('Sign Up'.tr, style: Get.textTheme.titleLarge),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      provider.index = 0;
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 12),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: const Color(0xFF041E48)),
                                          color: provider.index == 0
                                              ? const Color(0xFF041E48)
                                              : Colors.white),
                                      child: Center(
                                          child: Text(
                                        "Profile\nDetails",
                                        style: TextStyle(
                                            color: provider.index == 0
                                                ? Colors.white
                                                : const Color(0xFF041E48),
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        provider.index = 1;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 12),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: const Color(0xFF041E48)),
                                          color: provider.index == 1
                                              ? const Color(0xFF041E48)
                                              : Colors.white),
                                      child: Center(
                                          child: Text("Vehicle\nDetails",
                                              style: TextStyle(
                                                  color: provider.index == 1
                                                      ? Colors.white
                                                      : const Color(0xFF041E48),
                                                  fontSize: 12,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      provider.index = 2;
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 12),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: const Color(0xFF041E48)),
                                          color: provider.index == 2
                                              ? const Color(0xFF041E48)
                                              : Colors.white),
                                      child: Center(
                                          child: Text("Drivers\nLicense",
                                              style: TextStyle(
                                                  color: provider.index == 2
                                                      ? Colors.white
                                                      : const Color(0xFF041E48),
                                                  fontSize: 12,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            provider.index == 0
                                ? profileDetailsInfo(provider)
                                : provider.index == 1
                                    ? vehicleDetailsInfo(provider)
                                    : provider.index == 2
                                        ? driverLicenseInfo(provider)
                                        : const SizedBox(
                                            height: 10,
                                          ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Already have an account?'.tr),
                                  GestureDetector(
                                    onTap: () {
                                      // widget.toggleView();
                                      //Navigator.push(context,  MaterialPageRoute(builder: (context) => const UserSignIn()),);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        'Sign In'.tr,
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
          ),
        );
      }),
    );
  }

  Column driverLicenseInfo(RegistrationProvider provider) {
    return Column(
      children: [
        const Text("Take a photo of your driver license"),
        const SizedBox(height: 16),
        InkWell(
          onTap: () => provider.licenseFrontPickImage(context),
          child: Container(
            height: 150,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              border: Border.all(color: const Color(0xFF041E48)),
            ),
            child: provider.licenseFrontImagePath == null
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt_outlined,
                          size: 50, color: Color(0xFF041E48)),
                      SizedBox(height: 2),
                      Center(
                        child: Text(
                          "Take license front side photo",
                          style:
                              TextStyle(color: Color(0xFF041E48), fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )
                : Image.file(
                    provider.licenseFrontImagePath!,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        InkWell(
          onTap: () => provider.licenseBackPickImage(context),
          child: Container(
            height: 150,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              border: Border.all(color: const Color(0xFF041E48)),
            ),
            child: provider.licenseBackImagePath == null
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt_outlined,
                          size: 50, color: Color(0xFF041E48)),
                      SizedBox(height: 2),
                      Center(
                        child: Text(
                          "Take license back side photo",
                          style:
                              TextStyle(color: Color(0xFF041E48), fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )
                : Image.file(
                    provider.licenseBackImagePath!,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        InkWell(
            onTap: () {
              if (provider.formKey.currentState!.validate()) {
                if (provider.licenseFrontImagePath?.path == null ||
                    provider.licenseBackImagePath?.path == null) {
                  Fluttertoast.showToast(
                      msg: "License side image is required",
                      backgroundColor: Colors.deepOrange);
                } else {
                  !provider.isLoading;
                  provider.registerUser(context);
                }
              }
            },
            child: Center(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 44,
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 26),
                  decoration: BoxDecoration(
                      color: const Color(0xFF041E48),
                      borderRadius: BorderRadius.circular(8)),
                  child: provider.isLoading
                      ? const Center(
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          ),
                        )
                      : const Center(
                          child: Text(
                            "Save",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        )),
            )),
      ],
    );
  }

  Column vehicleDetailsInfo(RegistrationProvider provider) {
    return Column(
      children: [
        const Text("Provide Photo of your vehicle"),
        const SizedBox(height: 16),
        RegisterFormField(
          hintText: "Car Make",
          controller: provider.carMakeController,
        ),
        const SizedBox(
          height: 16,
        ),
        RegisterFormField(
          hintText: "Car Model",
          controller: provider.carModelController,
        ),
        const SizedBox(
          height: 16,
        ),
        RegisterFormField(
          hintText: "License Plate number",
          controller: provider.carDetailsController,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => provider.carFrontPickImage(context),
                child: Container(
                  height: 90,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    border: Border.all(color: const Color(0xFF041E48)),
                  ),
                  child: provider.carFrontSiteImagePath == null
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt_outlined,
                                color: Color(0xFF041E48)),
                            SizedBox(height: 2),
                            Center(
                              child: Text(
                                "Take vehicle front side photo",
                                style: TextStyle(
                                    color: Color(0xFF041E48), fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        )
                      : Image.file(
                          provider.carFrontSiteImagePath!,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: InkWell(
                onTap: () => provider.carBackPickImage(context),
                child: Container(
                  height: 90,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    border: Border.all(color: const Color(0xFF041E48)),
                  ),
                  child: provider.carBackSiteImagePath == null
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt_outlined,
                                color: Color(0xFF041E48)),
                            SizedBox(height: 2),
                            Center(
                              child: Text(
                                "Take vehicle back side photo",
                                style: TextStyle(
                                    color: Color(0xFF041E48), fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        )
                      : Image.file(
                          provider.carBackSiteImagePath!,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => provider.driverSidePickImage(context),
                child: Container(
                  height: 90,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    border: Border.all(color: const Color(0xFF041E48)),
                  ),
                  child: provider.driverSideImagePath == null
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt_outlined,
                                color: Color(0xFF041E48)),
                            SizedBox(height: 2),
                            Center(
                              child: Text(
                                "Take Driver side photo",
                                style: TextStyle(
                                    color: Color(0xFF041E48), fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        )
                      : Image.file(
                          provider.driverSideImagePath!,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: InkWell(
                onTap: () => provider.passengerSidePickImage(context),
                child: Container(
                  height: 90,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    border: Border.all(color: const Color(0xFF041E48)),
                  ),
                  child: provider.passengerSideImagePath == null
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt_outlined,
                                color: Color(0xFF041E48)),
                            SizedBox(height: 2),
                            Center(
                              child: Text(
                                "Take Passenger side photo",
                                style: TextStyle(
                                    color: Color(0xFF041E48), fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        )
                      : Image.file(
                          provider.passengerSideImagePath!,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        InkWell(
            onTap: () {
              if (provider.formKey.currentState!.validate()) {
                setState(() {
                  if (provider.carFrontSiteImagePath?.path == null) {
                    Fluttertoast.showToast(
                        msg: "Vehicle Front side image is required",
                        backgroundColor: Colors.deepOrange);
                  } else if (provider.carBackSiteImagePath?.path == null) {
                    Fluttertoast.showToast(
                        msg: "Vehicle Back side image is required",
                        backgroundColor: Colors.deepOrange);
                  } else if (provider.driverSideImagePath?.path == null) {
                    Fluttertoast.showToast(
                        msg: "Driver side image is required",
                        backgroundColor: Colors.deepOrange);
                  } else if (provider.passengerSideImagePath?.path == null) {
                    Fluttertoast.showToast(
                        msg: "Passenger Front side image is required",
                        backgroundColor: Colors.deepOrange);
                  } else {
                    provider.index = 2;
                  }
                });
              }
            },
            child: Center(
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 26),
                  decoration: BoxDecoration(
                      color: const Color(0xFF041E48),
                      borderRadius: BorderRadius.circular(8)),
                  child: const Text(
                    "Next",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )),
            )),
      ],
    );
  }

  Column profileDetailsInfo(RegistrationProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Your Information",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF041E48)),
        ),
        const SizedBox(
          height: 16,
        ),
        RegisterFormField(
          hintText: "First Name",
          controller: provider.firstNameController,
        ),
        const SizedBox(
          height: 16,
        ),
        RegisterFormField(
          hintText: "Last Name",
          controller: provider.lastNameController,
        ),
        const SizedBox(
          height: 16,
        ),
        RegisterFormField(
          hintText: "Email",
          controller: provider.emailController,
        ),
        const SizedBox(
          height: 16,
        ),
        RegisterFormField(
          hintText: "Phone Number",
          controller: provider.phoneController,
        ),
        const SizedBox(
          height: 16,
        ),
        RegisterFormField(
          hintText: "Password",
          controller: provider.passwordController,
        ),
        const SizedBox(
          height: 16,
        ),
        RegisterFormField(
          hintText: "password Confirmation",
          controller: provider.passwordConfirmationController,
        ),
        const SizedBox(
          height: 16,
        ),
        InkWell(
            onTap: () {
              if (provider.formKey.currentState!.validate()) {
                if (provider.passwordController.text ==
                    provider.passwordConfirmationController.text) {
                  if (provider.passwordController.text.length >= 8) {
                    if (isValidEmail(email: provider.emailController.text)) {
                      provider.index = 1;
                    } else {
                      Fluttertoast.showToast(
                          msg: "Please provide a valid email",
                          backgroundColor: Colors.deepOrange);
                    }
                  } else {
                    Fluttertoast.showToast(
                        msg: "Password must be 8 character long",
                        backgroundColor: Colors.deepOrange);
                  }
                } else {
                  Fluttertoast.showToast(
                      msg: "Password and confirm password not matched",
                      backgroundColor: Colors.deepOrange);
                }
              }
            },
            child: Center(
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 26),
                  decoration: BoxDecoration(
                      color: const Color(0xFF041E48),
                      borderRadius: BorderRadius.circular(8)),
                  child: const Text(
                    "Next",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )),
            )),
      ],
    );
  }
}

bool isValidEmail({required String email}) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}
