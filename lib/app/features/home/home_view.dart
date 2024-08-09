import 'package:checklist/app/features/calendar/calendar_view.dart';
import 'package:checklist/app/features/checklist/checklist/checklist_view.dart';
import 'package:checklist/app/features/configurations/controllers/configurations_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int index = 0;

  Widget selectPage() {
    switch (index) {
      case 0:
        return const CheckListView();
      case 1:
        return const CalendarView();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    final String pageTitle = AppLocalizations.of(context)!.appTitle;
    final String listText = AppLocalizations.of(context)!.lists;
    final String calendarText = AppLocalizations.of(context)!.calendar;

    final ConfigurationsController configurationsController =
        Provider.of<ConfigurationsController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
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
      body: selectPage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.list), label: listText),
          BottomNavigationBarItem(
              icon: const Icon(Icons.calendar_month), label: calendarText)
        ],
        onTap: (value) {
          index = value;
          setState(() {});
        },
      ),
    );
  }
}
