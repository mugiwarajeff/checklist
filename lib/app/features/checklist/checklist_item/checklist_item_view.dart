import 'package:checklist/app/features/checklist/checklist_item/controllers/checklist_item_controller.dart';
import 'package:checklist/app/features/checklist/checklist_item/models/checklist_item.dart';
import 'package:checklist/app/features/checklist/checklist_item/widgets/checklist_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class CheckListItemView extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final String checkListId;
  final String checkListTitle;

  CheckListItemView(
      {super.key, required this.checkListId, required this.checkListTitle});

  @override
  Widget build(BuildContext context) {
    const String titleLabel = "Item";
    const String titleHint = "Digite o Item";

    ChecklistItemController checkListItemStore =
        Provider.of<ChecklistItemController>(context);

    checkListItemStore.loadItens(checkListId);

    CheckListItem checkListItem = CheckListItem.empty();

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
                            error = "Campo Vazio";
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
                                    child: const Text("Adicionar")),
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
