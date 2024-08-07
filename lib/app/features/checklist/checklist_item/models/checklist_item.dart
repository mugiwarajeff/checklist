class CheckListItem {
  String checklistId;
  String title;
  String description;
  bool checked;
  DateTime? dueDate;
  DateTime createDate;

  CheckListItem(
      {required this.title,
      required this.description,
      required this.checked,
      required this.checklistId,
      required this.dueDate,
      required this.createDate});

  CheckListItem.empty()
      : checked = false,
        checklistId = "",
        description = "",
        title = "",
        createDate = DateTime.now(),
        dueDate = null;

  CheckListItem.fromJson(Map<String, dynamic> json)
      : checked = json["checked"] == 1 ? true : false,
        checklistId = json["checklist_id"],
        description = json["description"],
        title = json["title"],
        dueDate = json["due_date"] == null
            ? json["due_date"]
            : DateTime.fromMillisecondsSinceEpoch(json["due_date"]),
        createDate = DateTime.fromMillisecondsSinceEpoch(json["create_date"]);

  Map<String, dynamic> toJson() => {
        "checked": checked == true ? 1 : 0,
        "checklist_id": checklistId,
        "description": description,
        "title": title,
        "due_date": dueDate?.millisecondsSinceEpoch,
        "create_date": createDate.millisecondsSinceEpoch
      };
}
