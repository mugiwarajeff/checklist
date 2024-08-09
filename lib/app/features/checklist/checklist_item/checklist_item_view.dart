import 'package:checklist/app/features/checklist/checklist_item/controllers/checklist_item_controller.dart';
import 'package:checklist/app/features/checklist/checklist_item/models/checklist_item.dart';
import 'package:checklist/app/features/checklist/checklist_item/models/value_objects/checklist_title.dart';
import 'package:checklist/app/features/checklist/checklist_item/widgets/checklist_item_card.dart';
import 'package:checklist/app/features/checklist/checklist_item/widgets/filter_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CheckListItemView extends StatefulWidget {
  final int checkListId;
  final String checkListTitle;

  const CheckListItemView(
      {super.key, required this.checkListId, required this.checkListTitle});

  @override
  State<CheckListItemView> createState() => _CheckListItemViewState();
}

class _CheckListItemViewState extends State<CheckListItemView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final String emptyField = AppLocalizations.of(context)!.emptyField;

    final String titleLabel = AppLocalizations.of(context)!.item;
    final String addText = AppLocalizations.of(context)!.add;
    final String titleHint = AppLocalizations.of(context)!.typeItem;

    ChecklistItemController checkListItemStore =
        Provider.of<ChecklistItemController>(context);

    checkListItemStore.loadItens(widget.checkListId);

    CheckListItem checkListItem = CheckListItem.empty();

    reaction(
      (_) => checkListItemStore.errorCode,
      (int erroCode) {
        String errorMessage = "";
        if (erroCode != 0) {
          switch (erroCode) {
            case 1555:
              errorMessage =
                  AppLocalizations.of(context)!.wasNotPossibleToUpdate;
              break;
            case 2067:
              errorMessage =
                  AppLocalizations.of(context)!.wasNotPossibleToUpdate;
              break;
            default:
              errorMessage = "error not identified";
              break;
          }

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(errorMessage),
            backgroundColor: Theme.of(context).colorScheme.error,
            padding: const EdgeInsets.all(8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ));

          checkListItemStore.errorCode = 0;
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.checkListTitle),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => FilterDialog(
                          checklistItemId: widget.checkListId,
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
                          updateCallback: (CheckListItem checklistItem) async {
                            await checkListItemStore.updateItem(checklistItem);
                            checkListItemStore
                                .loadItens(checklistItem.checklistId);
                          },
                          checkListItem: checkListItem,
                          deleteCallback: (CheckListItem checklistItem) {
                            checkListItemStore.deleteItem(checkListItem);
                          },
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
                        onChanged: (value) => checkListItem.title =
                            ChecklistItemTitle(value: value),
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
                                        checkListItem.checklistId =
                                            widget.checkListId;

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
