import 'package:flutter/material.dart';
import 'package:flutter_texi_tracker/screens/auth/sign_in.dart';
import 'package:flutter_texi_tracker/controller/sign_in_controller.dart';
import 'package:flutter_texi_tracker/screens/auth/sign_up.dart';
import 'package:get/get.dart';

class UserAuthenticate extends StatefulWidget {
  const UserAuthenticate({super.key});

  @override
  UserAuthenticateState createState() => UserAuthenticateState();
}

class UserAuthenticateState extends State<UserAuthenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInUpController>(
      init: SignInUpController(),
      initState: (_) => SignInUpController(),
      builder: (controller) {
        return showSignIn
            ? UserSignUp(toggleView: toggleView)
            : UserSignIn(toggleView: toggleView);
      },
    );
  }
}
