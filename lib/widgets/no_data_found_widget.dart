import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../app_config/app_config.dart';

class NoDataFoundWidget extends StatelessWidget {

  final String title;
  final String assetImage;

  const NoDataFoundWidget({
    super.key,
    this.title = 'No Data Found',
    this.assetImage = 'asset/logo/no_data_found.json'
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(assetImage, repeat: false, height: 200),
            Text(title, style: TextStyle(color: CustomColors().mainColor(1).withOpacity(0.4), fontSize: 18, fontWeight: FontWeight.w500),),
          ],
        ));
  }
}