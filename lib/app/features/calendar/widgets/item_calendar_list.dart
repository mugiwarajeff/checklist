import 'package:checklist/app/features/calendar/controllers/calendar_controller.dart';

import 'package:checklist/app/features/checklist/checklist_item/widgets/checklist_item_card.dart';
import 'package:checklist/app/shared/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ItemCalendarList extends StatelessWidget {
  final CalendarController calendarController;

  const ItemCalendarList({
    super.key,
    required this.calendarController,
  });

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => ListView(
        children: calendarController.checklistItems
            .where((item) => Utils.isToday(item.dueDate ?? DateTime.now(),
                calendarController.selectedDate))
            .map((item) => CheckListItemCard(
                  checkListItem: item,
                  deleteCallback: (checklistItem) {
                    calendarController.deleteItem(checklistItem);
                  },
                  updateCallback: (checklistItem) {
                    calendarController.updateItem(checklistItem);
                  },
                ))
            .toList(),
      ),
    );
  }
}
