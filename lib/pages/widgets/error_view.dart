import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:movie_app/resources/app_typography.dart';
import 'package:movie_app/utils/strings.dart';

typedef OnRetry = void Function();

class ErrorView extends StatelessWidget {
  const ErrorView({Key? key, this.message, this.onRetry}) : super(key: key);

  final String? message;
  final OnRetry? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(IconlyBold.paper_negative,
              size: 65, color: Theme.of(context).colorScheme.onSurface),
          Text(message ?? errorMessage, style: AppTypography.bodyLarge),
          const SizedBox(height: 8.0),
          ElevatedButton(onPressed: onRetry, child: const Text(tryAgain))
        ],
      ),
    );
  }
}
