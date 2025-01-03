import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:addrive/animation/staggered_animation.dart';

class ErrorScreen extends StatefulWidget {

  const ErrorScreen({Key? key,this.title,this.subTitle,this.btnTitle = 'refresh', this.onPressed}) : super(key: key);

  final String? title;
  final String? subTitle;
  final String? btnTitle;
  final Function? onPressed;


  @override
  ErrorScreenState createState() => ErrorScreenState();
}

class ErrorScreenState extends State<ErrorScreen> with TickerProviderStateMixin{

  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(vsync: this,duration: const Duration(milliseconds: 3000));
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  Future<void> playAnimation() async {
    try{
      await animationController?.forward();

      Timer(const Duration(seconds: 2), () async {
        await stopAnimation();
      });
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> stopAnimation() async {
    try{
      await animationController?.reverse();
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'asset/error_img.png',
            height: 80,
            width: 80,
          ),
          const SizedBox(
            height: 10,
          ),
          Text('${widget.title}',
              style: const TextStyle(
                  fontSize: 18,
                  height: 1.1,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                  color: Color(0xFF222222))),
          const SizedBox(
            height: 16,
          ),
          Text('${widget.subTitle}',
              style: const TextStyle(
                  fontSize: 16,
                  height: 1,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.5,
                  color: Color(0xFF555555))),

          const SizedBox(height: 16.0,),
          StaggerAnimation(
            title: '${widget.btnTitle}',
            color: const Color(0xFF0B2154),
            animationController: animationController,
            onTap: (){
              playAnimation();
              widget.onPressed!();
            },
          ),
        ],
      ),
    );
  }
}
