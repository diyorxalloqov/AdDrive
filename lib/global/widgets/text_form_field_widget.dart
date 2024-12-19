/*
 *  (c) Diyor Xalloqov 2024.8.15 Toshkent, Uzbekistan
 *  github: https://github.com/diyorxalloqov
 *  LinkedIn: https://www.linkedin.com/in/diyor-xalloqov-024b63231/
 *  Telegram: https://t.me/Flutter_dart_developer
 */
/*
 * (c) Diyor Xalloqov 2024.8.18 Toshkent, Uzbekistan
 * github: https://github.com/diyorxalloqov
 * LinkedIn: https://www.linkedin.com/in/diyor-xalloqov-024b63231/
 * Telegram: https://t.me/Flutter_dart_developer
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_texi_tracker/app_config/app_config.dart';
import 'package:flutter_texi_tracker/generated/assets.dart';
import 'package:flutter_texi_tracker/utils/extensions/theme.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget? prefix;
  final Widget? suffixs;
  final bool? readOnly;
  final VoidCallback? onTap;
  final int? maxLength;
  final TextStyle? hintStyle;
  final bool? obscureText;
  final Widget? suffixIcon;
  final String? obscuringCharacter;
  final BoxConstraints? constraints;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final TextInputType? keyboardType;
  final int? maxLines;
  final EdgeInsets? contentPadding;
  final TextStyle? style;
  final TextAlignVertical? textAlignVertical;
  final String? errorText;
  final String? prefixIconName;
  final List<TextInputFormatter>? inputFormatters;

  const TextFormFieldWidget(
      {super.key,
      this.maxLines,
      this.prefixIconName,
      this.textAlignVertical,
      this.contentPadding,
      this.onFieldSubmitted,
      this.onChanged,
      this.inputFormatters,
      this.style,
      this.suffixIcon,
      this.obscureText,
      this.obscuringCharacter,
      this.hintStyle,
      this.maxLength,
      required this.controller,
      this.prefix,
      this.keyboardType,
      this.constraints,
      this.errorText,
      this.onTap,
      this.readOnly,
      this.validator,
      this.suffixs,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLength: maxLength,
      keyboardAppearance: context.isDark ? Brightness.dark : Brightness.light,
      maxLines: maxLines ?? 1,
      onFieldSubmitted: onFieldSubmitted,
      obscureText: obscureText ?? false,
      obscuringCharacter: obscuringCharacter ?? '*',
      style: style ??
          const TextStyle(
              fontSize: 14, fontFamily: "Inter", fontWeight: FontWeight.w400),
      onTap: onTap,
      onChanged: onChanged,
      readOnly: readOnly ?? false,
      keyboardType: keyboardType,
      validator: validator,
      textAlignVertical: textAlignVertical,
      inputFormatters: inputFormatters,
      cursorColor: context.isDark ? Colors.white : Colors.black,
      decoration: InputDecoration(
        counterText: '',
        errorText: errorText,
        errorStyle: const TextStyle(
            fontSize: 12, color: Colors.red, fontWeight: FontWeight.w400),
        suffixIcon: suffixs,
        contentPadding: contentPadding,
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                BorderSide(width: 1, color: CustomColors().secondColor(1))),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                width: 1, color: const Color(0xff004646).withOpacity(0.1))),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                width: 1, color: const Color(0xff004646).withOpacity(0.1))),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                width: 1, color: const Color(0xff004646).withOpacity(0.1))),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                width: 1, color: const Color(0xff004646).withOpacity(0.1))),
        suffix: suffixIcon,
        prefixIcon: prefix ??
            Container(
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  color: CustomColors().mainColor(1),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10))),
              padding: const EdgeInsets.all(16),
              child: SvgPicture.asset(prefixIconName ?? Assets.iconsPhone,
                  width: 20),
            ),
        hintStyle: hintStyle ??
            const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xff9A9A9A)),
        constraints: constraints ??
            BoxConstraints(
                maxHeight: App(context).appHeight(100),
                minHeight: App(context).appHeight(47)),
        hintText: hintText,
      ),
    );
  }
}
