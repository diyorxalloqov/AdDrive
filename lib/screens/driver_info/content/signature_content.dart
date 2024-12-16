
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_texi_tracker/screens/driver_info/content/input_card.dart';
import 'package:signature/signature.dart';

class SignatureContent extends StatefulWidget {
  SignatureController controller;
  final Function() onTap;
  SignatureContent({
    super.key, required this.controller, required this.onTap
  });

  @override
  State<SignatureContent> createState() => _SignatureContentState();
}

class _SignatureContentState extends State<SignatureContent> {
  @override
  Widget build(BuildContext context) {
    return InputCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16, top: 20, bottom: 8),
            child: Column(
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 4,
                      backgroundColor: Colors.red,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        "Diver's Signature",
                        style: TextStyle(
                            fontSize: 16.r, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.black.withOpacity(0.1),
          ),
          const SizedBox(height: 16),
          Signature(
            controller: widget.controller,
            backgroundColor: Colors.grey[200]!,
            height: 200,
            width: 300,
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: InkWell(
              onTap: (){
                setState(() {
                  widget.controller.clear();
                });
              },
              child: InputCard(
                padding: const EdgeInsets.only(top: 4, bottom: 4),
                margin: const EdgeInsets.only(top: 4, bottom: 4, left: 200, right: 12),
                borderRadius: BorderRadius.circular(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.clear,
                      color: Colors.blue.shade300,
                      size: 22,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    const Text(
                      "Clear",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
