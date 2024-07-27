import 'package:checklist/app/features/checklist/checklist_item/models/checklist_item.dart';

abstract class ChecklistItemDAO {
  Future<int> insertItem(CheckListItem checkListItem);

  Future<List<CheckListItem>> getAll(String checklistId);

  Future<int> updateItem(CheckListItem checkListItem);

  Future<int> deleteItem(CheckListItem checkListItem);
}
