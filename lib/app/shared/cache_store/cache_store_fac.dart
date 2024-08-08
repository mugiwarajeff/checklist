import 'package:checklist/app/features/checklist/checklist_item/enum/checklist_order.dart';
import 'package:checklist/app/shared/cache_store/interface/cache_store.dart';
import 'package:flutter_auto_cache/flutter_auto_cache.dart';

class CacheStoreFac implements CacheStore {
  final String checklistOrderKey = "checklistOrder";

  @override
  Future<ChecklistOrder?> getLastChecklistOrder() async {
    String? checklistOrderName =
        (await AutoCache.data.getString(key: checklistOrderKey)).data;

    if (checklistOrderName == null) {
      return null;
    }

    ChecklistOrder checklistOrder =
        ChecklistOrder.values.byName(checklistOrderName);

    return checklistOrder;
  }

  @override
  Future<void> saveLastChecklistOrder(ChecklistOrder checklistOrder) async {
    await AutoCache.data
        .saveString(key: checklistOrderKey, data: checklistOrder.name);
  }
}
