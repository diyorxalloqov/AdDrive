import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_texi_tracker/screens/driver_info/content/input_card.dart';

class VehicleInspectionRadioTheme extends StatefulWidget {
  bool isDamage;
  bool isWashed;

  // Add callbacks to update state
  final ValueChanged<bool> onDamageChanged;
  final ValueChanged<bool> onWashedChanged;

  VehicleInspectionRadioTheme({
    super.key,
    required this.isDamage,
    required this.isWashed,
    required this.onDamageChanged, // Callback for damage
    required this.onWashedChanged,  // Callback for washed
  });

  @override
  State<VehicleInspectionRadioTheme> createState() =>
      _VehicleInspectionRadioThemeState();
}

class _VehicleInspectionRadioThemeState
    extends State<VehicleInspectionRadioTheme> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: InputCard(
            child: Text(
              "Vehicle Inspection",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.h, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        RadioTheme(
          data: RadioThemeData(
            fillColor: MaterialStateProperty.resolveWith(
                  (states) {
                if (states.contains(MaterialState.selected)) {
                  return Colors.red;
                }
                return Colors.black.withOpacity(0.2);
              },
            ),
          ),
          child: InputCard(
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
                          "Check the listed items below to confirm your bi-weekly vehicle inspection",
                          style: TextStyle(
                              fontSize: 16.r, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.black.withOpacity(0.1)),
                CheckboxListTile(
                  title: const Text("No damage to car branding", style: TextStyle(fontWeight: FontWeight.w500)),
                  value: widget.isDamage,
                  activeColor: Colors.deepOrangeAccent,
                  onChanged: (newValue) {
                    widget.onDamageChanged(newValue!); // Call parent callback
                  },
                  controlAffinity: ListTileControlAffinity.leading, // Position of the checkbox
                ),
                Divider(color: Colors.black.withOpacity(0.1)),
                CheckboxListTile(
                  title: const Text("Car is washed and body kept clean", style: TextStyle(fontWeight: FontWeight.w500)),
                  activeColor: Colors.deepOrangeAccent,
                  value: widget.isWashed,
                  onChanged: (newValue) {
                    widget.onWashedChanged(newValue!); // Call parent callback
                  },
                  controlAffinity: ListTileControlAffinity.leading, // Position of the checkbox
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
