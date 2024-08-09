import 'package:checklist/app/features/checklist/checklist_item/models/checklist_item.dart';
import 'package:checklist/app/features/checklist/checklist_item/widgets/checklist_item_modal.dart';
import 'package:checklist/app/shared/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CheckListItemCard extends StatelessWidget {
  final CheckListItem checkListItem;
  final Function(CheckListItem checklistItem) updateCallback;
  final Function(CheckListItem checklistItem) deleteCallback;

  const CheckListItemCard(
      {super.key,
      required this.checkListItem,
      required this.updateCallback,
      required this.deleteCallback});

  @override
  Widget build(BuildContext context) {
    final Color dividerColor = Theme.of(context).colorScheme.onSurface;

    final String dialogText =
        AppLocalizations.of(context)!.areYouSureWantToDelete;
    final String overdueText = AppLocalizations.of(context)!.overdue;
    final String closeText = AppLocalizations.of(context)!.close;
    final String plannedText = AppLocalizations.of(context)!.planned;
    final String confirmText = AppLocalizations.of(context)!.confirm;
    final String cancelText = AppLocalizations.of(context)!.cancel;
    final String removeText = AppLocalizations.of(context)!.remove;

    (Color, String)? checkVisualForDuedate() {
      DateTime dateTime = DateTime.now();

      if (checkListItem.dueDate == null) {
        return (Colors.grey, "");
      }

      if (Utils.isToday(dateTime, checkListItem.dueDate!)) {
        return (const Color.fromARGB(150, 255, 235, 59), closeText);
      }

      if (checkListItem.dueDate!.isBefore(dateTime)) {
        return (const Color.fromARGB(150, 244, 67, 54), overdueText);
      }

      if (checkListItem.dueDate!.isAfter(dateTime)) {
        return (const Color.fromARGB(150, 76, 175, 79), plannedText);
      }
      return null;
    }

    return Column(
      children: [
        Dismissible(
          key: Key(checkListItem.title.value),
          confirmDismiss: (direction) async {
            return await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: const Icon(
                        Icons.warning,
                        size: 42,
                      ),
                      alignment: Alignment.center,
                      content: Text(
                        dialogText,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 24),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Text(cancelText)),
                        TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: Text(confirmText))
                      ],
                    ));
          },
          direction: DismissDirection.endToStart,
          onDismissed: (direction) => {
            deleteCallback(checkListItem)
          }, //checkListItemController.deleteItem(checkListItem)
          background: Container(
            color: Theme.of(context).colorScheme.error,
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      color: Theme.of(context).colorScheme.onError,
                      Icons.delete,
                      size: 28,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "$removeText?",
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onError),
                    )
                  ],
                ),
              ),
            ),
          ),
          child: InkWell(
            onTap: () => {
              showModalBottomSheet(
                enableDrag: true,
                isDismissible: true,
                showDragHandle: true,
                isScrollControlled: true,
                context: context,
                builder: (context) => ChecklistItemModal(
                  checkListItem: checkListItem,
                  updateCallback: updateCallback,
                ),
              )
            },
            child: ListTile(
              leading: Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: checkVisualForDuedate()?.$1),
              ),
              trailing: Checkbox(
                value: checkListItem.checked,
                onChanged: (value) {
                  checkListItem.checked = value ?? false;
                  updateCallback(checkListItem);
                },
              ),
              title: Text(
                checkListItem.title.value,
                style: TextStyle(
                    decoration: checkListItem.checked
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
            ),
          ),
        ),
        Divider(
          color: dividerColor,
        )
      ],
    );
  }
}
