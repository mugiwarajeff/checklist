import 'package:checklist/app/features/checklist/checklist/models/checklist.dart';
import 'package:mobx/mobx.dart';

abstract class CheckListStore {
  ObservableList<CheckList> checklists = ObservableList<CheckList>();

  bool isLoading = false;

  String error = "";
  Future<void> loadCheckLists();

  Future<void> addCheckList(CheckList checklist);
}
