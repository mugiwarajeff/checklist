import 'package:checklist/app/features/checklist/checklist/models/value_objects/checklist_title.dart';
import 'package:checklist/app/features/checklist/checklist_item/models/checklist_item.dart';

class CheckList {
  final String id;
  final List<CheckListItem> checkListItens;
  CheckListTitle title;

  CheckList(
      {required this.id, required this.checkListItens, required this.title});

  CheckList.empty()
      : id = "0",
        checkListItens = [],
        title = CheckListTitle(value: "");

  CheckList.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = CheckListTitle(value: json["title"]),
        checkListItens = [];

  Map<String, dynamic> toJson() => {"id": id, "title": title.value};
}
