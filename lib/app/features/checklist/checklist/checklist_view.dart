import 'package:checklist/app/features/checklist/checklist/controllers/checklist_controller.dart';
import 'package:checklist/app/features/checklist/checklist/models/checklist.dart';
import 'package:checklist/app/features/checklist/checklist/widgets/add_checklist_dialog.dart';
import 'package:checklist/app/features/checklist/checklist/widgets/checklist_card.dart';
import 'package:checklist/app/features/checklist/checklist/widgets/painters/exclure_area_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class CheckListView extends StatefulWidget {
  const CheckListView({super.key});

  @override
  State<CheckListView> createState() => _CheckListViewState();
}

class _CheckListViewState extends State<CheckListView> {
  bool isDragging = false;

  @override
  Widget build(BuildContext context) {
    final String confirmButton = AppLocalizations.of(context)!.confirm;
    final String cancelButton = AppLocalizations.of(context)!.cancel;
    final String confirmationText =
        AppLocalizations.of(context)!.wantToDeleteChecklist;
    CheckListController checkListController =
        Provider.of<CheckListController>(context);

    checkListController.loadCheckLists();
    const double checkListPadding = 0;
    const double crossSpacin = 10;

    Color redColor = Theme.of(context).colorScheme.error;
    Color onRedColor = Theme.of(context).colorScheme.onError;

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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Observer(
                    builder: (context) => GridView.count(
                        crossAxisSpacing: crossSpacin,
                        crossAxisCount: 2,
                        children: checkListController.checklists
                            .map((checklist) => Draggable<CheckList>(
                                  childWhenDragging: Container(),
                                  onDragStarted: () => setState(() {
                                    isDragging = true;
                                  }),
                                  onDraggableCanceled: (_, __) => setState(() {
                                    isDragging = false;
                                  }),
                                  onDragCompleted: () => setState(() {
                                    isDragging = false;
                                  }),
                                  data: checklist,
                                  feedback: CheckListCard(checkList: checklist),
                                  child: CheckListCard(checkList: checklist),
                                ))
                            .toList()),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: DragTarget<CheckList>(
                      builder: (context, candidateData, rejectedData) =>
                          LayoutBuilder(
                        builder: (context, constraints) => Visibility(
                          visible: isDragging,
                          child: CustomPaint(
                            painter: ExclureAreaPainter(
                              color: redColor,
                              centerOfCircle: Offset(0, constraints.maxHeight),
                            ),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: Icon(
                                  Icons.delete,
                                  color: onRedColor,
                                  size: 56,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      onAcceptWithDetails: (details) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text(
                                confirmationText,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 24),
                              ),
                              title: Icon(
                                Icons.warning_amber_rounded,
                                size: 64,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      checkListController
                                          .deleteCheckList(details.data);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(confirmButton)),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(cancelButton)),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
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


/**
 * onWillAcceptWithDetails: (details) {
                        bool accept = false;

                        

                        return accept;
                      }
 */