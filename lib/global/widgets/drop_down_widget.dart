/*
 *  (c) Diyor Xalloqov 2024.8.15 Toshkent, Uzbekistan
 *  github: https://github.com/diyorxalloqov
 *  LinkedIn: https://www.linkedin.com/in/diyor-xalloqov-024b63231/
 *  Telegram: https://t.me/Flutter_dart_developer
 */

import 'package:flutter_texi_tracker/global/imports/app_imports.dart';

class DropdownWidget extends StatelessWidget {
  final String value;
  final List<DropdownMenuItem<String>>? items;
  final Function(String?) onChanged;
  const DropdownWidget(
      {super.key,
      required this.value,
      required this.items,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: context.theme.colorScheme.onErrorContainer,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xffCCCFD3), width: 1)),
      child: DropdownButton<String>(
          underline: const SizedBox.shrink(),
          dropdownColor: context.theme.cardColor,
          style: context.theme.textTheme.labelMedium,
          focusColor: Colors.transparent,
          icon: const Icon(Icons.keyboard_arrow_down),
          borderRadius: BorderRadius.circular(8),
          isDense: true,
          isExpanded: true,
          value: value,
          items: items,
          onChanged: onChanged),
    );
  }
}
