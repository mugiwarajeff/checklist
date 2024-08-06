import 'package:checklist/app/features/checklist/checklist/models/value_objects/checklist_title.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class CheckList extends Equatable {
  final String id;

  CheckListTitle title;

  CheckList({required this.id, required this.title});

  CheckList.empty()
      : id = "0",
        title = CheckListTitle(value: "");

  CheckList.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = CheckListTitle(value: json["title"]);

  Map<String, dynamic> toJson() => {"id": id, "title": title.value};

  @override
  List<Object?> get props => [id, title];
}
