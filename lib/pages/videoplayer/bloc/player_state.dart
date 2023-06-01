part of 'player_bloc.dart';

class PlayerState extends Equatable {
  const PlayerState(
      {this.movieId,
      required this.videos,
      this.currentVideoKey,
      required this.status});

  final String? movieId;
  final String? currentVideoKey;
  final List<VideoItem> videos;
  final Status status;

  PlayerState.initial() : this(status: Status.empty, videos: []);

  PlayerState copyWith({
    String? movieId,
    List<VideoItem>? videos,
    String? currentVideoKey,
    Status? status,
  }) {
    return PlayerState(
        videos: videos ?? this.videos,
        movieId: movieId ?? this.movieId,
        status: status ?? this.status,
        currentVideoKey: currentVideoKey ?? this.currentVideoKey);
  }

  @override
  List<Object?> get props => [movieId, status, currentVideoKey, videos];
}
