import 'package:checklist/app/features/checklist/checklist/controllers/checklist_controller.dart';
import 'package:checklist/app/features/checklist/checklist/models/checklist.dart';
import 'package:checklist/app/features/checklist/checklist/models/value_objects/checklist_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class AddChecklistDialog extends StatelessWidget {
  final CheckList checkList;
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  AddChecklistDialog({super.key, required String checkListid})
      : checkList = CheckList(
            id: checkListid,
            checkListItens: [],
            title: CheckListTitle(value: ""));

  @override
  Widget build(BuildContext context) {
    final CheckListController checkListController =
        Provider.of<CheckListController>(context);
    final double screenHeight = MediaQuery.of(context).size.height;
    final Color cancelButtonColor = Theme.of(context).colorScheme.tertiary;
    final Color cancelButtonSecondColor =
        Theme.of(context).colorScheme.onTertiary;
    final String titleLabel = AppLocalizations.of(context)!.newList;
    final String titleHelper = AppLocalizations.of(context)!.typeTitleList;
    final String createText = AppLocalizations.of(context)!.create;
    final String cancelText = AppLocalizations.of(context)!.cancel;
    const double contentPadding = 16;
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(contentPadding),
        child: SizedBox(
          height: screenHeight * 0.26,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                titleLabel,
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
                        validator: (value) => checkList.title.validate(value),
                        onChanged: (value) =>
                            checkList.title = CheckListTitle(value: value),
                      ),
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
                            await checkListController.addCheckList(checkList);
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text(createText)),
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
