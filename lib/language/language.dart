class Language {
  String code;
  String englishName;
  String localName;

  Language(this.code, this.englishName, this.localName);
}

class LanguagesList {
  List<Language>? _languages;

  LanguagesList() {
    _languages = [
       Language("uz", "O'zbek", "O'zbek",),
       Language("ru", "Русский", "Русский"),
    ];
  }

  List<Language>? get languages => _languages;
}
