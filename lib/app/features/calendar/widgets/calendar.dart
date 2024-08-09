import 'package:checklist/app/features/calendar/controllers/calendar_controller.dart';
import 'package:checklist/app/features/configurations/controllers/configurations_controller.dart';
import 'package:checklist/app/shared/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  const Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).colorScheme.primary;
    Color secondaryColor = Theme.of(context).colorScheme.secondary;
    Color onPrymaryColor = Theme.of(context).colorScheme.onPrimary;
    ConfigurationsController configurationsController =
        Provider.of<ConfigurationsController>(context);

    CalendarController calendarController =
        Provider.of<CalendarController>(context);

    List<Object?> loadEvents(DateTime day) {
      return calendarController.checklistItems
          .where(
            (element) => Utils.isToday(element.dueDate ?? DateTime.now(), day),
          )
          .toList();
    }

    return Observer(
      builder: (context) => TableCalendar(
        onDaySelected: (selectedDay, focusedDay) =>
            calendarController.setSelectedDate(selectedDay),
        locale: configurationsController.locale.toLanguageTag(),
        focusedDay: calendarController.selectedDate,
        firstDay: DateTime.now().subtract(const Duration(days: 1000)),
        lastDay: DateTime(2030),
        eventLoader: loadEvents,
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: primaryColor,
          ),
          markersAlignment: Alignment.bottomRight,
        ),
        calendarBuilders: CalendarBuilders(
          markerBuilder: (context, day, events) {
            if (events.isEmpty) {
              return null;
            }
            return Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: secondaryColor),
                child: Center(
                    child: Text(
                  events.length.toString(),
                  style: TextStyle(color: onPrymaryColor),
                )));
          },
        ),
        currentDay: calendarController.selectedDate,
      ),
    );
  }
}
