import 'package:checklist/app/features/checklist/checklist/models/checklist.dart';
import 'package:checklist/app/features/checklist/checklist_item/bloc/checklist_item_cubit.dart';
import 'package:checklist/app/features/checklist/checklist_item/bloc/checklist_item_states.dart';
import 'package:checklist/app/features/checklist/checklist_item/widgets/checklist_item_card.dart';
import 'package:checklist/app/shared/database/dao/checklist_item_dao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckListItemView extends StatelessWidget {
  final TextEditingController titleTextEditingController =
      TextEditingController();
  final CheckListItemCubit checkListItemCubit;
  final CheckList checkList;

  CheckListItemView({super.key, required this.checkList})
      : checkListItemCubit = CheckListItemCubit(
            checkListItemDao: CheckListItemDao(), checkList: checkList);

  @override
  Widget build(BuildContext context) {
    bool addFieldVisibility = false;
    return BlocBuilder<CheckListItemCubit, CheckListItemState>(
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
                      .map((checkListItem) =>
                          CheckListItemCard(checkListItem: checkListItem))
                      .toList(),
                  Visibility(
                    visible: addFieldVisibility,
                    child: TextFormField(
                      controller: titleTextEditingController,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Campo Vazio";
                        }
                      },
                      decoration: InputDecoration(
                          suffixIcon: TextButton(
                              onPressed: () {},
                              child: const Text("Adicionar"))),
                    ),
                  )
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                addFieldVisibility = true;
              },
              child: const Icon(Icons.add),
            ),
          );
        } else if (state is ErrorCheckListItemState) {
          return Text(state.message);
        } else {
          return Container();
        }
      },
    );
  }
}
