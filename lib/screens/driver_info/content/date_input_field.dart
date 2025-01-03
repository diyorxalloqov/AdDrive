import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:addrive/screens/driver_info/content/input_card.dart';

class DateInputField extends StatefulWidget {
  final String? title;
  final TextEditingController? controller;
  final Function()? onClick;

  const DateInputField({super.key, this.title, this.controller, this.onClick});

  @override
  _DateInputFieldState createState() => _DateInputFieldState();
}

class _DateInputFieldState extends State<DateInputField> {

  @override
  Widget build(BuildContext context) {
    return InputCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16,
              top: 20,
              bottom: 8,
            ),
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
                  widget.title ?? "",
                  style: TextStyle(
                    fontSize: 16.r,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Image.asset(
                  'asset/icons/driver_icons/date.png',
                  height: 30,
                )
              ],
            ),
          ),
          Divider(
            color: Colors.black.withOpacity(0.1),
          ),
          GestureDetector(
            onTap:widget.onClick,
            child: AbsorbPointer(
              child: TextFormField(
                controller: widget.controller,
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  border: InputBorder.none,
                  hintText: "Select date",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
        ],
      ),
    );
  }
}
