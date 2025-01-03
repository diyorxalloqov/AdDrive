/*
 *  (c) Diyor Xalloqov 2024.8.15 Toshkent, Uzbekistan
 *  github: https://github.com/diyorxalloqov
 *  LinkedIn: https://www.linkedin.com/in/diyor-xalloqov-024b63231/
 *  Telegram: https://t.me/Flutter_dart_developer
 */

import 'package:addrive/global/imports/app_imports.dart';
import 'package:addrive/global/widgets/drop_down_widget.dart';
import 'package:addrive/global/widgets/text_form_field_widget_2.dart';
import 'package:addrive/global/widgets/uppercase_formatter.dart';
import 'package:addrive/screens/add_vehicle/ui/add_vehicle_photos.dart';

class AddVehicleDataScreen extends StatefulWidget {
  const AddVehicleDataScreen({super.key});

  @override
  State<AddVehicleDataScreen> createState() => _AddVehicleDataScreenState();
}

class _AddVehicleDataScreenState extends State<AddVehicleDataScreen> {
  String selectedValue = 'private_person'.tr;
  late final TextEditingController _texPassSeriaController;
  late final TextEditingController _texPassNumberController;
  late final TextEditingController _numberController;
  late final TextEditingController _numberSeriaController;
  late final TextEditingController _companyController;
  late final TextEditingController _stirController;
  bool allInputsEmpty = false;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _texPassSeriaController = TextEditingController();
    _texPassNumberController = TextEditingController();
    _numberController = TextEditingController();
    _numberSeriaController = TextEditingController();
    _companyController = TextEditingController();
    _stirController = TextEditingController();
    for (var controller in [
      _texPassSeriaController,
      _texPassNumberController,
      _numberController,
      _numberSeriaController,
      _companyController,
      _stirController,
    ]) {
      controller.addListener(_updateButtonState);
    }
  }

  void _updateButtonState() {
    final isPrivatePerson = selectedValue == 'private_person'.tr;
    final isPublicPerson = selectedValue == 'public_person'.tr;

    final isEnabled = _texPassSeriaController.text.isNotEmpty &&
        _texPassNumberController.text.isNotEmpty &&
        _numberController.text.isNotEmpty &&
        _numberSeriaController.text.isNotEmpty &&
        (isPrivatePerson ||
            (isPublicPerson &&
                _companyController.text.isNotEmpty &&
                _stirController.text.isNotEmpty));

    if (allInputsEmpty != isEnabled) {
      setState(() {
        allInputsEmpty = isEnabled;
      });
    }
  }

  @override
  void dispose() {
    for (var controller in [
      _texPassSeriaController,
      _texPassNumberController,
      _numberController,
      _numberSeriaController,
      _companyController,
      _stirController,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(centerTitle: true, titleText: 'add_data_car'.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SpaceHeight(height: 16),
              Text('add_tex_passport'.tr,
                  style: context.theme.textTheme.labelMedium),
              const SpaceHeight(height: 12),
              Row(
                children: [
                  Expanded(
                      flex: 3,
                      child: TextFormFieldWidget2(
                          maxLength: 3,
                          textCapitalization: TextCapitalization.characters,
                          inputFormatters: [
                            UpperCaseTextFormatter()
                          ], // Custom formatter
                          controller: _texPassSeriaController,
                          hintText: "ABC")),
                  const SpaceWidth(width: 20),
                  Expanded(
                      flex: 7,
                      child: TextFormFieldWidget2(
                          maxLength: 7,
                          keyboardType: TextInputType.number,
                          controller: _texPassNumberController,
                          hintText: "1234567"))
                ],
              ),
              const SpaceHeight(height: 16),
              Text('gos_number_type'.tr,
                  style: context.theme.textTheme.labelMedium),
              const SpaceHeight(height: 12),
              DropdownWidget(
                  value: selectedValue,
                  items: [
                    DropdownMenuItem(
                        value: 'public_person'.tr,
                        child: Text('public_person'.tr,
                            style: context.theme.textTheme.labelMedium)),
                    DropdownMenuItem(
                        value: 'private_person'.tr,
                        child: Text('private_person'.tr,
                            style: context.theme.textTheme.labelMedium))
                  ],
                  onChanged: (v) {
                    setState(() {
                      selectedValue = v!;
                      _updateButtonState();
                    });
                  }),
              const SpaceHeight(height: 16),
              Text('gos_number'.tr, style: context.theme.textTheme.labelMedium),
              const SpaceHeight(height: 12),
              Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: TextFormFieldWidget2(
                          maxLength: 2,
                          keyboardType: TextInputType.number,
                          controller: _numberController,
                          hintText: "01")),
                  const SpaceWidth(width: 20),
                  Expanded(
                      flex: 8,
                      child: TextFormFieldWidget2(
                          maxLength: 7,
                          textCapitalization: TextCapitalization.characters,
                          inputFormatters: [
                            UpperCaseTextFormatter()
                          ], // Custom formatter
                          controller: _numberSeriaController,
                          hintText: "A12 3NM"))
                ],
              ),
              const SpaceHeight(height: 16),
              selectedValue == 'public_person'.tr
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('company_name'.tr,
                            style: context.theme.textTheme.labelMedium),
                        const SpaceHeight(height: 12),
                        TextFormFieldWidget2(
                            maxLength: 3,
                            controller: _companyController,
                            hintText: "company_name_enter".tr),
                        const SpaceHeight(height: 12),
                        Text('stir'.tr,
                            style: context.theme.textTheme.labelMedium),
                        const SpaceHeight(height: 12),
                        TextFormFieldWidget2(
                            maxLength: 3,
                            controller: _stirController,
                            hintText: "stir_enter".tr),
                      ],
                    )
                  : const SizedBox.shrink(),
              SpaceHeight(
                  height: selectedValue == 'public_person'.tr ? 200 : 380),
              CustomButton(
                  onPressed: allInputsEmpty
                      ? () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddVehiclePhotos()))
                      : null,
                  title: 'confirm'.tr,
                  padding: EdgeInsets.zero)
            ],
          ),
        ),
      ),
    );
  }
}
