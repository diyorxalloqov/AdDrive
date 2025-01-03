import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:addrive/screens/driver_info/content/input_card.dart';

class DriverDeclarationContent extends StatefulWidget {
  String? isDeclare;
  final ValueChanged<String?> onDeclareChanged; // Callback for updating parent

  DriverDeclarationContent({super.key, required this.isDeclare, required this.onDeclareChanged});

  @override
  _DriverDeclarationContentState createState() =>
      _DriverDeclarationContentState();
}

class _DriverDeclarationContentState extends State<DriverDeclarationContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: InputCard(
            child: Text(
              "Driver's Declaration",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.h, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        InputCard(
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
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        "I declare that the condition of the above vehicle is true and of acceptable use on the road.",
                        style: TextStyle(
                            fontSize: 16.r, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.black.withOpacity(0.2),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.blue, width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            widget.onDeclareChanged('Yes'); // Call parent callback
                            setState(() {
                              widget.isDeclare = 'Yes';
                            });
                          },
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(30),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: widget.isDeclare == 'Yes'
                                  ? Colors.blue.withOpacity(0.1)
                                  : Colors.transparent,
                              borderRadius: const BorderRadius.horizontal(
                                  left: Radius.circular(30)),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 12.h, horizontal: 40.w),
                            child: Center(
                              child: Text(
                                'Yes',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 40.h,
                        color: Colors.blue,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            widget.onDeclareChanged('No'); // Call parent callback
                            setState(() {
                              widget.isDeclare = 'No';
                            });
                          },
                          borderRadius: const BorderRadius.horizontal(
                            right: Radius.circular(30),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: widget.isDeclare == 'No'
                                  ? Colors.blue.withOpacity(0.1)
                                  : Colors.transparent,
                              borderRadius: const BorderRadius.horizontal(
                                  right: Radius.circular(30)),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 12.h, horizontal: 40.w),
                            child: Center(
                              child: Text(
                                'No',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
