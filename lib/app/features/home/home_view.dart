import 'package:checklist/app/features/checklist/checklist/checklist_view.dart';
import 'package:checklist/app/features/configurations/controllers/configurations_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    const String pageTitle = "Listinha App";

    final ConfigurationsController configurationsController =
        Provider.of<ConfigurationsController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(pageTitle),
        actions: [
          IconButton(
              onPressed: () => configurationsController.toggleDarkMode(),
              icon: Observer(
                builder: (context) => Icon(
                    configurationsController.config.darkMode
                        ? Icons.dark_mode_outlined
                        : Icons.light_mode_outlined),
              ))
        ],
      ),
      body: const CheckListView(),
    );
  }
}
