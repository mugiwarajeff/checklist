import 'package:checklist/app/features/checklist/checklist_item/enum/checklist_order.dart';

abstract class CacheStore {
  Future<ChecklistOrder?> getLastChecklistOrder();

  Future<void> saveLastChecklistOrder(ChecklistOrder checklistOrder);
}
