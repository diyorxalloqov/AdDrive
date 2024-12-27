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

import 'package:flutter/services.dart';
import 'package:flutter_texi_tracker/global/imports/app_imports.dart';

class TextFormFieldWidget2 extends StatelessWidget {
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
  final String? errorText;
  final TextCapitalization? textCapitalization;
  final List<TextInputFormatter>? inputFormatters;

  const TextFormFieldWidget2(
      {super.key,
      this.maxLines,
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
        this.textCapitalization,
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
      keyboardAppearance: Get.isDarkMode ? Brightness.dark : Brightness.light,
      maxLines: maxLines ?? 1,
      onFieldSubmitted: onFieldSubmitted,
      obscureText: obscureText ?? false,
      obscuringCharacter: obscuringCharacter ?? '1',
      style: style ?? context.theme.textTheme.labelMedium,
      onTap: onTap,
      onChanged: onChanged,
      readOnly: readOnly ?? false,
      keyboardType: keyboardType,
      validator: validator,
      cursorColor: context.theme.canvasColor,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        counterText: '',
        errorText: errorText,
        errorStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        suffixIcon: suffixs,
        contentPadding: contentPadding,
        suffix: suffixIcon,
        prefixIcon: prefix,
        hintStyle: hintStyle,
        constraints: constraints ??
            BoxConstraints(
                maxHeight: App(context).appHeight(100),
                minHeight: App(context).appHeight(44)),
        hintText: hintText,
      ),
    );
  }
}
