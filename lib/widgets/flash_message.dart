// import 'package:flash/flash.dart';
// import 'package:flutter/material.dart';
//
// class FlashMsg {
//   FlashMsg.success(context, message, {title = 'success !!!', topMargin = 0.0}) {
//     showFlash(
//         context: context,
//         duration: const Duration(seconds: 3),
//         builder: (context, controller) {
//           return _FlashMessage(
//             controller: controller,
//             title: title,
//             message: message,
//             topMargin: topMargin,
//             background: Colors.green.shade900,
//           );
//         });
//   }
//
//   FlashMsg.error(context, message, {title = 'Error !!!', topMargin = 0.0}) {
//     showFlash(
//         context: context,
//         duration: const Duration(seconds: 3),
//         builder: (context, controller) {
//           return _FlashMessage(
//             controller: controller,
//             title: title,
//             message: message,
//             topMargin: topMargin,
//             background: Colors.red,
//           );
//         });
//   }
// }
//
// class _FlashMessage extends StatelessWidget {
//   final String? title;
//   final String? message;
//   final background;
//   final controller;
//   final topMargin;
//
//   const _FlashMessage(
//       {this.title,
//       this.message,
//       this.background,
//       @required this.controller,
//       this.topMargin});
//
//   @override
//   Widget build(BuildContext context) {
//     return Flash(
//         controller: controller,
//         borderRadius: BorderRadius.zero,
//         backgroundColor: background ?? Theme.of(context).primaryColor,
//         position: FlashPosition.top,
//         margin: topMargin != null
//             ? EdgeInsets.only(top: topMargin)
//             : EdgeInsets.zero,
//         horizontalDismissDirection: HorizontalDismissDirection.horizontal,
//         child: FlashBar(
//             icon: const Icon(
//               Icons.check,
//               color: Colors.white,
//             ),
//             title: Text(
//               title!,
//               style: const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w700,
//                   fontSize: 15.0),
//             ),
//             content: Text(
//               message!,
//               style: const TextStyle(color: Colors.white, fontSize: 15.0),
//             )));
//   }
// }
