import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/app/config_bloc/config_bloc.dart';
import 'package:movie_app/l10n/l10n.dart';
import 'package:movie_app/resources/app_colors.dart';
import 'package:movie_app/resources/app_typography.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigBloc, ConfigState>(
      builder: (context, state) {
        return const _ProfileView();
      },
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.profile),
        elevation: 0.0,
      ),
      body: BlocBuilder<ConfigBloc, ConfigState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.shield_moon_rounded,
                      color: Theme.of(context).colorScheme.onBackground),
                  title: Text(context.l10n.darkMode,
                      style: AppTypography.labelLarge),
                  trailing: Switch.adaptive(
                    activeColor: Theme.of(context).colorScheme.onPrimary,
                    value: state.darkTheme,
                    onChanged: (bool newValue) {
                      context
                          .read<ConfigBloc>()
                          .add(ChangeThemeModeEvent(newValue));
                    },
                  ),
                ),
                ListTile(
                  onTap: () async {
                    showDialog<String>(
                      context: context,
                      builder: (context) => const _LangDialog(),
                    );
                  },
                  leading: Icon(Icons.language,
                      color: Theme.of(context).colorScheme.onBackground,
                      size: 30),
                  title: Text(context.l10n.language,
                      style: AppTypography.labelLarge),
                  trailing: Icon(Icons.arrow_forward_ios_rounded,
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _LangDialog extends StatelessWidget {
  const _LangDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigBloc, ConfigState>(
      builder: (context, state) {
        return AlertDialog(
          icon: Icon(Icons.language,
              color: Theme.of(context).colorScheme.onBackground, size: 30),
          title: Text(
            context.l10n.changeLanguage,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          content: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ToggleButtons(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                selectedBorderColor: Theme.of(context).colorScheme.secondary,
                direction: Axis.horizontal,
                selectedColor: Colors.white,
                fillColor: AppColors.secondaryColor,
                color: AppColors.secondaryColor,
                constraints: const BoxConstraints(
                  minHeight: 40.0,
                  minWidth: 80.0,
                ),
                isSelected: state.languages.values.toList(),
                onPressed: (index) {
                  final lang = state.languages.keys.elementAt(index);
                  final langCode = state.getLangCode(lang);
                  context.read<ConfigBloc>().add(ChangeLanguageEvent(langCode));
                },
                children: state.languages.keys
                    .map((e) =>
                        Text(e, style: Theme.of(context).textTheme.bodyMedium))
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
