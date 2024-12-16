import 'package:flutter/material.dart';
import 'package:flutter_texi_tracker/routes/app_routes.dart';
import 'package:flutter_texi_tracker/controller/owner_profile_controller.dart';
import 'package:flutter_texi_tracker/widgets/error_screen.dart';
import 'package:flutter_texi_tracker/widgets/history_and_payment_cart.dart';
import 'package:get/get.dart';

class HistoryScreen extends StatelessWidget {

  final historyController = Get.find<OwnerProfileController>();

  HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      return historyController.historyData.value != null
          ? RefreshIndicator(
              color: Colors.red,
              onRefresh: () async {
                await historyController.getDrivingHistory();
              },
              child: historyController.historyData.value?.data?.isNotEmpty == true
                  ? ListView.builder(
                      itemCount: historyController.historyData.value!.data!.length,
                      itemBuilder: (context, index) {

                        final data = historyController.historyData.value!.data![index];

                        return HistoryAndPaymentCart(
                          title: '${data.name}',
                          invoiceOrCarNo: 'Car: ${data.name}',
                          date: '${data.date}',
                          imageData: 'asset/icons/driving-history-map-icon.png',
                          amount: '${data.distance} KM',
                          duration: '${data.durations} Hrs',
                          onPressed: () => Get.toNamed(
                              AppRoutes.mapPolyLinePage,
                              arguments: data.id),
                        );
                      })
                  : ErrorScreen(
                      title: 'no_driving_history'.tr,
                      subTitle: 'check_after_ext_trip'.tr,
                      onPressed: () async {
                        await historyController.getDrivingHistory();
                      },
                    ),
            )
          : const Center(child: Text('No history Found'));
    }));
  }
}
