import 'package:checklist/app/features/checklist/checklist_item/controllers/checklist_item_controller.dart';
import 'package:checklist/app/features/checklist/checklist_item/models/checklist_item.dart';
import 'package:checklist/app/features/checklist/checklist_item/models/value_objects/checklist_title.dart';

import 'package:checklist/app/shared/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChecklistItemModal extends StatefulWidget {
  final ChecklistItemController checklistItemController;
  final TextEditingController dueDateController;
  final CheckListItem checkListItem;

  ChecklistItemModal(
      {super.key,
      required this.checkListItem,
      required this.checklistItemController})
      : dueDateController = TextEditingController(
            text: checkListItem.dueDate == null
                ? ""
                : Utils.formatDateString(checkListItem.dueDate!));

  @override
  State<ChecklistItemModal> createState() => _ChecklistItemModalState();
}

class _ChecklistItemModalState extends State<ChecklistItemModal> {
  late CheckListItem checkListItemCopy;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    checkListItemCopy = widget.checkListItem.copy();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations? appLocalizations = AppLocalizations.of(context);
    final String overdueText = AppLocalizations.of(context)!.overdue;
    final String titleText = AppLocalizations.of(context)!.title;
    final String titleHint = AppLocalizations.of(context)!.titleItem;
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

      if (checkListItemCopy.dueDate == null) {
        return null;
      }

      if (Utils.isToday(dateTime, checkListItemCopy.dueDate!)) {
        return (const Color.fromARGB(150, 255, 235, 59), closeText);
      }

      if (checkListItemCopy.dueDate!.isBefore(dateTime)) {
        return (const Color.fromARGB(150, 244, 67, 54), overdueText);
      }

      if (checkListItemCopy.dueDate!.isAfter(dateTime)) {
        return (const Color.fromARGB(150, 76, 175, 79), plannedText);
      }
      return null;
    }

    return PopScope(
      canPop: formState.currentState?.validate() ?? false,
      onPopInvoked: (didPop) async {
        if (formState.currentState?.validate() ?? false) {
          await widget.checklistItemController.updateItem(checkListItemCopy);
          widget.checklistItemController
              .loadItens(checkListItemCopy.checklistId);
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            right: 16,
            left: 16),
        child: SizedBox(
          height: mediaHeight * 0.5,
          child: SingleChildScrollView(
            child: Form(
                key: formState,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: checkListItemCopy.title.value,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          label: Text(titleText),
                          hintText: titleHint),
                      onChanged: (value) {
                        checkListItemCopy.title =
                            ChecklistItemTitle(value: value);
                      },
                      validator: (value) => checkListItemCopy.title
                          .validate(value, appLocalizations),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: TextFormField(
                              controller: widget.dueDateController,
                              readOnly: true,
                              maxLines: 1,
                              onChanged: (value) =>
                                  checkListItemCopy.description = value,
                              onTap: () async {
                                DateTime? dateTime = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2030));

                                if (dateTime != null) {
                                  widget.dueDateController.text =
                                      Utils.formatDateString(dateTime);

                                  checkListItemCopy.dueDate = dateTime;

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
                                color: checkVisualForDuedate()?.$1 ??
                                    Colors.transparent),
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
                        initialValue: checkListItemCopy.description,
                        maxLines: 5,
                        onChanged: (value) =>
                            checkListItemCopy.description = value,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            label: Text(descriptionText),
                            hintText: insertDescription))
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
