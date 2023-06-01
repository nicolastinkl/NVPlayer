import 'package:flutter/material.dart';
import 'package:movie_app/l10n/l10n.dart';

class NoConnectionView extends StatelessWidget {
  const NoConnectionView({Key? key, this.callback}) : super(key: key);

  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.signal_wifi_connected_no_internet_4_rounded,
            color: Theme.of(context).colorScheme.secondary,
            size: 100,
          ),
          Text(context.l10n.noConnection),
          ElevatedButton.icon(
            icon: const Icon(Icons.refresh),
            onPressed: callback,
            label: Text(context.l10n.tryAgain),
          )
        ],
      ),
    );
  }
}
