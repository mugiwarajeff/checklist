import 'package:checklist/app/features/checklist/checklist_item/models/value_objects/checklist_title.dart';

class CheckListItem {
  String checklistId;
  int checklistItemId;
  ChecklistItemTitle title;
  String description;
  bool checked;
  DateTime? dueDate;
  DateTime createDate;

  CheckListItem(
      {required this.checklistItemId,
      required this.title,
      required this.description,
      required this.checked,
      required this.checklistId,
      required this.dueDate,
      required this.createDate});

  CheckListItem.empty()
      : checklistItemId = 0,
        checked = false,
        checklistId = "",
        description = "",
        title = ChecklistItemTitle(value: ""),
        createDate = DateTime.now(),
        dueDate = null;

  CheckListItem copy() {
    return CheckListItem(
        checked: checked,
        checklistId: checklistId,
        checklistItemId: checklistItemId,
        createDate: createDate,
        description: description,
        dueDate: dueDate,
        title: title);
  }

  CheckListItem.fromJson(Map<String, dynamic> json)
      : checked = json["checked"] == 1 ? true : false,
        checklistItemId = json["checklist_item_id"],
        checklistId = json["checklist_id"],
        description = json["description"],
        title = ChecklistItemTitle(value: json["title"]),
        dueDate = json["due_date"] == null
            ? json["due_date"]
            : DateTime.fromMillisecondsSinceEpoch(json["due_date"]),
        createDate = DateTime.fromMillisecondsSinceEpoch(json["create_date"]);

  Map<String, dynamic> toJson() => {
        "checked": checked == true ? 1 : 0,
        "checklist_id": checklistId,
        "description": description,
        "title": title.value,
        "due_date": dueDate?.millisecondsSinceEpoch,
        "create_date": createDate.millisecondsSinceEpoch
      };
}
