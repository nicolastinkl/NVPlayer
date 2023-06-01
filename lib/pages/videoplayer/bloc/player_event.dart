part of 'player_bloc.dart';

@immutable
abstract class PlayerEvent {
  const PlayerEvent();
}

class FetchVideosEvent extends PlayerEvent {
  const FetchVideosEvent(this.movieId);

  final String? movieId;
}

class CopyVideosEvent extends PlayerEvent {
  const CopyVideosEvent(this.movieId);

  final String movieId;
}

class ChangeVideoEvent extends PlayerEvent {
  const ChangeVideoEvent(this.videoKey);

  final String? videoKey;
}
