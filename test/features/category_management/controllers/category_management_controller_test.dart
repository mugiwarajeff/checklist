import 'package:checklist/app/features/category_management/controllers/category_management_controller.dart';
import 'package:checklist/app/features/category_management/dao/interface/category_dao.dart';
import 'package:checklist/app/features/category_management/models/category.dart';
import 'package:checklist/app/shared/logs/interfaces/message_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'category_management_controller_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CategoryDao>(), MockSpec<MessageLogger>()])
void main() {
  late CategoryDao categoryDao;
  late MessageLogger messageLogger;
  late CategoryManagementController categoryManagementController;

  List<Category> categoriesForTesting = [
    Category(
        color: Colors.blue, description: "", name: "category 1", visible: true),
    Category(
        color: Colors.blue, description: "", name: "category 2", visible: true),
    Category(
        color: Colors.blue, description: "", name: "category 3", visible: true)
  ];
  setUp(() {
    categoryDao = MockCategoryDao();
    messageLogger = MockMessageLogger();
    categoryManagementController = CategoryManagementController(
        categoryDao: categoryDao, messageLogger: messageLogger);

    when((categoryDao as MockCategoryDao).insertCategory(any))
        .thenAnswer((_) async => 1);

    when((categoryDao as MockCategoryDao).deleteCategory(any))
        .thenAnswer((realInvocation) async => 1);

    when((categoryDao as MockCategoryDao).updateCategory(any))
        .thenAnswer((realInvocation) async => 1);

    when((categoryDao as MockCategoryDao).getAll())
        .thenAnswer((realInvocation) async => categoriesForTesting);
  });

  group("get category features", () {
    test("Shoud obtaing all categories", () async {
      await categoryManagementController.loadCategories();

      verify(categoryDao.getAll()).called(1);

      expect(categoryManagementController.categories.length, equals(3));

      expect(categoryManagementController.categories,
          containsAll(categoriesForTesting));
    });
  });
  group("Add category features", () {
    test("Should add a new category", () async {
      Category newCategory = Category(
          color: Colors.blue,
          description: "",
          name: "category4",
          visible: true);

      await categoryManagementController.addNewCategory(newCategory);

      verify(categoryDao.insertCategory(newCategory));

      expect(categoryManagementController.categories, contains(newCategory));

      expect(categoryManagementController.categories.length, equals(1));
    });
  });
  group("Update category features", () {
    test("Should update the category tested", () async {
      String newCategoryName = "editedname";
      await categoryManagementController.loadCategories();

      Category category3 = categoryManagementController.categories.last;

      category3.name = newCategoryName;

      await categoryManagementController.updateCategory(category3);

      verify(categoryDao.updateCategory(category3)).called(1);

      expect(category3.name, equals(newCategoryName));

      expect(categoryManagementController.categories.length, equals(3));
    });
  });

  group("Delete category features", () {
    test("should delete a category", () async {
      await categoryManagementController.loadCategories();

      Category category3 = categoryManagementController.categories.last;

      await categoryManagementController.deleteCategory(category3);

      verify(categoryDao.deleteCategory(category3)).called(1);

      expect(
          !categoryManagementController.categories.contains(category3), isTrue);
      expect(categoryManagementController.categories.length, equals(2));
    });
  });

  tearDown(() {});
}
