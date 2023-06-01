import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:movie_app/resources/app_typography.dart';
import 'package:movie_app/utils/strings.dart' show emptyMessage;

class EmptyView extends StatelessWidget {
  const EmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(IconlyBold.document,
              size: 65, color: Theme.of(context).colorScheme.onSurface),
          const SizedBox(height: 20),
          const Text(emptyMessage, style: AppTypography.titleLarge),
        ],
      ),
    );
  }
}
