import 'package:checklist/app/features/checklist/checklist/dao/checklist_dao.dart';
import 'package:checklist/app/features/checklist/checklist/models/checklist.dart';
import 'package:checklist/app/shared/database/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class CheckListDaoSqFlite implements ChecklistDAO {
  static const String _tableName = "checklist";
  static const String _checklistId = "id";
  static const String _checklistTitle = "title";
  static const String _category = "category";

  static const String createTableSql = 'CREATE TABLE $_tableName('
      '$_checklistId INTEGER PRIMARY KEY,'
      '$_checklistTitle TEXT UNIQUE,'
      '$_category TEXT'
      ')';

  @override
  Future<int> getCheckListCount() async {
    Database database = await DatabaseHelper.instance;

    List results = await database.query(_tableName);

    return results.length;
  }

  @override
  Future<List<CheckList>> getAll() async {
    Database database = await DatabaseHelper.instance;

    List<Map<String, Object?>> queryResult = await database.query(_tableName);

    List<CheckList> checklists =
        queryResult.map((mapItem) => CheckList.fromJson(mapItem)).toList();

    return checklists;
  }

  @override
  Future<int> insert(CheckList checkList) async {
    Database database = await DatabaseHelper.instance;

    int insertedValues = await database.insert(_tableName, checkList.toJson());

    return insertedValues;
  }

  @override
  Future<int> deleteCheckList(CheckList checklist) async {
    Database database = await DatabaseHelper.instance;

    int count = await database.delete(_tableName,
        where: "$_checklistId = ?", whereArgs: [checklist.id]);

    return count;
  }

  @override
  Future<int> updateChecklist(CheckList checklist) async {
    Database database = await DatabaseHelper.instance;

    int result = await database.update(_tableName, checklist.toJson(),
        where: "$_checklistId = ?", whereArgs: [checklist.id]);

    return result;
  }
}
