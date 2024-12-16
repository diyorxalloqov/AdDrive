
import 'package:flutter/material.dart';

class RegisterFormField extends StatelessWidget {
  const RegisterFormField({
    super.key, this.hintText, this.controller
  });

  final String? hintText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF041E48)),
          borderRadius: BorderRadius.circular(8)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: TextFormField(
          controller: controller,
          validator: (value) => value!.isNotEmpty ? null : '$hintText must be filled',
          decoration: InputDecoration(
              border: InputBorder.none,
              labelStyle: const TextStyle(color:  Color(0xFF041E48)),
              labelText: hintText ?? "First Name"
          ),
        ),
      ),
    );
  }
}