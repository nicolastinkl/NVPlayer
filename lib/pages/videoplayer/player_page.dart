import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/pages/videoplayer/bloc/player_bloc.dart';
import 'package:movie_app/pages/widgets/empty_view.dart';
import 'package:movie_app/pages/widgets/error_view.dart';
import 'package:movie_app/pages/widgets/no_connection_view.dart';
import 'package:movie_app/pages/widgets/progress_view.dart';
import 'package:movie_app/pages/widgets/video_item_card.dart';
import 'package:movie_app/utils/status.dart';
import 'package:movies_data/movies_data.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart'
    hide PlayerState;

class PlayerPage extends StatelessWidget {
  static Route<void> route({required String movieId, String? videoKey}) =>
      MaterialPageRoute(
          builder: (_) => PlayerPage(movieId: movieId, videoKey: videoKey));

  const PlayerPage({Key? key, this.videoKey, required this.movieId})
      : super(key: key);

  final String? videoKey;
  final String movieId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PlayerBloc(
        repository: RepositoryProvider.of<MoviesRepository>(context),
      )
        ..add(FetchVideosEvent(movieId))
        ..add(ChangeVideoEvent(videoKey)),
      child: const _PlayerView(),
    );
  }
}

class _PlayerView extends StatelessWidget {
  const _PlayerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: BlocBuilder<PlayerBloc, PlayerState>(
          builder: (context, state) {
            return _buildComponents(state);
          },
        ),
      );

  Widget _buildComponents(PlayerState state) {
    switch (state.status) {
      case Status.success:
        return _YoutubeView(videoKey: state.currentVideoKey);
      case Status.pending:
        return const ProgressView();
      case Status.empty:
        return const EmptyView();
      case Status.error:
        return ErrorView(onRetry: () {});
      case Status.noConnection:
        return const NoConnectionView();
    }
  }
}

class _YoutubeView extends StatefulWidget {
  const _YoutubeView({Key? key, required this.videoKey}) : super(key: key);

  final String? videoKey;

  @override
  State<_YoutubeView> createState() => _YoutubeViewState();
}

class _YoutubeViewState extends State<_YoutubeView> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoKey ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
    super.initState();
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void selectVideo(String videoKey) {
    context.read<PlayerBloc>().add(ChangeVideoEvent(videoKey));
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<PlayerBloc, PlayerState>(
        listener: (context, state) {
          final videoId = YoutubePlayer.convertUrlToId(
              "https://www.youtube.com/watch?v=${state.currentVideoKey}");
          _controller.load(videoId!);
        },
        builder: (context, state) {
          return YoutubePlayerBuilder(
            onEnterFullScreen: () {
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                  overlays: [
                    SystemUiOverlay.top,
                    SystemUiOverlay.bottom,
                  ]);
            },
            player: YoutubePlayer(
              aspectRatio: 16 / 9,
              controller: _controller,
              showVideoProgressIndicator: true,
              bottomActions: [
                const SizedBox(width: 10),
                CurrentPosition(),
                const SizedBox(width: 10),
                ProgressBar(isExpanded: true),
                const SizedBox(width: 10),
                RemainingDuration(),
                FullScreenButton(),
              ],
            ),
            builder: (context, player) {
              return Scaffold(
                backgroundColor: Theme.of(context).colorScheme.primary,
                body: Column(
                  children: [
                    player,
                    const SizedBox(height: 10),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          context
                              .read<PlayerBloc>()
                              .add(FetchVideosEvent(state.movieId));
                        },
                        child: ListView.builder(
                          itemCount: state.videos.length,
                          itemBuilder: (context, index) {
                            final video = state.videos[index];
                            return VideoItemCard(
                              isSelected:
                                  video.compareKey(state.currentVideoKey),
                              video: video,
                              onPressed: () {
                                selectVideo(video.key);
                              },
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      );
}
