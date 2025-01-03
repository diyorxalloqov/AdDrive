// /*
//  *  (c) Diyor Xalloqov 2024.8.15 Toshkent, Uzbekistan
//  *  github: https://github.com/diyorxalloqov
//  *  LinkedIn: https://www.linkedin.com/in/diyor-xalloqov-024b63231/
//  *  Telegram: https://t.me/Flutter_dart_developer
//  */
//
// import 'package:addrive/global/imports/app_imports.dart';
//
// import 'package:fl_chart/fl_chart.dart';
//
// class LineChartWidget extends StatefulWidget {
//   const LineChartWidget({super.key});
//
//   @override
//   State<StatefulWidget> createState() => LineChartWidgetState();
// }
//
// class LineChartWidgetState extends State<LineChartWidget> {
//   late List<double> y; //! change y values
//
//   @override
//   void initState() {
//     y = widget.state.y;
//     super.initState();
//   }
//
//   LineChartData get lineChart => LineChartData(
//       lineTouchData: lineTouchData,
//       gridData: FlGridData(
//           show: true,
//           horizontalInterval: 6,
//           verticalInterval: 2,
//           getDrawingHorizontalLine: (value) =>
//           const FlLine(color: Color(0xffF0F0F0), strokeWidth: 2.3),
//           getDrawingVerticalLine: (value) =>
//           const FlLine(color: Color(0xffF0F0F0), strokeWidth: 2.3),
//           drawHorizontalLine: true,
//           drawVerticalLine: true),
//       borderData: FlBorderData(
//           show: true,
//           border: Border.all(color: const Color(0xffF0F0F0), width: 2.3)),
//       titlesData: FlTitlesData(
//           show: true,
//           leftTitles: AxisTitles(
//               sideTitles: SideTitles(
//                   showTitles: false,
//                   reservedSize: 60,
//                   interval: widget.state.allItems / widget.state.y.length,
//                   maxIncluded: false,
//                   getTitlesWidget: (double value, TitleMeta meta) {
//                     int index = value.toInt();
//                     // List<CompanyStatusModel> sortedList =
//                     // List.from(widget.state.companyStatusModel)
//                     //   ..sort((a, b) =>
//                     //   a.amount
//                     //       ?.toDouble()
//                     //       .compareTo(b.amount?.toDouble() ?? 0) ??
//                     //       0);
//                     // print(sortedList.length);
//
//                     return SideTitleWidget(
//                         axisSide: meta.axisSide,
//                         child: Text('$index',
//                             // '${sortedList[index].amount}',
//                             style: context.theme.textTheme.headlineMedium
//                                 ?.copyWith(
//                                 color: context.theme.colorScheme.primary)));
//                   })),
//           topTitles:
//           const AxisTitles(sideTitles: SideTitles(showTitles: false)),
//           rightTitles:
//           const AxisTitles(sideTitles: SideTitles(showTitles: false)),
//           bottomTitles: AxisTitles(
//               sideTitles: SideTitles(
//                 showTitles: true,
//                 reservedSize: 32,
//                 interval: 1,
//                 getTitlesWidget: (double value, TitleMeta meta) {
//                   int index = value.toInt() - 1;
//
//                   List<String> months =
//                       AppConstants.monthNames[GetStorage().read(Keys.lang)] ?? [];
//
//                   String monthName = '';
//                   if (index >= 0 && index < months.length) {
//                     monthName = months[index].substring(0, 3);
//                   }
//                   return SideTitleWidget(
//                     axisSide: meta.axisSide,
//                     angle: 1.577,
//                     space: 10,
//                     child: Text(monthName,
//                         style: context.theme.textTheme.labelSmall
//                             ?.copyWith(color: context.theme.colorScheme.primary)),
//                   );
//                 },
//               ))),
//       lineBarsData: [lineChartBarData(x: x, y: y)],
//       minX: 0,
//       minY: 0,
//       maxX: 12,
//       maxY: widget.state.allItems);
//
//   List<double> x = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]; //* not change x
//
//   LineTouchData get lineTouchData => LineTouchData(
//     handleBuiltInTouches: true,
//     touchTooltipData: LineTouchTooltipData(
//       getTooltipItems: (touchedSpots) {
//         return touchedSpots
//             .map((spot) {
//           int index = spot.spotIndex;
//           List<CompanyStatusModel> sortedList =
//           List.from(widget.state.companyStatusList)
//             ..sort((a, b) =>
//             a.amount
//                 ?.toDouble()
//                 .compareTo(b.amount?.toDouble() ?? 0) ??
//                 0);
//
//           if (index < sortedList.length) {
//             return LineTooltipItem(
//               sortedList[index].amount.toString().formatBalance(),
//               context.theme.textTheme.displaySmall ??
//                   const TextStyle(color: Colors.white),
//             );
//           }
//           return null;
//         })
//             .where((item) => item != null)
//             .toList();
//       },
//     ),
//   );
//
//   List<double?> adjustY(List<double?> yValues) {
//     List<double?> adjustedY = List.from(yValues);
//     while (adjustedY.length < 12) {
//       adjustedY.add(null);
//     }
//     return adjustedY;
//   }
//
//   LineChartBarData lineChartBarData(
//       {required List<double> x, required List<double?> y}) {
//     List<double?> adjustedY = adjustY(y);
//     bool hasNegative = widget.state.companyStatusList
//         .any((status) => (status.amount ?? 0) > 0);
//     return LineChartBarData(
//         isCurved: true,
//         color: const Color(0xffA6CEE3),
//         //! gradient not working on emulator
//         gradient: hasNegative
//             ? const LinearGradient(
//           colors: [
//             Color(0xffFF0000),
//             Color(0xffFFA500),
//           ],
//         )
//             : LinearGradient(
//             colors: List.generate(widget.state.companyStatusList.length,
//                     (index) {
//                   return hexToColor(
//                       widget.state.companyStatusList[index].color ?? '#079FEB');
//                 })),
//         belowBarData: BarAreaData(
//             show: true,
//             gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   const Color(0xffBCD4EB).withOpacity(0.8),
//                   const Color(0xffC8E0F7).withOpacity(0.1)
//                 ],
//                 stops: const [
//                   0.0,
//                   1.0
//                 ])),
//         barWidth: 2,
//         dotData: const FlDotData(show: true),
//         spots: List.generate(12, (index) {
//           if (adjustedY[index] != null) {
//             return FlSpot(x[index], adjustedY[index]!);
//           } else {
//             return FlSpot.nullSpot;
//           }
//         }));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     debugPrint(widget.state.allItems.toString());
//     debugPrint(widget.state.y.toString());
//     List<CompanyStatusModel> sortedList =
//     List.from(widget.state.companyStatusList)
//       ..sort((a, b) =>
//       a.amount?.toDouble().compareTo(b.amount?.toDouble() ?? 0) ?? 0);
//     return Expanded(
//       child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: [
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: List.generate(sortedList.length, (index) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 14),
//                     child: Text(
//                         formatNumber(sortedList.reversed
//                             .toList()[index]
//                             .amount
//                             ?.toDouble() ??
//                             0),
//                         style: context.theme.textTheme.headlineMedium?.copyWith(
//                             color: context.theme.colorScheme.primary)),
//                   );
//                 }),
//               ),
//               SizedBox(width: 1000, child: LineChart(lineChart)),
//             ],
//           )),
//     );
//   }
// }