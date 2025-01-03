/*
 *  (c) Diyor Xalloqov 2024.8.15 Toshkent, Uzbekistan
 *  github: https://github.com/diyorxalloqov
 *  LinkedIn: https://www.linkedin.com/in/diyor-xalloqov-024b63231/
 *  Telegram: https://t.me/Flutter_dart_developer
 */

import 'package:addrive/controller/language_controller.dart';
import 'package:addrive/global/imports/app_imports.dart';
import 'package:addrive/global/widgets/drop_down_widget.dart';
import 'package:addrive/screens/add_vehicle/ui/vehicle_confirm_screen.dart';

class VehicleCountryScreen extends StatefulWidget {
  const VehicleCountryScreen({super.key});

  @override
  State<VehicleCountryScreen> createState() => _VehicleCountryScreenState();
}

class _VehicleCountryScreenState extends State<VehicleCountryScreen> {
  final List<String> _countriesUz = const [
    "Andijon viloyati",
    "Buxoro viloyati",
    "Farg'ona viloyati",
    "Jizzax viloyati",
    "Namangan viloyati",
    "Navoiy viloyati",
    "Qashqadaryo viloyati",
    "Samarqand viloyati",
    "Sirdaryo viloyati",
    "Surxondaryo viloyati",
    "Toshkent viloyati",
    "Toshkent shahri",
    "Xorazm viloyati",
    "Qoraqalpog'iston Respublikasi"
  ];

  final List<String> _countriesRu = const [
    "Андижанская область",
    "Бухарская область",
    "Ферганская область",
    "Джизакская область",
    "Наманганская область",
    "Навоийская область",
    "Кашкадарьинская область",
    "Самаркандская область",
    "Сырдарьинская область",
    "Сурхандарьинская область",
    "Ташкентская область",
    "город Ташкент",
    "Хорезмская область",
    "Республика Каракалпакстан"
  ];

  String? selecteditem1;
  String? selecteditem2;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageController>(
        init: LanguageController(),
        builder: (controller) {
          List<String> countryList =
              controller.selectedLanguage.value.code == "uz"
                  ? _countriesUz
                  : _countriesRu;

          return Scaffold(
            appBar: AppBarWidget(
              centerTitle: true,
              titleText: 'country'.tr,
            ),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('first_country'.tr,
                      style: context.theme.textTheme.labelMedium),
                  const SpaceHeight(height: 8),
                  DropdownWidget(
                    value: selecteditem1 ?? countryList.first,
                    items: List.generate(countryList.length, (index) {
                      final String item = countryList[index];
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }),
                    onChanged: (String? newValue) {
                      setState(() {
                        selecteditem1 = newValue!;
                      });
                    },
                  ),
                  const SpaceHeight(height: 16),
                  Text('second_country'.tr,
                      style: context.theme.textTheme.labelMedium),
                  const SpaceHeight(height: 8),
                  DropdownWidget(
                    value: selecteditem2 ?? countryList.first,
                    items: List.generate(countryList.length, (index) {
                      final String item = countryList[index];
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }),
                    onChanged: (String? newValue) {
                      setState(() {
                        selecteditem2 = newValue!;
                      });
                    },
                  ),
                  const Spacer(),
                  CustomButton(
                      title: 'confirm'.tr,
                      padding: EdgeInsets.zero,
                      onPressed: selecteditem1 == null || selecteditem2 == null
                          ? null
                          : () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const VehicleConfirmScreen()))),
                  const SpaceHeight(height: 20)
                ],
              ),
            ),
          );
        });
  }
}
