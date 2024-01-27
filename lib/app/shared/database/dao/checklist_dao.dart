import 'package:checklist/app/features/checklist/checklist/models/checklist.dart';
import 'package:checklist/app/shared/database/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class CheckListDao {
  static const String _tableName = "checklist";
  static const String _checklistId = "id";
  static const String _checklistTitle = "title";

  static const String createTableSql = 'CREATE TABLE $_tableName('
      '$_checklistId TEXT PRIMARY KEY,'
      '$_checklistTitle TEXT'
      ')';

  static Future<int> getCheckListCount() async {
    Database database = await DatabaseHelper.instance;

    List results = await database.query(_tableName);

    return results.length;
  }

  Future<List<CheckList>> getAll() async {
    Database database = await DatabaseHelper.instance;

    List<Map<String, Object?>> queryResult = await database.query(_tableName);

    List<CheckList> checklists =
        queryResult.map((mapItem) => CheckList.fromJson(mapItem)).toList();

    return checklists;
  }

  Future<int> insert(CheckList checkList) async {
    Database database = await DatabaseHelper.instance;

    int insertedValues = await database.insert(_tableName, checkList.toJson());

    return insertedValues;
  }
}
