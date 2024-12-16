import 'package:flutter/material.dart';
import 'package:flutter_texi_tracker/controller/language_controller.dart';
import 'package:get/get.dart';
import 'language.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  LanguageScreenState createState() => LanguageScreenState();
}

class LanguageScreenState extends State<LanguageScreen> {
  late LanguagesList languagesList;

  @override
  void initState() {
    languagesList = LanguagesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageController>(
      init: LanguageController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.black, size: 25.0),
            title: Text(
              'language'.tr,
              style: const TextStyle(color: Colors.black),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    leading: Image.asset(
                      'asset/icons/language_icon.png',
                      height: 45,
                      width: 45,
                    ),
                    title: Text(
                      '${controller.getLanguageUzbekNameByCode(languageCode: controller.selectedLocale.value.languageCode)}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Text('select_lang'.tr),
                  ),
                ),
                const SizedBox(height: 10),
                ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  primary: false,
                  itemCount: languagesList.languages!.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10);
                  },
                  itemBuilder: (context, index) {
                    Language language =
                        languagesList.languages!.elementAt(index);
                    //performing click event
                    return InkWell(
                      onTap: () async {
                        controller.onLanguageChange(
                            languageCode: language.code, index: index);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    language.englishName,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Text(
                                    language.localName,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 15),
                            Container(
                              height: controller.selectedIndex.value == index
                                  ? 40
                                  : 0,
                              width: controller.selectedIndex.value == index
                                  ? 40
                                  : 0,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                              ),
                              child: Icon(
                                Icons.check,
                                size: controller.selectedIndex.value == index
                                    ? 24
                                    : 0,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(
                                        controller.selectedIndex.value == index
                                            ? 0.85
                                            : 0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
