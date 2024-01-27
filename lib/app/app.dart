import 'package:checklist/app/features/configurations/cubit/configurations_cubit.dart';
import 'package:checklist/app/features/configurations/cubit/configurations_state.dart';
import 'package:checklist/app/features/home/home_view.dart';
import 'package:checklist/app/shared/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  final AppTheme appTheme = AppTheme();
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigurationsCubit, ConfigurationsState>(
      builder: (context, state) {
        if (state is LoadingConfigurationsState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is LoadedConfigurationsState) {
          return MaterialApp(
            theme: state.configObject.darkMode
                ? appTheme.darkTheme
                : appTheme.lightTheme,
            routes: {
              "/": (context) => const HomeView(),
            },
            initialRoute: "/",
          );
        } else {
          return Container();
        }
      },
    );
  }
}
