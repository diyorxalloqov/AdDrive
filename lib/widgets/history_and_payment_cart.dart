import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryAndPaymentCart extends StatelessWidget {
  const HistoryAndPaymentCart(
      {super.key,
      this.title,
      this.invoiceOrCarNo,
      this.date,
      this.imageData,
      this.amount,
      this.duration,
      this.onPressed});
  final String? title;
  final String? invoiceOrCarNo;
  final String? date;
  final String? imageData;
  final String? amount;
  final String? duration;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$title',
                  style: Get.textTheme.headlineMedium
                      ?.copyWith(fontWeight: FontWeight.w600, height: 1.4),
                ),
                Text('$invoiceOrCarNo',
                    style: Get.textTheme.bodyMedium?.copyWith(height: 1.4)),
                Wrap(
                  children: [
                    Text('$date',
                        style: Get.textTheme.bodyMedium?.copyWith(height: 1.4)),
                    duration != null
                        ? Text(',$duration',
                            style:
                                Get.textTheme.bodyMedium?.copyWith(height: 1.4))
                        : const SizedBox(),
                  ],
                ),
              ],
            ),
          ),
          InkWell(
            onTap: onPressed,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('$imageData', height: 45),
                Text('$amount')
              ],
            ),
          )
        ],
      ),
    );
  }
}
