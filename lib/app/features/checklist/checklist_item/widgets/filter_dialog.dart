import 'package:checklist/app/features/checklist/checklist_item/controllers/checklist_item_controller.dart';
import 'package:checklist/app/features/checklist/checklist_item/enum/checklist_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class FilterDialog extends StatelessWidget {
  final int checklistItemId;
  final ChecklistItemController checklistItemController;
  const FilterDialog(
      {super.key,
      required this.checklistItemController,
      required this.checklistItemId});

  @override
  Widget build(BuildContext context) {
    final String filtersText = AppLocalizations.of(context)!.filters;
    final String creationText = AppLocalizations.of(context)!.creation;
    final String priorityText = AppLocalizations.of(context)!.priority;

    String translateChecklistOrder(ChecklistOrder checklistOrder) {
      switch (checklistOrder) {
        case ChecklistOrder.creation:
          return creationText;
        case ChecklistOrder.priority:
          return priorityText;
      }
    }

    return Dialog(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Observer(
            builder: (context) => Column(children: [
              Text(
                filtersText,
                style: const TextStyle(fontSize: 36),
              ),
              ...ChecklistOrder.values
                  .map((checklistOrder) => RadioListTile<ChecklistOrder>(
                      value: checklistOrder,
                      groupValue: checklistItemController.checklistOrder,
                      title: Text(translateChecklistOrder(checklistOrder)),
                      onChanged: (value) {
                        if (value != null) {
                          checklistItemController.setChecklistOrder(value);
                          checklistItemController.loadItens(checklistItemId);
                        }
                      }))
                  .toList()
            ]),
          ),
        ),
      ),
    );
  }
}
