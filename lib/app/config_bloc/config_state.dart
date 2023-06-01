part of 'config_bloc.dart';

class ConfigState extends Equatable {
  final String langCode;
  final bool darkTheme;

  const ConfigState({required this.langCode, required this.darkTheme});

  const ConfigState.initial({langCode = LANG_EN, darkTheme = true})
      : this(langCode: langCode, darkTheme: darkTheme);

  ConfigState copyWith({String? langCode, bool? darkTheme}) {
    return ConfigState(
        langCode: langCode ?? this.langCode,
        darkTheme: darkTheme ?? this.darkTheme);
  }

  Map<String, bool> get languages => {
        'English': langCode == LANG_EN,
        'Russian': langCode == LANG_RU,
        '中文': langCode == LANG_ZH,
      };

  String getLangCode(String lang) {
    switch (lang) {
      case 'English':
        return LANG_EN;
      case 'Russian':
        return LANG_RU;
      case '中文':
        return LANG_ZH;
    }
    return LANG_EN;
  }

  @override
  List<Object?> get props => [langCode, darkTheme];
}
