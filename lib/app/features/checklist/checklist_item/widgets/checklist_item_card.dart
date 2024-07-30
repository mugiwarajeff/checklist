import 'package:checklist/app/features/checklist/checklist_item/controllers/checklist_item_controller.dart';
import 'package:checklist/app/features/checklist/checklist_item/models/checklist_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CheckListItemCard extends StatelessWidget {
  final CheckListItem checkListItem;
  final ChecklistItemController checkListItemController;

  const CheckListItemCard(
      {super.key,
      required this.checkListItem,
      required this.checkListItemController});

  @override
  Widget build(BuildContext context) {
    final Color dividerColor = Theme.of(context).colorScheme.onSurface;

    final String dialogText =
        AppLocalizations.of(context)!.areYouSureWantToDelete;
    final String confirmText = AppLocalizations.of(context)!.confirm;
    final String cancelText = AppLocalizations.of(context)!.cancel;
    final String removeText = AppLocalizations.of(context)!.remove;

    final String descriptionText = AppLocalizations.of(context)!.description;
    final String insertDescription =
        AppLocalizations.of(context)!.insertDescription;

    return Column(
      children: [
        Dismissible(
          key: Key(checkListItem.title),
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
          onDismissed: (direction) =>
              {checkListItemController.deleteItem(checkListItem)},
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
                builder: (context) => Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                      right: 16,
                      left: 16),
                  child: SizedBox(
                    child: Form(
                        child: TextFormField(
                            initialValue: checkListItem.description,
                            maxLines: 5,
                            onChanged: (value) =>
                                checkListItem.description = value,
                            decoration: InputDecoration(
                                label: Text(descriptionText),
                                hintText: insertDescription))),
                  ),
                ),
              ).whenComplete(
                  () => checkListItemController.updateItem(checkListItem))
            },
            child: ListTile(
              trailing: Checkbox(
                value: checkListItem.checked,
                onChanged: (value) {
                  checkListItem.checked = value ?? false;
                  checkListItemController.updateItem(checkListItem);
                },
              ),
              title: Text(
                checkListItem.title,
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
