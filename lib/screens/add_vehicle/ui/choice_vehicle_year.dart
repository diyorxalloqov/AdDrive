/*
 *  (c) Diyor Xalloqov 2024.8.15 Toshkent, Uzbekistan
 *  github: https://github.com/diyorxalloqov
 *  LinkedIn: https://www.linkedin.com/in/diyor-xalloqov-024b63231/
 *  Telegram: https://t.me/Flutter_dart_developer
 */

import 'package:flutter_texi_tracker/global/imports/app_imports.dart';
import 'package:flutter_texi_tracker/screens/add_vehicle/model/car_details_model.dart';

class ChoiceVehicleYear extends StatefulWidget {
  final CarDetailsModel carDetailsModel;
  const ChoiceVehicleYear({super.key, required this.carDetailsModel});

  @override
  State<ChoiceVehicleYear> createState() => _ChoiceVehicleYearState();
}

class _ChoiceVehicleYearState extends State<ChoiceVehicleYear> {
  late List<int> years;
  int? selectedYear;

  @override
  void initState() {
    int yearFrom =
        widget.carDetailsModel.yearFrom?.toInt() ?? DateTime.now().year - 10;
    int yearTo = widget.carDetailsModel.yearTo?.toInt() ?? DateTime.now().year;

    if (yearFrom > yearTo) {
      throw ArgumentError('yearFrom cannot be greater than yearTo.');
    }

    years = List.generate(yearTo - yearFrom + 1, (index) => yearFrom + index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(centerTitle: true, titleText: 'choice_year'.tr),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('created_date'.tr,
                style:
                    context.theme.textTheme.bodyLarge?.copyWith(fontSize: 20)),
            const SpaceHeight(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: years.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                          onTap: () {
                            setState(() {
                              selectedYear = years[index];
                            });
                          },
                          leading: const CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://upload.wikimedia.org/wikipedia/commons/thumb/4/44/BMW.svg/768px-BMW.svg.png'),
                          ),
                          title: Text(years[index].toString(),
                              style: context.theme.textTheme.labelMedium),
                          trailing: selectedYear == years[index]
                              ? Icon(Icons.check,
                                  color: context.theme.colorScheme.onPrimary)
                              : null,
                          splashColor: Colors.transparent,
                          contentPadding: const EdgeInsets.only(right: 10)),
                      Divider(
                          color: context.theme.colorScheme.onPrimary
                              .withOpacity(0.1))
                    ],
                  );
                },
              ),
            ),
            CustomButton(
                onPressed: selectedYear != null
                    ? () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AddVehicleDataScreen()));
                      }
                    : null,
                title: 'confirm'.tr,
                padding: EdgeInsets.zero),
            const SpaceHeight(height: 20)
          ],
        ),
      ),
    );
  }
}
