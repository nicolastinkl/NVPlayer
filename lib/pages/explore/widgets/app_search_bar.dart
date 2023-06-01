import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:movie_app/l10n/l10n.dart';
import 'package:movie_app/pages/explore/bloc/explore_bloc.dart';
import 'package:movie_app/resources/app_typography.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({Key? key}) : super(key: key);

  // void _showDialog(BuildContext context) => showModalBottomSheet(
  //       context: context,
  //       builder: (_) => const FilterDialog(),
  //     );

  void _onSubmitQuery(BuildContext context, String value) {
    if (value.isEmpty) return;
    context.read<ExploreBloc>().add(SearchMoviesEvent(value));
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      floating: true,
      snap: true,
      expandedHeight: 70,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  style: AppTypography.labelMedium,
                  cursorColor: Theme.of(context).colorScheme.secondary,
                  decoration: InputDecoration(
                    filled: true,
                    hoverColor: Colors.transparent,
                    contentPadding: const EdgeInsets.all(4.0),
                    fillColor:
                        Theme.of(context).colorScheme.secondary.withAlpha(50),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    hintStyle: AppTypography.labelMedium.copyWith(
                      color: Colors.grey,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        IconlyLight.search,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    hintText: context.l10n.search,
                  ),
                  onSubmitted: (value) {
                    _onSubmitQuery(context, value);
                  },
                  textInputAction: TextInputAction.search,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  color: Theme.of(context).colorScheme.secondary.withAlpha(50),
                ),
                child: IconButton(
                  onPressed: () {
                    // _showDialog(context);
                  },
                  icon: Icon(
                    IconlyBold.filter,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
