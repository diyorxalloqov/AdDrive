import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:addrive/screens/driver_info/content/input_card.dart';

class CustomFromFiled extends StatelessWidget {
  final String? title;
  final TextEditingController? controller;
  const CustomFromFiled({super.key, this.title, this.controller});

  @override
  Widget build(BuildContext context) {
    return InputCard(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16, top: 20, bottom: 8),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 4,
                    backgroundColor: Colors.red,
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    title ?? "",
                    style:
                        TextStyle(fontSize: 16.r, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.black.withOpacity(0.1),
            ),
            TextFormField(
              controller: controller,
              decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  border: InputBorder.none,
                  hintText: "Type here",
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400)),
            ),
            SizedBox(
              height: 8.h,
            ),
          ],
        ));
  }
}
