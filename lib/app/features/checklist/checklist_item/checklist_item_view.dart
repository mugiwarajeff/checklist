import 'package:checklist/app/features/checklist/checklist_item/controllers/checklist_item_controller.dart';
import 'package:checklist/app/features/checklist/checklist_item/models/checklist_item.dart';
import 'package:checklist/app/features/checklist/checklist_item/widgets/checklist_item_card.dart';
import 'package:checklist/app/features/checklist/checklist_item/widgets/filter_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CheckListItemView extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final String checkListId;
  final String checkListTitle;

  CheckListItemView(
      {super.key, required this.checkListId, required this.checkListTitle});

  @override
  Widget build(BuildContext context) {
    final String emptyField = AppLocalizations.of(context)!.emptyField;

    final String titleLabel = AppLocalizations.of(context)!.item;
    final String addText = AppLocalizations.of(context)!.add;
    final String titleHint = AppLocalizations.of(context)!.typeItem;

    ChecklistItemController checkListItemStore =
        Provider.of<ChecklistItemController>(context);

    checkListItemStore.loadItens(checkListId);

    CheckListItem checkListItem = CheckListItem.empty();

    reaction((_) => checkListItemStore.checklistOrder, (checkListItem) {
      checkListItemStore.loadItens(checkListId);
    });

    reaction(
      (_) => checkListItemStore.error,
      (String errorMessage) {
        if (errorMessage != "") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(checkListItemStore.error),
            backgroundColor: Theme.of(context).colorScheme.error,
            padding: const EdgeInsets.all(8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ));

          checkListItemStore.error = "";
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(checkListTitle),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => FilterDialog(
                          checklistItemController: checkListItemStore,
                        ));
              },
              icon: const Icon(Icons.filter_alt_rounded))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Observer(
          builder: (context) {
            if (checkListItemStore.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView(
              children: [
                ...checkListItemStore.checklistItems
                    .map((checkListItem) => CheckListItemCard(
                          checkListItem: checkListItem,
                          checkListItemController: checkListItemStore,
                        ))
                    .toList(),
                Observer(
                  builder: (context) => Visibility(
                    visible: checkListItemStore.addingNewItem,
                    child: Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: TextFormField(
                        autofocus: true,
                        validator: (value) {
                          String? error;
                          if (value != null && value.isEmpty) {
                            error = emptyField;
                          }

                          return error;
                        },
                        onChanged: (value) => checkListItem.title = value,
                        decoration: InputDecoration(
                            hintText: titleHint,
                            labelText: titleLabel,
                            suffixIcon: ButtonBar(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextButton(
                                    onPressed: () async {
                                      if (_formKey.currentState?.validate() ??
                                          false) {
                                        checkListItem.checklistId = checkListId;

                                        await checkListItemStore
                                            .addItem(checkListItem);

                                        checkListItem = CheckListItem.empty();
                                      }
                                    },
                                    child: Text(addText)),
                                IconButton(
                                    onPressed: () => checkListItemStore
                                        .setAddingNewItem(false),
                                    icon: const Icon(Icons.cancel_outlined))
                              ],
                            )),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => checkListItemStore.setAddingNewItem(true),
        child: const Icon(Icons.add),
      ),
    );
  }
}
