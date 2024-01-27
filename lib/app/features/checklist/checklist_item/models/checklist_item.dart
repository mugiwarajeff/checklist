class CheckListItem {
  final String checklistId;
  final String title;
  final String description;
  bool checked;

  CheckListItem(
      {required this.title,
      required this.description,
      required this.checked,
      required this.checklistId});

  CheckListItem.empty()
      : checked = false,
        checklistId = "",
        description = "",
        title = "";

  CheckListItem.fromJson(Map<String, dynamic> json)
      : checked = json["checked"] == 1 ? true : false,
        checklistId = json["checklist_id"],
        description = json["description"],
        title = json["title"];

  Map<String, dynamic> toJson() => {
        "checked": checked == true ? 1 : 0,
        "checklist_id": checklistId,
        "description": description,
        "title": title
      };
}
