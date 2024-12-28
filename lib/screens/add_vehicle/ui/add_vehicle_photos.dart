/*
 *  (c) Diyor Xalloqov 2024.8.15 Toshkent, Uzbekistan
 *  github: https://github.com/diyorxalloqov
 *  LinkedIn: https://www.linkedin.com/in/diyor-xalloqov-024b63231/
 *  Telegram: https://t.me/Flutter_dart_developer
 */

import 'dart:io';

import 'package:flutter_texi_tracker/global/imports/app_imports.dart';
import 'package:flutter_texi_tracker/screens/add_vehicle/ui/vehicle_country_screen.dart';

class AddVehiclePhotos extends StatefulWidget {
  const AddVehiclePhotos({super.key});

  @override
  State<AddVehiclePhotos> createState() => _AddVehiclePhotosState();
}

class _AddVehiclePhotosState extends State<AddVehiclePhotos> {
  String rigthImage = '';
  String leftImage = '';
  String backImage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleText: 'photo_enter'.tr, centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SpaceHeight(height: 16),
            Row(
              children: [
                Text('photo'.tr,
                    style: context.theme.textTheme.labelMedium
                        ?.copyWith(fontSize: 20)),
                IconButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const VehicleAddingExamplePage())),
                    icon: Icon(Icons.info_outline,
                        color: CustomColors().greyColor(0.5)))
              ],
            ),
            const SpaceHeight(height: 20),
            Text('right'.tr, style: context.theme.textTheme.labelMedium),
            const SpaceHeight(height: 12),
            ImageItem(
                onTap: () => showImageDialog((path) {
                      rigthImage = path;
                    }),
                imagePath: rigthImage),
            const SpaceHeight(height: 20),
            Text('left'.tr, style: context.theme.textTheme.labelMedium),
            const SpaceHeight(height: 12),
            ImageItem(
                onTap: () => showImageDialog((path) {
                      leftImage = path;
                    }),
                imagePath: leftImage),
            const SpaceHeight(height: 20),
            Text('back'.tr, style: context.theme.textTheme.labelMedium),
            const SpaceHeight(height: 12),
            ImageItem(
                onTap: () => showImageDialog((path) {
                      backImage = path;
                    }),
                imagePath: backImage),
            const Spacer(),
            CustomButton(
              title: 'confirm'.tr,
              padding: EdgeInsets.zero,
              onPressed: rigthImage.isNotEmpty &&
                      leftImage.isNotEmpty &&
                     backImage.isNotEmpty
                  ? () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const VehicleCountryScreen()))
                  : null,
            ),
            const SpaceHeight(height: 8)
          ],
        ),
      ),
    );
  }

  showImageDialog(void Function(String) onImagePicked) {
    Get.dialog(AlertDialog(
      backgroundColor: context.theme.colorScheme.primary,
      title: Text('select_image'.tr,style: context.theme.textTheme.labelMedium),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async {
                Navigator.pop(context);
                XFile? data = await getImage(ImageSource.camera);
                if (data != null) {
                  setState(() {
                    onImagePicked(data.path);
                  });
                }
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(Assets.iconsCamera,
                      width: 24, color: CustomColors().greyColor(0.5)),
                  const SpaceHeight(height: 10),
                  Text('camera'.tr,
                      style: context.theme.textTheme.headlineSmall)
                ],
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async {
                Navigator.pop(context);
                XFile? data = await getImage(ImageSource.gallery);
                if (data != null) {
                  setState(() {
                    onImagePicked(data.path);
                  });
                }
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(Assets.iconsGallery,
                      width: 28, color: CustomColors().greyColor(0.5)),
                  const SpaceHeight(height: 4),
                  Text('gallery'.tr,
                      style: context.theme.textTheme.headlineSmall)
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class ImageItem extends StatelessWidget {
  final VoidCallback onTap;
  final String imagePath;
  const ImageItem({super.key, required this.onTap, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DottedBorder(
        color: imagePath.isNotEmpty
            ? Colors.transparent
            : CustomColors().mainColor(1),
        strokeWidth: 1,
        dashPattern: const [8, 4],
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        child: Container(
          decoration: BoxDecoration(
              color: CustomColors().mainColor(0.1),
              borderRadius: BorderRadius.circular(12)),
          height: App(context).appHeight(130),
          width: double.infinity,
          child: imagePath.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(File(imagePath), fit: BoxFit.cover))
              : Center(
                  child: SvgPicture.asset(Assets.iconsCameraAdd, width: 40)),
        ),
      ),
    );
  }
}
