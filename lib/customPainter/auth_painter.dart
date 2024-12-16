import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_texi_tracker/app_config/app_config.dart';

class AuthPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {

    Paint paint = Paint()
    ..color = CustomColors().mainColor(1);
    Path path = Path();
    path.lineTo(0.0, 0.0);
    path.lineTo(0.0, size.height/4);
    path.quadraticBezierTo(100.0, size.height/3, size.width, size.height/3);
    path.lineTo(size.width, 0.0);
    path.close();
    canvas.drawPath(path, paint);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}