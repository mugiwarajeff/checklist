import 'package:checklist/app/features/checklist/checklist/controllers/checklist_controller.dart';
import 'package:checklist/app/features/checklist/checklist/enum/checklist_category.dart';
import 'package:checklist/app/features/checklist/checklist/models/checklist.dart';
import 'package:checklist/app/features/checklist/checklist/utils/checklist_utils.dart';
import 'package:checklist/app/features/checklist/checklist/widgets/checklist_form_dialog.dart';
import 'package:checklist/app/features/checklist/checklist/widgets/checklist_card.dart';
import 'package:checklist/app/features/checklist/checklist/widgets/painters/edit_area_painter.dart';
import 'package:checklist/app/features/checklist/checklist/widgets/painters/exclure_area_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class CheckListView extends StatefulWidget {
  const CheckListView({super.key});

  @override
  State<CheckListView> createState() => _CheckListViewState();
}

class _CheckListViewState extends State<CheckListView> {
  final TextEditingController searchText = TextEditingController();
  bool isDragging = false;

  @override
  Widget build(BuildContext context) {
    final String searchHint = AppLocalizations.of(context)!.searchYourList;
    final String confirmButton = AppLocalizations.of(context)!.confirm;
    final String cancelButton = AppLocalizations.of(context)!.cancel;
    final String confirmationText =
        AppLocalizations.of(context)!.wantToDeleteChecklist;
    CheckListController checkListController =
        Provider.of<CheckListController>(context);

    checkListController.loadCheckLists();
    const double checkListPadding = 0;
    const double crossSpacin = 10;

    Color primaryColor = Theme.of(context).colorScheme.primary;
    Color redColor = Theme.of(context).colorScheme.error;
    Color onRedColor = Theme.of(context).colorScheme.onError;

    reaction((_) => checkListController.errorCode, (int errorCode) {
      if (errorCode != 0) {
        String message = "";

        switch (errorCode) {
          case 2067:
            message = AppLocalizations.of(context)!.wasNotPossibleToUpdate;
            break;

          default:
            message = "Error not recognized";
        }

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(message),
          ),
          backgroundColor: Theme.of(context).colorScheme.error,
          padding: const EdgeInsets.all(8),
        ));

        checkListController.errorCode = 0;
      }
    });
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

            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SearchBar(
                          controller: searchText,
                          hintText: searchHint,
                          onChanged: (value) {
                            checkListController.setSearchText(value);
                          },
                          leading: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.search),
                          ),
                          trailing: [
                            IconButton(
                                onPressed: () {
                                  checkListController.setSearchText("");
                                  searchText.text = "";
                                },
                                icon: const Icon(Icons.close)),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SegmentedButton<ChecklistCategory?>(
                            multiSelectionEnabled: false,
                            emptySelectionAllowed: true,
                            onSelectionChanged: (selections) {
                              if (selections.isEmpty) {
                                checkListController
                                    .setChecklistCategoryFilter(null);
                                return;
                              }

                              checkListController
                                  .setChecklistCategoryFilter(selections.first);
                            },
                            segments: ChecklistCategory.values
                                .map((category) => ButtonSegment(
                                    enabled: true,
                                    value: category,
                                    label: Text(
                                        ChecklistUtils.translateCategory(
                                            category,
                                            AppLocalizations.of(context)!))))
                                .toList(),
                            selected: {
                              checkListController.checklistCategoryFilter
                            }),
                      ),
                      Expanded(
                        flex: 2,
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
                                        onDraggableCanceled: (_, __) =>
                                            setState(() {
                                          isDragging = false;
                                        }),
                                        onDragCompleted: () => setState(() {
                                          isDragging = false;
                                        }),
                                        data: checklist,
                                        feedback:
                                            CheckListCard(checkList: checklist),
                                        child:
                                            CheckListCard(checkList: checklist),
                                      ))
                                  .toList()),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: SizedBox(
                    width: 100,
                    height: 100,
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
                Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: DragTarget<CheckList>(
                      builder: (context, candidateData, rejectedData) =>
                          LayoutBuilder(
                        builder: (context, constraints) => Visibility(
                          visible: isDragging,
                          child: CustomPaint(
                            painter: EditAreaPainter(
                              color: primaryColor,
                              centerOfCircle: Offset(
                                  constraints.maxWidth, constraints.maxHeight),
                            ),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: Icon(
                                  Icons.edit,
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
                            builder: (context) => ChecklistFormDialog(
                                  checklist: details.data,
                                ));
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: Visibility(
        visible: !isDragging,
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => ChecklistFormDialog(),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
