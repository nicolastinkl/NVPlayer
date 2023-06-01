import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:movie_app/pages/components/avatar.dart';
import 'package:movie_app/l10n/l10n.dart';
import 'package:movie_app/pages/detail/components/slider_card_image.dart';
import 'package:movie_app/pages/home/bloc/home_bloc.dart';
import 'package:movie_app/pages/home/movies_see_all.dart';
import 'package:movie_app/pages/home/movies_see_category.dart';
import 'package:movie_app/pages/widgets/empty_view.dart';
import 'package:movie_app/pages/widgets/error_view.dart';
import 'package:movie_app/pages/widgets/movie_item_card.dart';
import 'package:movie_app/pages/widgets/no_connection_view.dart';
import 'package:movie_app/pages/widgets/progress_view.dart';
import 'package:movie_app/resources/app_values.dart';
import 'package:movie_app/utils/status.dart';
import 'package:movies_data/movies_data.dart';
import 'package:movies_api/src/models/navi/navi_avtor.dart';

import 'package:movies_api/src/models/navi/navi_link.dart';

class LinkSummaryMovies extends StatelessWidget {
  final double size;
  final int index;
  final List<NaviLink> naviSummary;

  const LinkSummaryMovies(
      {Key? key,
      required this.size,
      required this.index,
      required this.naviSummary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _MoviesView(navi_summary: naviSummary, itemSize: size);
  }
}

class _MoviesView extends StatelessWidget {
  const _MoviesView(
      {Key? key, required this.navi_summary, required this.itemSize})
      : super(key: key);

  /// Single Item size
  final double itemSize;

  /// Movies coming remote or local storage
  // final List<MovieItem> movies;
  final List<NaviLink> navi_summary;

  @override
  Widget build(BuildContext context) {
    List<CastItem> casts = [];
    for (var element in navi_summary) {
      casts.add(CastItem(
          creditId: element.linkId ?? "",
          originalName: element.title ?? "",
          profilePath: element.iconUri ?? "",
          id: 0,
          gender: 0));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Container(
        //   margin: const EdgeInsets.all(10),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Text("", style: Theme.of(context).textTheme.titleMedium),
        //       GestureDetector(
        //         onTap: () {},
        //         child: Text(
        //           context.l10n.seeAll,
        //           style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        //               color: Theme.of(context).colorScheme.secondary),
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        SizedBox(
          height: itemSize,
          child: buildAvtor(context, casts),
        ),
      ],
    );
  }

  Widget buildAvtor(BuildContext context, List<CastItem> casts) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: casts.length,
        itemBuilder: (context, index) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 65,
              width: 65,
              child: Avatar(avatarUrl: casts[index].profilePath ?? ""),
              // CircleAvatar(
              //   backgroundImage:,
              //   //NetworkImage(casts[index].profilePath!),
              // ),
            ),
            SizedBox(
              width: 100,
              height: 20,
              child: Text(
                casts[index].originalName ?? '',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
