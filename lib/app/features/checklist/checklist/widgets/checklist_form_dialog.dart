import 'package:checklist/app/features/checklist/checklist/controllers/checklist_controller.dart';
import 'package:checklist/app/features/checklist/checklist/enum/checklist_category.dart';
import 'package:checklist/app/features/checklist/checklist/models/checklist.dart';
import 'package:checklist/app/features/checklist/checklist/models/value_objects/checklist_title.dart';
import 'package:checklist/app/features/checklist/checklist/utils/checklist_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ChecklistFormDialog extends StatelessWidget {
  final CheckList? checklist;
  final CheckList checkListCopy;
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  ChecklistFormDialog({super.key, this.checklist})
      : checkListCopy = checklist ??
            CheckList(
                id: 0,
                title: CheckListTitle(value: ""),
                category: ChecklistCategory.shopping);

  @override
  Widget build(BuildContext context) {
    final CheckListController checkListController =
        Provider.of<CheckListController>(context);
    final double screenHeight = MediaQuery.of(context).size.height;
    final Color cancelButtonColor = Theme.of(context).colorScheme.tertiary;
    final Color cancelButtonSecondColor =
        Theme.of(context).colorScheme.onTertiary;
    final String titleLabel = AppLocalizations.of(context)!.newList;
    final String updateTitleLabel = AppLocalizations.of(context)!.updateList;
    final String titleHelper = AppLocalizations.of(context)!.typeTitleList;
    final String updateText = AppLocalizations.of(context)!.update;
    final String createText = AppLocalizations.of(context)!.create;
    final String cancelText = AppLocalizations.of(context)!.cancel;

    final String categoryText = AppLocalizations.of(context)!.category;
    final String categoryHint = AppLocalizations.of(context)!.categoryHint;

    const double contentPadding = 16;
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(contentPadding),
        child: SizedBox(
          height: screenHeight * 0.36,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                checklist == null ? titleLabel : updateTitleLabel,
                style: const TextStyle(fontSize: 26),
              ),
              const SizedBox(
                height: 5,
              ),
              Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formState,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.title),
                          border: const OutlineInputBorder(),
                          label: Text(titleHelper),
                          hintText: titleHelper,
                        ),
                        initialValue: checkListCopy.title.value,
                        validator: (value) => checkListCopy.title
                            .validate(value, AppLocalizations.of(context)),
                        onChanged: (value) =>
                            checkListCopy.title = CheckListTitle(value: value),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DropdownButtonFormField<ChecklistCategory>(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.category),
                          border: const OutlineInputBorder(),
                          label: Text(categoryText),
                          hintText: categoryHint,
                        ),
                        value: checkListCopy.category,
                        items: ChecklistCategory.values
                            .map((category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(ChecklistUtils.translateCategory(
                                      category, AppLocalizations.of(context)!)),
                                ))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            checkListCopy.category = value;
                          }
                        },
                      )
                    ],
                  )),
              const SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ButtonBar(
                  alignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          if (_formState.currentState?.validate() ?? false) {
                            if (checklist == null) {
                              await checkListController
                                  .addCheckList(checkListCopy);
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pop();
                              return;
                            }

                            await checkListController
                                .updateChecklist(checkListCopy);
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pop();
                          }
                        },
                        child:
                            Text(checklist == null ? createText : updateText)),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(cancelButtonColor),
                          foregroundColor:
                              WidgetStatePropertyAll(cancelButtonSecondColor)),
                      child: Text(cancelText),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
