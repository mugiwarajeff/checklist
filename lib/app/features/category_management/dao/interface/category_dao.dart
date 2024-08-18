import 'package:checklist/app/features/category_management/models/category.dart';

abstract class CategoryDao {
  Future<int> insertCategory(Category category);

  Future<int> updateCategory(Category category);

  Future<List<Category>> getAll();

  Future<int> deleteCategory(Category category);
}
