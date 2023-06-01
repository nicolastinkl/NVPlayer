part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final Status status;
  final Object? error;
  final List<GenreItem> genres;

  const RegisterState(
      {required this.status, this.error, required this.genres});

  RegisterState.initial() : this(status: Status.empty, genres: [], error: null);

  RegisterState copyWith({
    Status? status,
    Object? error,
    List<GenreItem>? genres,
  }) {
    return RegisterState(
      status: status ?? this.status,
      genres: genres ?? this.genres,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, genres, error];
}
