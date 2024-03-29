import 'package:checklist/app/features/checklist/checklist_item/bloc/checklist_item_cubit.dart';
import 'package:checklist/app/features/checklist/checklist_item/models/checklist_item.dart';
import 'package:flutter/material.dart';

class CheckListItemCard extends StatelessWidget {
  final CheckListItem checkListItem;
  final CheckListItemCubit checkListItemCubit;

  const CheckListItemCard(
      {super.key,
      required this.checkListItem,
      required this.checkListItemCubit});

  @override
  Widget build(BuildContext context) {
    final Color dividerColor = Theme.of(context).colorScheme.onBackground;
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
                      content: const Text(
                        "Deseja excluir Item?",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 24),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Text("Cancelar")),
                        TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: Text("Confirmar"))
                      ],
                    ));
          },
          direction: DismissDirection.endToStart,
          onDismissed: (direction) =>
              {checkListItemCubit.deleteItem(checkListItem)},
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
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Remover?",
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
                                label: Text("Descrição"),
                                hintText: "Insira uma descrição"))),
                  ),
                ),
              ).whenComplete(() => checkListItemCubit.updateItem(checkListItem))
            },
            child: ListTile(
              trailing: Checkbox(
                value: checkListItem.checked,
                onChanged: (value) {
                  checkListItem.checked = value ?? false;
                  checkListItemCubit.updateItem(checkListItem);
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
