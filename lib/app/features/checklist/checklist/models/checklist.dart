import 'package:checklist/app/features/checklist/checklist/enum/checklist_category.dart';
import 'package:checklist/app/features/checklist/checklist/models/value_objects/checklist_title.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class CheckList extends Equatable {
  final String id;
  CheckListTitle title;
  ChecklistCategory category;

  CheckList({required this.id, required this.title, required this.category});

  CheckList.empty()
      : id = "0",
        title = CheckListTitle(value: ""),
        category = ChecklistCategory.others;

  CheckList.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = CheckListTitle(value: json["title"]),
        category = ChecklistCategory.values.byName(json["category"]);

  Map<String, dynamic> toJson() =>
      {"id": id, "title": title.value, "category": category.name};

  @override
  List<Object?> get props => [id, title];
}
