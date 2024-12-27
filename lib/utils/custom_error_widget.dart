import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key, this.errorDetails});
  final FlutterErrorDetails? errorDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: kDebugMode
          ? Text(errorDetails?.exception.toString() ?? '')
          : const CircularProgressIndicator(color: Colors.red),
    );
  }
}
