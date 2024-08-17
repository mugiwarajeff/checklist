import 'package:checklist/app/features/category_management/dao/interface/category_dao.dart';
import 'package:flutter/src/foundation/annotations.dart';

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

  @override
  Future<int> deleteCategory(Category category) {
    // TODO: implement deleteCategory
    throw UnimplementedError();
  }

  @override
  Future<List<Category>> getAll() {
    // TODO: implement insertCategory
    throw UnimplementedError();
  }

  @override
  Future<int> insertCategory(Category category) {
    // TODO: implement insertCategory
    throw UnimplementedError();
  }

  @override
  Future<int> updateCategory(Category category) {
    // TODO: implement updateCategory
    throw UnimplementedError();
  }
}
