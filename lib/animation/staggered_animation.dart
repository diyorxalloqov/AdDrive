import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class StaggerAnimation extends StatelessWidget {
  final VoidCallback? onTap;
  final String? title;
  final AnimationController? animationController;
  final Animation? widthAnimation;
  final Color? color;

  StaggerAnimation({Key? key, this.onTap, this.title, this.animationController,this.color}): widthAnimation = Tween(begin: 320.0, end: 45.0,).animate(CurvedAnimation(parent: animationController!, curve: const Interval(0.0, 0.150))), super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: animationController!, builder: _buildAnimation);
  }

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: widthAnimation!.value, height: 45.0, alignment: FractionalOffset.center,
        decoration: BoxDecoration(color: color, borderRadius: const BorderRadius.all(Radius.circular(25.0))),
        child: widthAnimation?.value > 75.0
            ? Text(title != null ? title!.tr : '',style: const TextStyle(color: Colors.white),)
            : const SizedBox(width: 20.0, height: 20.0,
                child: CircularProgressIndicator(value: null, strokeWidth: 1.0, valueColor: AlwaysStoppedAnimation<Color>(Colors.white),),),
      ),
    );
  }
}
