import 'package:flutter/material.dart';

import 'package:movie_app/pages/detail/components/image_with_shimmer.dart';
import 'package:movie_app/resources/app_values.dart';
import 'package:movies_data/movies_data.dart';

class CastCard extends StatelessWidget {
  final CastItem cast;
  const CastCard({
    required this.cast,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: AppSize.s100,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSize.s8),
            child: ImageWithShimmer(
              imageUrl: cast.profilePath ?? "",
              width: double.infinity,
              height: AppSize.s130,
            ),
          ),
          Text(
            cast.originalName ?? "",
            style: textTheme.bodyLarge,
            maxLines: 2,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
