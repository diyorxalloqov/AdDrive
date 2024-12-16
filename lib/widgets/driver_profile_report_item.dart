import 'package:flutter/material.dart';
import 'package:flutter_texi_tracker/model/driver_report_model.dart';
import 'package:flutter_texi_tracker/routes/app_routes.dart';
import 'package:get/get.dart';

class DriverProfileReportItem extends StatelessWidget {

  final DriverReport report;

   const DriverProfileReportItem({Key? key, required this.report}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text('${report.name}', style: Get.textTheme.bodyMedium,maxLines: 2,overflow: TextOverflow.ellipsis,)),
          Expanded(child: Text('${report.date}', style: Get.textTheme.bodyMedium,maxLines: 1,overflow: TextOverflow.ellipsis,)),
          Expanded(child: Text('${report.time}', style: Get.textTheme.bodyMedium?.copyWith(color: Colors.green),maxLines: 1,overflow: TextOverflow.ellipsis,)),
          Expanded(child: Text('${report.distance}', style: Get.textTheme.bodyMedium,maxLines: 1,overflow: TextOverflow.ellipsis,)),
          IconButton(onPressed: (){
            Get.toNamed(AppRoutes.mapPolyLinePage, arguments: report.trackingId);
          }, icon: const Icon(Icons.location_on_outlined,color: Colors.red,))
        ],
      ),
    );
  }
}
class DriverProfileReportHeader extends StatelessWidget {
  const DriverProfileReportHeader({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      color: Colors.grey[300],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text('Name', style: Get.textTheme.bodyLarge)),
          Expanded(child: Text('Date', style: Get.textTheme.bodyLarge)),
          Expanded(child: Text('Time', style: Get.textTheme.bodyLarge)),
          Expanded(child: Text('Distance', style: Get.textTheme.bodyLarge)),
          const IconButton(onPressed: null, icon: Icon(Icons.location_on_outlined,color: Colors.transparent,))
        ],
      ),
    );
  }
}

