import 'package:checklist/app/features/checklist/checklist/models/checklist.dart';
import 'package:checklist/app/features/checklist/checklist_item/bloc/checklist_item_cubit.dart';
import 'package:checklist/app/features/checklist/checklist_item/bloc/checklist_item_states.dart';
import 'package:checklist/app/features/checklist/checklist_item/models/checklist_item.dart';
import 'package:checklist/app/features/checklist/checklist_item/widgets/checklist_item_card.dart';
import 'package:checklist/app/shared/database/dao/checklist_item_dao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckListItemView extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CheckListItemCubit checkListItemCubit;
  final CheckList checkList;

  CheckListItemView({super.key, required this.checkList})
      : checkListItemCubit = CheckListItemCubit(
            checkListItemDao: CheckListItemDao(), checkList: checkList);

  @override
  Widget build(BuildContext context) {
    const String titleLabel = "Item";
    const String titleHint = "Digite o Item";
    CheckListItem checkListItem = CheckListItem(
        title: "", description: "", checked: false, checklistId: checkList.id);
    return BlocConsumer<CheckListItemCubit, CheckListItemState>(
      listener: (context, state) {
        if (state is ErrorCheckListItemState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
            backgroundColor: Theme.of(context).colorScheme.error,
            padding: const EdgeInsets.all(8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ));
        }
      },
      bloc: checkListItemCubit,
      builder: (context, state) {
        if (state is InitialCheckListItemState) {
          return Container();
        } else if (state is LoadingCheckListItemState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is LoadedCheckListItemState) {
          return Scaffold(
            appBar: AppBar(
              title: Text(checkList.title.value),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  ...checkListItemCubit.itens
                      .map((checkListItem) => CheckListItemCard(
                            checkListItem: checkListItem,
                            checkListItemCubit: checkListItemCubit,
                          ))
                      .toList(),
                  BlocBuilder(
                    bloc: checkListItemCubit,
                    builder: (context, state) {
                      if (state is LoadedWithAddCheckListItemState) {
                        return Form(
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
                                        onPressed: () {
                                          if (_formKey.currentState
                                                  ?.validate() ??
                                              false) {
                                            checkListItemCubit
                                                .addItem(checkListItem);
                                          }
                                        },
                                        child: const Text("Adicionar")),
                                    IconButton(
                                        onPressed: () =>
                                            checkListItemCubit.closeAddField(),
                                        icon: const Icon(Icons.cancel_outlined))
                                  ],
                                )),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  )
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => checkListItemCubit.openAddField(),
              child: const Icon(Icons.add),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
