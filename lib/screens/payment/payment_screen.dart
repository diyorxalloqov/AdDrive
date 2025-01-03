// import 'package:flutter/material.dart';
// import 'package:addrive/controller/payment_controller.dart';
// import 'package:addrive/widgets/error_screen.dart';
// import 'package:addrive/widgets/history_and_payment_cart.dart';
// import 'package:get/get.dart';
//
// class PaymentScreen extends StatelessWidget {
//   const PaymentScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<PaymentController>();
//
//     return RefreshIndicator(
//       color: Colors.red,
//       onRefresh: () async {
//         await controller.getDriverPayment();
//       },
//       child: Scaffold(
//           body: controller.obx(
//               (state) => state?.data?.isNotEmpty == true ? ListView.builder(
//                     physics: const AlwaysScrollableScrollPhysics(),
//                     itemCount: state?.data?.length ?? 0,
//                     itemBuilder: (BuildContext context, int index) {
//                       final data = state?.data?[index];
//                       return HistoryAndPaymentCart(
//                         title: '${data?.name}',
//                         invoiceOrCarNo: '${data?.invoiceNumber}',
//                         date: '${data?.paymentDate}',
//                         imageData: 'asset/icons/payment-history-icon.png',
//                         amount: '${data?.amount} ${controller.currency ?? ''}',
//                       );
//                     },
//                   ) : ErrorScreen(
//                 title: 'no_payment_history'.tr,
//                 subTitle: 'check_after_next_trip'.tr,
//                 onPressed: () async {
//                   await controller.getDriverPayment();
//                 },
//               ),
//               onEmpty: ErrorScreen(
//                 title: 'no_payment_history'.tr,
//                 subTitle: 'check_after_next_trip'.tr,
//                 onPressed: () async {
//                   await controller.getDriverPayment();
//                 },
//               ))
//           // Obx(() {
//           //   return
//           //     controller.paymentData.value != null
//           //       ? controller.paymentData.value.data.length > 0 ?
//           //     ListView.builder(
//           //           itemCount: controller.paymentData.value.data.length,
//           //           itemBuilder: (BuildContext context, int index) {
//           //             final data = controller.paymentData.value.data[index];
//           //             return HistoryAndPaymentCart(
//           //               title: '${data.name}',
//           //               invoiceOrCarNo: '${data.invoiceNumber}',
//           //               date: '${data.paymentDate}',
//           //               imageData: 'asset/icons/payment-history-icon.png',
//           //               amount: '${data.amount} TK',
//           //             );
//           //           },
//           //         ) :
//           //     ErrorScreen(
//           //     title: 'no_payment_history'.tr,
//           //     subTitle: 'check_after_next_trip'.tr,
//           //     onPressed: () async {
//           //       await controller.getDriverPayment();
//           //     },
//           //   ) : SizedBox();
//           // }),
//           ),
//     );
//   }
// }
//
// ///Error screen demo
// ///when implemented then will be removed this comments and below code
// /*ErrorScreen(
//             title: 'No Driving History',
//             subTitle: 'Check after next trip',
//             onPressed: ()=> print('hello'),
//           )*/
