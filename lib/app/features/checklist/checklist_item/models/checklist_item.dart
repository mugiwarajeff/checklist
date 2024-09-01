import 'package:checklist/app/features/checklist/checklist_item/models/value_objects/checklist_title.dart';
import 'package:checklist/app/features/checklist/checklist_item/models/value_objects/reference_link.dart';

class CheckListItem {
  int checklistId;
  int checklistItemId;
  ChecklistItemTitle title;
  String description;
  bool checked;
  DateTime? dueDate;
  DateTime createDate;
  ReferenceLink referenceLink;

  CheckListItem(
      {required this.checklistItemId,
      required this.title,
      required this.description,
      required this.checked,
      required this.checklistId,
      required this.dueDate,
      required this.createDate,
      required this.referenceLink});

  CheckListItem.empty()
      : checklistItemId = 0,
        checked = false,
        checklistId = 0,
        description = "",
        title = ChecklistItemTitle(value: ""),
        createDate = DateTime.now(),
        dueDate = null,
        referenceLink = ReferenceLink(value: "");

  CheckListItem copy() {
    return CheckListItem(
        checked: checked,
        checklistId: checklistId,
        checklistItemId: checklistItemId,
        createDate: createDate,
        description: description,
        dueDate: dueDate,
        title: title,
        referenceLink: referenceLink);
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
        createDate = DateTime.fromMillisecondsSinceEpoch(
          json["create_date"],
        ),
        referenceLink = ReferenceLink(value: json["reference_link"]);

  Map<String, dynamic> toJson() => {
        "checked": checked == true ? 1 : 0,
        "checklist_id": checklistId,
        "description": description,
        "title": title.value,
        "due_date": dueDate?.millisecondsSinceEpoch,
        "create_date": createDate.millisecondsSinceEpoch,
        "reference_link": referenceLink.value
      };
}
