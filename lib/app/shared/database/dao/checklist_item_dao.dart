import 'package:checklist/app/features/checklist/checklist_item/models/checklist_item.dart';
import 'package:checklist/app/shared/database/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class CheckListItemDao {
  static const String _tableName = "checklist_item";
  static const String _checklistId = "checklist_id";
  static const String _description = "description";
  static const String _title = "title";
  static const String _checked = "checked";

  static const String createTableSql = 'CREATE TABLE $_tableName('
      '$_checklistId TEXT,'
      '$_title TEXT,'
      '$_description TEXT,'
      '$_checked INTEGER'
      ')';

  Future<int> insertItem(CheckListItem checkListItem) async {
    Database database = await DatabaseHelper.instance;

    int insertedItem =
        await database.insert(_tableName, checkListItem.toJson());

    return insertedItem;
  }

  Future<List<CheckListItem>> getAll(String checklistId) async {
    Database database = await DatabaseHelper.instance;

    List<Map<String, Object?>> queryResult = await database.query(_tableName,
        where: "$_checklistId = '$checklistId'");

    List<CheckListItem> checklistItens =
        queryResult.map((mapItem) => CheckListItem.fromJson(mapItem)).toList();

    return checklistItens;
  }
}
