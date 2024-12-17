import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_texi_tracker/app_config/app_config.dart';
import 'package:flutter_texi_tracker/generated/assets.dart';
import 'package:flutter_texi_tracker/screens/wrapper/location_wrapper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInCubic,
    ));

    _animationController.forward();

    Timer(
        const Duration(seconds: 4),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LocationWrapper())));
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.reset();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors().mainColor(1),
      body: FadeTransition(
        opacity: _animation,
        child: Center(
          child: SizedBox(
            height: 300.0,
            child: Image.asset(Assets.logoLauncherIconDark),
          ),
        ),
      ),
    );
  }
}
