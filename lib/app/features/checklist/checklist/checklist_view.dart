import 'package:checklist/app/features/checklist/checklist/controllers/checklist_controller.dart';
import 'package:checklist/app/features/checklist/checklist/models/checklist.dart';
import 'package:checklist/app/features/checklist/checklist/widgets/add_checklist_dialog.dart';
import 'package:checklist/app/features/checklist/checklist/widgets/checklist_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:provider/provider.dart';

class CheckListView extends StatelessWidget {
  const CheckListView({super.key});

  @override
  Widget build(BuildContext context) {
    CheckListController checkListController =
        Provider.of<CheckListController>(context);

    checkListController.loadCheckLists();
    const double checkListPadding = 16;
    const double crossSpacin = 10;

    Alignment defineCircleAligmentScale(double x, double y) {
      final double screenSizeHeight = MediaQuery.of(context).size.height;
      final double screenSizeWidth = MediaQuery.of(context).size.width;

      const double referenceHeight = 1285.33333333;
      const double referenteWidth = 800;

      double scaleY = (screenSizeHeight / referenceHeight);
      double scaleX = (screenSizeWidth / referenteWidth);

      return Alignment(x / scaleX, y / scaleY);
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(checkListPadding),
        child: Observer(
          builder: (context) {
            if (checkListController.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (checkListController.error != "") {
              return Center(child: Text(checkListController.error));
            }

            return Stack(
              children: [
                GridView.count(
                    crossAxisSpacing: crossSpacin,
                    crossAxisCount: 2,
                    children: checkListController.checklists
                        .map((checklist) => Draggable<CheckList>(
                              childWhenDragging: Container(),
                              data: checklist,
                              feedback: CheckListCard(checkList: checklist),
                              child: CheckListCard(checkList: checklist),
                            ))
                        .toList()),
                DragTarget(
                  builder: (context, candidateData, rejectedData) => Align(
                    alignment: defineCircleAligmentScale(-1.3, 1.2),
                    child: Container(
                      alignment: const Alignment(0.35, -0.6),
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.error,
                          shape: BoxShape.circle),
                      child: Icon(
                        Icons.delete,
                        color: Theme.of(context).colorScheme.onError,
                        size: 36,
                      ),
                    ),
                  ),
                  onMove: (details) => print(details.data),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          int countOfChecklist = checkListController.checklists.length;

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
