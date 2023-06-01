import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/pages/detail/components/slider_card_image.dart';
import 'package:movies_data/movies_data.dart';
// import 'package:movies_app/core/domain/entities/media.dart';
// import 'package:movies_app/core/domain/entities/media_details.dart';
// import 'package:movies_app/core/presentation/components/slider_card_image.dart';
// import 'package:movies_app/watchlist/presentation/controllers/watchlist_bloc/watchlist_bloc.dart';

import 'package:movie_app/resources/app_colors.dart';
import 'package:movie_app/resources/app_values.dart';
import 'package:video_player/video_player.dart';
// import 'package:url_launcher/url_launcher.dart';

class DetailsCard extends StatefulWidget {
  const DetailsCard({
    required this.mediaDetails,
    required this.detailsWidget,
    super.key,
  });

  final MovieDetail mediaDetails;
  final Widget detailsWidget;

  @override
  State<DetailsCard> createState() => _DetailsCardState();
}

class _DetailsCardState extends State<DetailsCard> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    // _scrollController.addListener(_scrollListener);
    // //widget.mediaDetails.backdropPath.replaceAll("https://w1.zikl.xyz", "http://45.125.51.92"
    _videoController = VideoPlayerController.network(
        "http://45.125.51.92/cos/txvideo/xsua5r39ir5/webm/ca4821b47f4fe607c6f1ed0011e1636a.webm")
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    _videoController.setLooping(true);
    _videoController.play();
  }

  Widget isPlaying() {
    return Icon(
      Icons.play_arrow,
      size: 40,
      color: Colors.white.withOpacity(0.5),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    // context
    //     .read<WatchlistBloc>()
    //     .add(CheckItemAddedEvent(tmdbId: mediaDetails.tmdbID));
    return SafeArea(
      child: Stack(
        children: [
          SliderCardImage(imageUrl: widget.mediaDetails.backdropPath),
          SizedBox(
            // key: ValueKey(index), //给每个子widget添加一个动态key
            height: size.height * 0.3,
            width: double.infinity,
            child: _videoController.value.isInitialized
                ? Container(
                    color: Colors.black,
                    width: double.infinity,
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: Stack(children: [
                        VideoPlayer(_videoController),
                      ]),
                    ),
                  )
                : Container(),
          ),

          // Center(
          //   child: Container(
          //     margin: EdgeInsets.only(bottom: 50),
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(20),
          //         border: Border.all(color: Colors.white.withOpacity(0.8))),
          //     child: isPlaying(),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: SizedBox(
              height: size.height * 0.3,
              child: Padding(
                padding: const EdgeInsets.only(bottom: AppPadding.p8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '',
                            maxLines: 2,
                            style: textTheme.titleMedium,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: AppPadding.p4,
                              bottom: AppPadding.p6,
                            ),
                            child: widget.detailsWidget,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star_rate_rounded,
                                color: AppColors.ratingIconColor,
                                size: AppSize.s18,
                              ),
                              Text(
                                '${widget.mediaDetails.rating} ',
                                style: textTheme.bodyMedium,
                              ),
                              Text(
                                '(${widget.mediaDetails.duration})',
                                style: textTheme.bodySmall,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (widget.mediaDetails.poserPath.isNotEmpty) ...[
                      InkWell(
                        onTap: () async {
                          // final url = Uri.parse(mediaDetails.poserPath);
                          // if (await canLaunchUrl(url)) {
                          //   await launchUrl(url);
                          // }
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(AppSize.s40),
                          child: Container(
                            height: AppSize.s40,
                            width: AppSize.s40,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.play_arrow_rounded,
                              color: AppColors.secondaryText,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
