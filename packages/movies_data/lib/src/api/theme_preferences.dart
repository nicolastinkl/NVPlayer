import 'package:shared_preferences/shared_preferences.dart';

class ThemePreference {
  static const APP_THEME = "app_theme";
  late SharedPreferences preferences;

  ThemePreference(SharedPreferences sharedPreferences)
      : preferences = sharedPreferences;

  setDarkTheme(bool value) async {
    preferences.setBool(APP_THEME, value);
  }

  Future<bool> getTheme() async {
    return preferences.getBool(APP_THEME) ?? false;
  }
}
