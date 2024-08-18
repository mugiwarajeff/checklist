import 'package:checklist/app/features/category_management/dao/interface/category_dao.dart';
import 'package:checklist/app/features/category_management/models/category.dart';
import 'package:checklist/app/shared/database/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class CategoryDaoSqflite implements CategoryDao {
  static const String _tableName = "categories";
  static const String _name = "name";
  static const String _description = "description";
  static const String _visible = "visible";
  static const String _color = "color";

  static const String createTableSql = 'CREATE TABLE $_tableName('
      '$_name TEXT PRIMARY KEY,'
      '$_description TEXT,'
      '$_visible INTEGER,'
      '$_color INTEGER,'
      ')';

  static const String insertDefaultCategoriesSql = """
  INSERT INTO $_tableName($_name, $_description, $_visible, $_color)
  VALUES ('shopping', '', 1, 4280391411),
  VALUES ('market', '', 1, 4280391411),
  VALUES ('house', '', 1, 4280391411),
  VALUES ('work', '', 1, 4280391411),
  VALUES ('study', '', 1, 4280391411),
   VALUES ('others', '', 1, 4280391411)
""";
  @override
  Future<List<Category>> getAll() async {
    Database database = await DatabaseHelper.instance;

    List<Map<String, dynamic>> queryResult = await database.query(_tableName);

    List<Category> categories =
        queryResult.map((catJson) => Category.fromJson(catJson)).toList();

    return categories;
  }

  @override
  Future<int> deleteCategory(Category category) async {
    Database database = await DatabaseHelper.instance;

    int result = await database
        .delete(_tableName, where: "$_name = ?", whereArgs: [category.name]);

    return result;
  }

  @override
  Future<int> insertCategory(Category category) async {
    Database database = await DatabaseHelper.instance;

    int result = await database.insert(_tableName, category.toJson());

    return result;
  }

  @override
  Future<int> updateCategory(Category category) async {
    Database database = await DatabaseHelper.instance;

    int result = await database.update(_tableName, category.toJson(),
        where: "$_name = ?", whereArgs: [category.name]);

    return result;
  }
}
