part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class FinishRegisterEvent extends RegisterEvent {
  @override
  List<Object?> get props => [];
}

class ChangeFlagEvent extends RegisterEvent {
  final GenreItem genre;

  const ChangeFlagEvent(this.genre);

  @override
  List<Object?> get props => [genre];
}

class FetchGenresEvent extends RegisterEvent {
  const FetchGenresEvent();

  @override
  List<Object?> get props => [];
}

class _RefreshEvent extends RegisterEvent {
  const _RefreshEvent(this.genres);

  final List<GenreItem> genres;

  @override
  List<Object?> get props => [];
}
