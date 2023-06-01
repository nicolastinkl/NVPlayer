
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movies_data/movies_data.dart';

part 'config_event.dart';

part 'config_state.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  final ConfigRepository configRepository;

  ConfigBloc(this.configRepository) : super(const ConfigState.initial()) {

    on<GetInitialAppState>((event, emit) {
      emit(state.copyWith(
          langCode: configRepository.appLang,
          darkTheme: configRepository.darkTheme));
    });

    on<ChangeLanguageEvent>((event, emit) {
      if (event.langCode == null) return;
      configRepository.appLang = event.langCode!;
      emit(state.copyWith(langCode: event.langCode));
    });

    on<ChangeThemeModeEvent>((event, emit) {
      if (event.darkTheme == null) return;
      configRepository.darkTheme = event.darkTheme!;
      emit(state.copyWith(darkTheme: event.darkTheme));
    });
  }
}
