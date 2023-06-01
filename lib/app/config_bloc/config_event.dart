part of 'config_bloc.dart';

@immutable
abstract class ConfigEvent {}

class GetInitialAppState extends ConfigEvent {}

class ChangeLanguageEvent extends ConfigEvent {
  final String? langCode;

  ChangeLanguageEvent(this.langCode);
}

class ChangeThemeModeEvent extends ConfigEvent {
  final bool? darkTheme;

  ChangeThemeModeEvent(this.darkTheme);
}
