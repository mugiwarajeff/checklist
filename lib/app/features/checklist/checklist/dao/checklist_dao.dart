import 'package:checklist/app/features/checklist/checklist/enum/checklist_category.dart';
import 'package:checklist/app/features/checklist/checklist/models/checklist.dart';

abstract class ChecklistDAO {
  Future<List<CheckList>> getAll(ChecklistCategory? checklistCategoryFilter);

  Future<int> insert(CheckList checkList);

  Future<int> getCheckListCount();

  Future<int> updateChecklist(CheckList checklist);

  Future<int> deleteCheckList(CheckList checklist);
}
