import 'package:flutter/foundation.dart';

abstract class CategoryDao {
  Future<int> insertCategory(Category category);

  Future<int> updateCategory(Category category);

  Future<List<Category>> getAll();

  Future<int> deleteCategory(Category category);
}
