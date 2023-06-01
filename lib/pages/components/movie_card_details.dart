import 'package:flutter/material.dart';
import 'package:movies_data/movies_data.dart';

class MovieCardDetails extends StatelessWidget {
  const MovieCardDetails({
    super.key,
    required this.movieDetails,
  });

  final MovieItem movieDetails;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Text("");
    // if (movieDetails.releaseDate.isNotEmpty &&
    //     movieDetails.genres.isNotEmpty &&
    //     movieDetails.runtime!.isNotEmpty) {
    //   return Row(
    //     children: [
    //       if (movieDetails.releaseDate.isNotEmpty) ...[
    //         Text(
    //           movieDetails.releaseDate.split(',')[1],
    //           style: textTheme.bodyLarge,
    //         ),
    //         const CircleDot(),
    //       ],
    //       if (movieDetails.genres.isNotEmpty) ...[
    //         Text(
    //           movieDetails.genres,
    //           style: textTheme.bodyLarge,
    //         ),
    //         const CircleDot(),
    //       ] else ...[
    //         if (movieDetails.runtime!.isNotEmpty) ...[
    //           const CircleDot(),
    //         ]
    //       ],
    //       Text(
    //         movieDetails.runtime!,
    //         style: textTheme.bodyLarge,
    //       ),
    //     ],
    //   );
    // } else {
    //   return const SizedBox();
    // }
  }
}
