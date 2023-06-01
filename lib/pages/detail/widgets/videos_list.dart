import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/pages/detail/bloc/detail_movie_bloc.dart';
import 'package:movie_app/pages/videoplayer/player_page.dart';
import 'package:movie_app/pages/widgets/empty_view.dart';
import 'package:movie_app/pages/widgets/video_item_card.dart';

class VideosList extends StatelessWidget {
  const VideosList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailMovieBloc, DetailMovieState>(
      builder: (context, state) {
        if (state.videos.isEmpty) {
          return const SliverToBoxAdapter(child: EmptyView());
        }
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => VideoItemCard(
              video: state.videos[index],
              onPressed: () {
                Navigator.of(context).push(PlayerPage.route(
                  movieId: state.movie!.id,
                  videoKey: state.videos[index].key,
                ));
              },
            ),
            childCount: state.videos.length,
          ),
        );
      },
    );
  }
}
