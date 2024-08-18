import 'package:checklist/app/features/checklist/checklist/models/checklist.dart';

abstract class ChecklistDAO {
  Future<List<CheckList>> getAll(String? checklistCategoryFilter);

  Future<int> insert(CheckList checkList);

  Future<int> getCheckListCount();

  Future<int> updateChecklist(CheckList checklist);

  Future<int> deleteCheckList(CheckList checklist);
}
