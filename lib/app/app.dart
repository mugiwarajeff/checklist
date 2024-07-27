import 'package:checklist/app/features/configurations/controllers/configurations_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:checklist/app/features/home/home_view.dart';
import 'package:checklist/app/shared/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:provider/provider.dart';

class App extends StatelessWidget {
  final AppTheme appTheme = AppTheme();
  App({super.key});

  @override
  Widget build(BuildContext context) {
    final ConfigurationsController configurationsController =
        Provider.of<ConfigurationsController>(context);

    return Observer(builder: (context) {
      if (configurationsController.isLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: configurationsController.config.darkMode
            ? appTheme.darkTheme
            : appTheme.lightTheme,
        routes: {
          "/": (context) => const HomeView(),
        },
        initialRoute: "/",
      );
    });
  }
}
