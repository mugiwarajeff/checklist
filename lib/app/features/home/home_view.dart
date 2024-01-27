import 'package:checklist/app/features/checklist/checklist/checklist_view.dart';
import 'package:checklist/app/features/configurations/cubit/configurations_cubit.dart';
import 'package:checklist/app/features/configurations/cubit/configurations_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    const String pageTitle = "Checklist";
    final ConfigurationsCubit configurationsCubit =
        BlocProvider.of<ConfigurationsCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(pageTitle),
        actions: [
          IconButton(
              onPressed: () => configurationsCubit.toggleDarkMode(),
              icon: BlocBuilder(
                bloc: configurationsCubit,
                builder: (context, state) {
                  if (state is LoadedConfigurationsState) {
                    return Icon(
                      state.configObject.darkMode
                          ? Icons.dark_mode_outlined
                          : Icons.light_mode_outlined,
                    );
                  } else {
                    return Container();
                  }
                },
              ))
        ],
      ),
      body: const CheckListView(),
    );
  }
}
