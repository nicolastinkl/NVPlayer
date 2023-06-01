import 'package:shared_preferences/shared_preferences.dart';

const LANG_EN = 'en';
const LANG_RU = 'ru';
const LANG_ZH = 'zh';

class LanguagePreferences {
  static const APP_LANGUAGE = "app_language";
  late SharedPreferences preferences;

  LanguagePreferences(SharedPreferences sharedPreferences)
      : preferences = sharedPreferences;

  setLanguage(String langCode) async {
    preferences.setString(APP_LANGUAGE, langCode);
  }

  Future<String> getLanguage() async {
    return preferences.getString(APP_LANGUAGE) ?? LANG_EN;
  }
}
