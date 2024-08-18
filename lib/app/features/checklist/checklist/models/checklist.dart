import 'package:checklist/app/features/checklist/checklist/models/value_objects/checklist_title.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class CheckList extends Equatable {
  final int id;
  CheckListTitle title;
  String category;

  CheckList({required this.id, required this.title, required this.category});

  CheckList.empty()
      : id = 0,
        title = CheckListTitle(value: ""),
        category = "";

  CheckList.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = CheckListTitle(value: json["title"]),
        category = json["category"];

  Map<String, dynamic> toJson() => {"title": title.value, "category": category};

  @override
  List<Object?> get props => [id, title];
}
