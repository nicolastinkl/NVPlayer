import 'package:flutter/material.dart';
import 'package:movie_app/pages/detail/components/circle_dot.dart';
import 'package:movies_data/movies_data.dart';

class MovieCardDetails extends StatelessWidget {
  const MovieCardDetails({
    super.key,
    required this.movieDetails,
  });

  final MovieDetail movieDetails;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    if (movieDetails.releaseData.isNotEmpty &&
        movieDetails.genres.isNotEmpty &&
        movieDetails.overview.isNotEmpty) {
      return Row(
        children: [
          if (movieDetails.releaseData.isNotEmpty) ...[
            Text(
              movieDetails.releaseData, //.split(',')[1],
              style: textTheme.bodyLarge,
            ),
            const CircleDot(),
          ],
          if (movieDetails.genres.isNotEmpty) ...[
            Text(
              movieDetails.genres.first,
              style: textTheme.bodyLarge,
            ),
            const CircleDot(),
          ] else ...[
            if (movieDetails.overview.isNotEmpty) ...[
              const CircleDot(),
            ]
          ],
          Text(
            movieDetails.language,
            style: textTheme.bodyLarge,
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
