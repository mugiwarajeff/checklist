import 'package:checklist/app/features/calendar/controllers/calendar_controller.dart';
import 'package:checklist/app/features/calendar/widgets/calendar.dart';
import 'package:checklist/app/features/calendar/widgets/item_calendar_list.dart';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).colorScheme.primary;
    CalendarController calendarController =
        Provider.of<CalendarController>(context);

    calendarController.loadEvents();

    return Observer(builder: (context) {
      if (calendarController.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      return Column(
        children: [
          const Calendar(),
          Divider(
            height: 3,
            color: primaryColor,
          ),
          Expanded(
              flex: 2,
              child: ItemCalendarList(
                calendarController: calendarController,
              ))
        ],
      );
    });
  }
}
