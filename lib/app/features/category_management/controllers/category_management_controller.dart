import 'package:checklist/app/features/category_management/dao/interface/category_dao.dart';
import 'package:checklist/app/features/category_management/models/category.dart';
import 'package:checklist/app/shared/logs/interfaces/message_logger.dart';
import 'package:checklist/app/shared/logs/models/log_message.dart';
import 'package:mobx/mobx.dart';
import 'package:sqflite/sqflite.dart';
part 'category_management_controller.g.dart';

class CategoryManagementController = CategoryManagementControllerBase
    with _$CategoryManagementController;

abstract class CategoryManagementControllerBase with Store {
  final CategoryDao _categoryDao;
  final MessageLogger _messageLogger;

  @observable
  bool isLoading = false;

  @observable
  int codeError = 0;

  ObservableList<Category> categories = ObservableList<Category>();

  CategoryManagementControllerBase(
      {required CategoryDao categoryDao, required MessageLogger messageLogger})
      : _categoryDao = categoryDao,
        _messageLogger = messageLogger;

  @action
  void setIsLoading(bool newState) {
    isLoading = newState;
  }

  @action
  void setCodeError(int newError) {
    codeError = newError;
  }

  @action
  Future<void> loadCategories() async {
    setIsLoading(true);
    try {
      List<Category> categoriesFromDB = await _categoryDao.getAll();

      categories.clear();
      categories.addAll(categoriesFromDB);

      print(categoriesFromDB.length);
    } on DatabaseException catch (error) {
      setCodeError(error.getResultCode() ?? 0);

      _messageLogger.writeMessage(LogMessage(
          category: "error",
          eventTime: DateTime.now(),
          message: error.toString(),
          user: "system"));
    }

    setIsLoading(false);
  }

  @action
  Future<void> updateCategory(Category category) async {
    setIsLoading(true);
    try {
      await _categoryDao.updateCategory(category);
    } on DatabaseException catch (error) {
      setCodeError(error.getResultCode() ?? 0);

      _messageLogger.writeMessage(LogMessage(
          category: "error",
          eventTime: DateTime.now(),
          message: error.toString(),
          user: "system"));
    }

    setIsLoading(false);
  }

  @action
  Future<void> deleteCategory(Category category) async {
    setIsLoading(true);
    try {
      int result = await _categoryDao.deleteCategory(category);

      if (result != 0) {
        categories.remove(category);
      }
    } on DatabaseException catch (error) {
      setCodeError(error.getResultCode() ?? 0);

      _messageLogger.writeMessage(LogMessage(
          category: "error",
          eventTime: DateTime.now(),
          message: error.toString(),
          user: "system"));
    }

    setIsLoading(false);
  }

  @action
  Future<void> addNewCategory(Category category) async {
    setIsLoading(true);
    try {
      int result = await _categoryDao.insertCategory(category);

      if (result != 0) {
        categories.add(category);
      }
    } on DatabaseException catch (error) {
      setCodeError(error.getResultCode() ?? 0);

      _messageLogger.writeMessage(LogMessage(
          category: "error",
          eventTime: DateTime.now(),
          message: error.toString(),
          user: "system"));
    }

    setIsLoading(false);
  }
}
