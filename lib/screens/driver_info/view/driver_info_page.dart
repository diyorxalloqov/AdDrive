import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:addrive/controller/driver_info_controller.dart';
import 'package:addrive/screens/driver_info/content/custom_from_field.dart';
import 'package:addrive/screens/driver_info/content/date_input_field.dart';
import 'package:addrive/screens/driver_info/content/driver_declaration_content.dart';
import 'package:addrive/screens/driver_info/content/input_card.dart';
import 'package:addrive/screens/driver_info/content/picture_content.dart';
import 'package:addrive/screens/driver_info/content/signature_content.dart';
import 'package:addrive/screens/driver_info/content/vehicle_inspection_radio_theme.dart';
import 'package:get/get.dart';

class DriverInfoPage extends StatelessWidget {
  DriverInfoPage({super.key});

  final formKey = GlobalKey<FormState>();
  final DriverInfoController controller = Get.put(DriverInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('driver_info'.tr, style: context.theme.textTheme.labelMedium),
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child:  Icon(
              Icons.arrow_back_ios_new,
              color: context.isDarkMode ? Colors.white : Colors.black,
              size: 20,
            )),
      ),
      body: Obx(() {
        return Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10.h),
                SizedBox(
                  width: double.infinity,
                  child: InputCard(
                    child: Column(
                      children: [
                        Image.asset(
                          'asset/car_icon/car_info.png',
                          height: 200,
                          width: 300.w,
                        ),
                        SizedBox(height: 26.h),
                        const Text(
                          "Drivers who are active on a Wrapyt campaign need to complete this report on a bi-weekly (every 2 weeks) basis",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 30.h),
                        const Text(
                          "Please take this form seriously with full attention to detail",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                DateInputField(
                  title: "Date",
                  controller: controller.dateController,
                  onClick: () => controller.selectDate(context),
                ),
                SizedBox(height: 12.h),
                CustomFromFiled(
                  title: "Driver's Full Name",
                  controller: controller.driverNameController,
                ),
                SizedBox(height: 12.h),
                CustomFromFiled(
                  title: "Vehicle Make and Model",
                  controller: controller.vehicleModelController,
                ),
                SizedBox(height: 12.h),
                VehicleInspectionRadioTheme(
                  isDamage: controller.isDamage.value,
                  isWashed: controller.isWashed.value,
                  onDamageChanged: (value) =>
                      controller.isDamage.value = value ?? false,
                  onWashedChanged: (value) =>
                      controller.isWashed.value = value ?? false,
                ),
                SizedBox(height: 12.h),
                DriverDeclarationContent(
                    isDeclare: controller.isDeclare.value,
                    onDeclareChanged: (value) =>
                        controller.isDeclare.value = value),
                SizedBox(height: 12.h),
                PictureContent(
                  selectedImages: controller.selectedImages,
                ),
                SizedBox(height: 12.h),
                SignatureContent(
                  controller: controller.signatureController,
                  onTap: () {},
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: InkWell(
                      onTap: () {
                        if (!controller.isLoading.value) {
                          controller.saveDriverInfo();
                        }
                      },
                      child: Center(
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 44,
                            padding: const EdgeInsets.symmetric(horizontal: 26),
                            decoration: BoxDecoration(
                                color: const Color(0xFF041E48),
                                borderRadius: BorderRadius.circular(8)),
                            child: controller.isLoading.value
                                ? const Center(
                                    child: SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 3,
                                      ),
                                    ),
                                  )
                                : const Center(
                                    child: Text(
                                      "Save",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  )),
                      )),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        );
      }),
    );
  }
}
