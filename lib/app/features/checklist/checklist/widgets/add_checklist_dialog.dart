import 'package:checklist/app/features/checklist/checklist/controllers/checklist_controller.dart';
import 'package:checklist/app/features/checklist/checklist/models/checklist.dart';
import 'package:checklist/app/features/checklist/checklist/models/value_objects/checklist_title.dart';
import 'package:flutter/material.dart';
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
    const String titleLabel = "Titulo";
    const String titleHelper = "Digite o Titulo da Lista";
    const double contentPadding = 16;
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(contentPadding),
        child: SizedBox(
          height: screenHeight * 0.26,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Nova Listinha",
                style: TextStyle(fontSize: 26),
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
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.title),
                          border: OutlineInputBorder(),
                          label: Text(titleLabel),
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
                        child: const Text("Criar")),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(cancelButtonColor),
                          foregroundColor:
                              WidgetStatePropertyAll(cancelButtonSecondColor)),
                      child: const Text("Cancelar"),
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
