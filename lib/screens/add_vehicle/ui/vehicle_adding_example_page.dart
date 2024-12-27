/*
 *  (c) Diyor Xalloqov 2024.8.15 Toshkent, Uzbekistan
 *  github: https://github.com/diyorxalloqov
 *  LinkedIn: https://www.linkedin.com/in/diyor-xalloqov-024b63231/
 *  Telegram: https://t.me/Flutter_dart_developer
 */

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_texi_tracker/global/imports/app_imports.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class VehicleAddingExamplePage extends StatefulWidget {
  const VehicleAddingExamplePage({super.key});

  @override
  State<VehicleAddingExamplePage> createState() =>
      _VehicleAddingExamplePageState();
}

class _VehicleAddingExamplePageState extends State<VehicleAddingExamplePage> {
  late final PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  final List<String> _images = const [
    "https://static.vecteezy.com/system/resources/thumbnails/026/992/343/small_2x/classic-modified-car-with-dark-smokie-background-ai-generative-free-photo.jpg",
    "https://img.lovepik.com/photo/48007/1949.jpg_wh860.jpg",
    "https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg?cs=srgb&dl=pexels-mikebirdy-170811.jpg&fm=jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleText: 'image_input'.tr, centerTitle: true),
      body: Column(
        children: [
          Expanded(
              child: PageView.builder(
                  controller: _pageController,
                  itemCount: _images.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 200,
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                _images[index],
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                (loadingProgress
                                                        .expectedTotalBytes ??
                                                    1)
                                            : null,
                                        color: CustomColors().mainColor(1),
                                      ),
                                    );
                                  }
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Center(
                                    child: Icon(
                                      Icons.error,
                                      color: CustomColors().mainColor(1),
                                      size: 40,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SpaceHeight(height: 20),
                          SmoothPageIndicator(
                            controller: _pageController, // PageController
                            count: _images.length,
                            effect: ExpandingDotsEffect(
                                dotWidth: 8.sp,
                                dotHeight: 8.sp,
                                spacing: 8.sp,
                                dotColor: CustomColors().greyColor(0.5),
                                activeDotColor: CustomColors().mainColor(1)),
                          ),
                          const SpaceHeight(height: 20),
                          Text('''Орқа томон:
- Автомобильни орқа томони суратга олиш учун тўлиқ очиқ бўладиган тарзда жойлаштиринг.
- Суратга олишда орқа чироқлар, юкхона ва бампер кадрда бўлишини таъминланг.
Камерани автомобильнинг ўрта қисмига мос равишда ушлаб, энг реалистик кўринишни олишга ҳаракат қилинг''',
                              style: context.theme.textTheme.labelMedium
                                  ?.copyWith(fontSize: 14))
                        ],
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
