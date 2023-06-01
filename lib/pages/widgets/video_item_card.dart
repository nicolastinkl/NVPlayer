import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:movie_app/resources/app_colors.dart';
import 'package:movie_app/resources/app_typography.dart';
import 'package:movies_data/movies_data.dart';

class VideoItemCard extends StatelessWidget {
  const VideoItemCard(
      {Key? key, required this.video, this.onPressed, this.isSelected = false})
      : super(key: key);

  final VideoItem video;
  final void Function()? onPressed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.secondaryColor.withAlpha(100)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        onTap: onPressed,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: SizedBox(
            height: 100,
            width: 100,
            child: CachedNetworkImage(
              imageUrl: 'https://img.youtube.com/vi/${video.key}/hqdefault.jpg',
              placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.secondary,
              )),
              errorWidget: (context, url, error) => Icon(
                IconlyBold.image,
                size: 100,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          video.name,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.labelSmall,
          maxLines: 2,
        ),
        subtitle: Text(
          video.size,
          style: AppTypography.labelSmall,
        ),
      ),
    );
  }
}
