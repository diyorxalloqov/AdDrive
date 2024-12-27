import 'dart:io';

import 'package:flutter_texi_tracker/global/imports/app_imports.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? leadingTap;
  final String? titleText;
  final bool? notLeading;
  final bool? centerTitle;
  final PreferredSizeWidget? bottom;

  const AppBarWidget(
      {super.key,
      this.centerTitle,
      this.titleText,
      this.leadingTap,
      this.notLeading,
      this.bottom});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: InkWell(
          onTap: leadingTap ?? () => Navigator.pop(context),
          child: Icon(
            Platform.isIOS ? Icons.arrow_back_ios_new : Icons.arrow_back,
            color: context.isDarkMode ? Colors.white : Colors.black,
            size: 20,
          )),
      centerTitle: centerTitle,
      title: Text(titleText ?? '', style: context.theme.textTheme.labelMedium),
      bottom: bottom,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
