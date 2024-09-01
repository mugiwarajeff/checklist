import 'package:checklist/app/features/checklist/checklist_item/dao/checklist_item_dao.dart';
import 'package:checklist/app/features/checklist/checklist_item/enum/checklist_order.dart';
import 'package:checklist/app/features/checklist/checklist_item/models/checklist_item.dart';
import 'package:checklist/app/shared/database/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class CheckListItemDaoSqflite implements ChecklistItemDAO {
  static const String _tableName = "checklist_item";
  static const String _checklistItemId = "checklist_item_id";
  static const String _checklistId = "checklist_id";
  static const String _description = "description";
  static const String _title = "title";
  static const String _checked = "checked";
  static const String _dueDate = "due_date";
  static const String _createDate = "create_date";
  static const String _referenceLink = "reference_link";

  static const String createTableSql = """CREATE TABLE $_tableName(
      $_checklistId INTEGER,
      $_checklistItemId INTEGER PRIMARY KEY,
      $_title TEXT UNIQUE,
      $_description TEXT,
      $_checked INTEGER,
      $_dueDate INTEGER,
      $_createDate INTEGER,
      $_referenceLink TEXT
      )
      """;

  @override
  Future<int> insertItem(CheckListItem checkListItem) async {
    Database database = await DatabaseHelper.instance;

    int insertedItem =
        await database.insert(_tableName, checkListItem.toJson());

    return insertedItem;
  }

  @override
  Future<List<CheckListItem>> getAll(
      int checklistId, ChecklistOrder checklistOrder) async {
    Database database = await DatabaseHelper.instance;

    String orderByClause = checklistOrder == ChecklistOrder.priority
        ? "CASE WHEN $_dueDate IS NULL THEN 1 ELSE 0 END, $_dueDate ASC"
        : "$_createDate ASC";

    List<Map<String, Object?>> queryResult = await database.query(_tableName,
        where: "$_checklistId = ?",
        whereArgs: [checklistId],
        orderBy: orderByClause);

    List<CheckListItem> checklistItens =
        queryResult.map((mapItem) => CheckListItem.fromJson(mapItem)).toList();

    return checklistItens;
  }

  @override
  Future<int> updateItem(CheckListItem checkListItem) async {
    Database database = await DatabaseHelper.instance;

    int insertedItem = await database.update(_tableName, checkListItem.toJson(),
        where: "$_checklistItemId = '${checkListItem.checklistItemId}'");

    return insertedItem;
  }

  @override
  Future<int> deleteItem(CheckListItem checkListItem) async {
    Database database = await DatabaseHelper.instance;

    int deletedItem = await database.delete(_tableName,
        where: "$_checklistItemId = '${checkListItem.checklistItemId}'");

    return deletedItem;
  }

  @override
  Future<List<CheckListItem>> getItensWithDueDate() async {
    Database database = await DatabaseHelper.instance;

    String whereClause = "$_dueDate IS NOT NULL";

    List<Map<String, Object?>> queryResult =
        await database.query(_tableName, where: whereClause);

    List<CheckListItem> checklistItens =
        queryResult.map((mapItem) => CheckListItem.fromJson(mapItem)).toList();

    return checklistItens;
  }
}
