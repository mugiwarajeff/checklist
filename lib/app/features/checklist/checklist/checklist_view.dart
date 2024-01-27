import 'package:checklist/app/features/checklist/checklist/bloc/checklist_cubit.dart';
import 'package:checklist/app/features/checklist/checklist/bloc/checklist_state.dart';

import 'package:checklist/app/features/checklist/checklist/widgets/add_checklist_dialog.dart';
import 'package:checklist/app/features/checklist/checklist/widgets/checklist_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckListView extends StatelessWidget {
  const CheckListView({super.key});

  @override
  Widget build(BuildContext context) {
    CheckListCubit checkListCubit = BlocProvider.of<CheckListCubit>(context);
    checkListCubit.loadCheckList();
    const double checkListPadding = 16;
    const double crossSpacin = 10;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(checkListPadding),
        child: BlocBuilder<CheckListCubit, CheckListState>(
          builder: (context, state) {
            if (state is InitialCheckListState) {
              return Container();
            } else if (state is LoadingCheckListState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LoadedCheckListState) {
              return GridView.count(
                  crossAxisSpacing: crossSpacin,
                  crossAxisCount: 2,
                  children: state.checklist
                      .map((checklist) => CheckListCard(checkList: checklist))
                      .toList());
            } else if (state is ErrorCheckListState) {
              return const Text("error");
            } else {
              return Container();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          int countOfChecklist = checkListCubit.checklists.length;

          showDialog(
            context: context,
            builder: (context) => AddChecklistDialog(
                checkListid: (countOfChecklist + 1).toString()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
