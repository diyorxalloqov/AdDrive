import 'package:flutter/cupertino.dart';
import 'package:addrive/data/local_data/shared_preference.dart';
import 'package:addrive/language/language.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  Rx<Locale> selectedLocale = Rx(const Locale('uz'));
  Rx<Language> selectedLanguage = Rx(Language('uz', "O'zbek", "O'zbek"));
  RxInt selectedIndex = 0.obs;

  LanguageController() {
    getSelectedLanguage();
  }

  onLanguageChange({required String languageCode, required int index}) {
    selectedLocale.value = Locale(languageCode);

    storeLocalData(key: 'languageCode', value: languageCode);

    selectedIndex.value = index;

    Get.updateLocale(selectedLocale.value);

    update();
  }

  getSelectedLanguage() async {
    final data = await getLocalData(key: 'languageCode');

    if (data != null) {
      selectedLocale.value = Locale(data);

      selectedLanguage.value = Language(
          selectedLocale.value.languageCode,
          '${getLanguageUzbekNameByCode(languageCode: selectedLocale.value.languageCode)}',
          '${getLanguageRussianNameByCode(languageCode: selectedLocale.value.languageCode)}');

      selectedIndex.value =
          LanguagesList().languages?.first.code == data ? 0 : 1;

      update();
    }
  }

  getLanguageUzbekNameByCode({required String languageCode}) {
    switch (languageCode) {
      case 'uz':
        return "O'zbek";
      case 'ru':
        return 'Русский';
    }
  }

  getLanguageRussianNameByCode({required String languageCode}) {
    switch (languageCode) {
      case 'uz':
        return "O'zbek";
      case 'ru':
        return 'Русский';
    }
  }
}
