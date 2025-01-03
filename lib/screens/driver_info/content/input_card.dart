import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:addrive/screens/driver_info/content/custom_card_decoration.dart';

class InputCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final BorderRadiusGeometry? borderRadius;

  const InputCard({
    super.key,
    required this.child,
    this.margin,
    this.padding,
    this.color,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.symmetric(horizontal: 8.w),
      padding: padding ?? EdgeInsets.all(12.w),
      decoration: CUSTOM_CARD_DECORATION.copyWith(
          color: color,
          borderRadius: borderRadius ?? BorderRadius.circular(16)),
      child: child,
    );
  }
}
