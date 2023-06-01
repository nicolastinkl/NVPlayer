import 'package:movies_data/src/api/language_preferences.dart';
import 'package:movies_data/src/api/theme_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

export 'package:movies_data/src/api/language_preferences.dart';

class ConfigRepository {
  final ThemePreference _themePreference;
  final LanguagePreferences _languagePreferences;

  ConfigRepository(SharedPreferences sharedPreferences)
      : _themePreference = ThemePreference(sharedPreferences),
        _languagePreferences = LanguagePreferences(sharedPreferences) {
    init();
  }

  init() async {
    _darkTheme = await _themePreference.getTheme();
    _appLocale = await _languagePreferences.getLanguage();
  }

  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  String _appLocale = LANG_EN;

  String get appLang => _appLocale;

  set appLang(String langCode) {
    _appLocale = langCode;
    _languagePreferences.setLanguage(langCode);
  }

  set darkTheme(bool value) {
    _darkTheme = value;
    _themePreference.setDarkTheme(value);
  }
}
