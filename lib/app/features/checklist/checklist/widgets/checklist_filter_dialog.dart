import 'package:checklist/app/features/checklist/checklist/controllers/checklist_controller.dart';
import 'package:checklist/app/features/checklist/checklist/enum/checklist_category.dart';
import 'package:checklist/app/features/checklist/checklist/utils/checklist_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChecklistFilterDialog extends StatelessWidget {
  final CheckListController checkListController;

  const ChecklistFilterDialog({super.key, required this.checkListController});
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final String categoryText = AppLocalizations.of(context)!.category;
    final String closeText = AppLocalizations.of(context)!.closePage;
    final String titleText = AppLocalizations.of(context)!.checklistFilter;
    final String categoryHint = AppLocalizations.of(context)!.categoryHint;

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
            height: screenSize.height * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(titleText, style: const TextStyle(fontSize: 26)),
                const SizedBox(
                  height: 25,
                ),
                DropdownButtonFormField<ChecklistCategory>(
                  value: checkListController.checklistCategoryFilter,
                  items: ChecklistCategory.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(ChecklistUtils.translateCategory(
                              category, AppLocalizations.of(context)!)),
                        ),
                      )
                      .toList()
                    ..add(
                      const DropdownMenuItem(
                        value: null,
                        child: Text(""),
                      ),
                    ),
                  onChanged: (value) {
                    checkListController.setChecklistCategoryFilter(value);
                    checkListController.loadCheckLists();
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.category),
                    border: const OutlineInputBorder(),
                    label: Text(categoryText),
                    hintText: categoryHint,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                ButtonBar(children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(closeText))
                ])
              ],
            )),
      ),
    );
  }
}
