import 'package:checklist/app/features/checklist/checklist_item/models/checklist_item.dart';
import 'package:checklist/app/shared/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChecklistItemModal extends StatefulWidget {
  final TextEditingController dueDateController;
  final CheckListItem checkListItem;

  ChecklistItemModal({super.key, required this.checkListItem})
      : dueDateController = TextEditingController(
            text: checkListItem.dueDate == null
                ? ""
                : Utils.formatDateString(checkListItem.dueDate!));

  @override
  State<ChecklistItemModal> createState() => _ChecklistItemModalState();
}

class _ChecklistItemModalState extends State<ChecklistItemModal> {
  @override
  Widget build(BuildContext context) {
    final String overdueText = AppLocalizations.of(context)!.overdue;
    final String closeText = AppLocalizations.of(context)!.close;
    final String plannedText = AppLocalizations.of(context)!.planned;
    final String descriptionText = AppLocalizations.of(context)!.description;
    final String insertDescription =
        AppLocalizations.of(context)!.insertDescription;

    final String dueDateText = AppLocalizations.of(context)!.dueDate;
    final String dueDateDescription =
        AppLocalizations.of(context)!.dueDateDescription;
    final double mediaHeight = MediaQuery.of(context).size.height;

    (Color, String)? checkVisualForDuedate() {
      DateTime dateTime = DateTime.now();

      if (widget.checkListItem.dueDate == null) {
        return null;
      }

      if (Utils.isToday(dateTime, widget.checkListItem.dueDate!)) {
        return (const Color.fromARGB(150, 255, 235, 59), closeText);
      }

      if (widget.checkListItem.dueDate!.isBefore(dateTime)) {
        return (const Color.fromARGB(150, 244, 67, 54), overdueText);
      }

      if (widget.checkListItem.dueDate!.isAfter(dateTime)) {
        return (const Color.fromARGB(150, 76, 175, 79), plannedText);
      }
      return null;
    }

    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          right: 16,
          left: 16),
      child: SizedBox(
        height: mediaHeight * 0.5,
        child: Form(
            child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: TextFormField(
                      controller: widget.dueDateController,
                      readOnly: true,
                      maxLines: 1,
                      onChanged: (value) =>
                          widget.checkListItem.description = value,
                      onTap: () async {
                        DateTime? dateTime = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2030));

                        if (dateTime != null) {
                          widget.dueDateController.text =
                              Utils.formatDateString(dateTime);

                          widget.checkListItem.dueDate = dateTime;

                          setState(() {});
                        }
                      },
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          label: Text(dueDateText),
                          hintText: dueDateDescription)),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 50,
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color:
                            checkVisualForDuedate()?.$1 ?? Colors.transparent),
                    child: Center(
                        child: Text(
                      checkVisualForDuedate()?.$2 ?? "",
                      style: const TextStyle(fontSize: 18),
                    )),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
                initialValue: widget.checkListItem.description,
                maxLines: 5,
                onChanged: (value) => widget.checkListItem.description = value,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: Text(descriptionText),
                    hintText: insertDescription))
          ],
        )),
      ),
    );
  }
}
