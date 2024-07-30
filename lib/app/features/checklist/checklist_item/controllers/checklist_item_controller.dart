import 'package:checklist/app/features/checklist/checklist_item/dao/checklist_item_dao.dart';
import 'package:checklist/app/features/checklist/checklist_item/models/checklist_item.dart';
import 'package:checklist/app/shared/exceptions/create_item_exception.dart';
import 'package:checklist/app/shared/logs/interfaces/message_logger.dart';
import 'package:checklist/app/shared/logs/models/log_message.dart';
import 'package:mobx/mobx.dart';
import 'package:sqflite/sqflite.dart';
part 'checklist_item_controller.g.dart';

class ChecklistItemController = ChecklistItemControllerBase
    with _$ChecklistItemController;

abstract class ChecklistItemControllerBase with Store {
  final ChecklistItemDAO _checklistItemDAO;
  final MessageLogger _messageLogger;

  ObservableList<CheckListItem> checklistItems =
      ObservableList<CheckListItem>();

  @observable
  bool isLoading = false;

  @observable
  String error = "";

  @observable
  bool addingNewItem = false;

  ChecklistItemControllerBase(
      {required ChecklistItemDAO checkListItem,
      required MessageLogger messageLogger})
      : _checklistItemDAO = checkListItem,
        _messageLogger = messageLogger;

  @action
  void setAddingNewItem(bool newState) {
    addingNewItem = newState;
  }

  @action
  void setIsLoading(bool newState) {
    isLoading = newState;
  }

  @action
  void setError(String newError) {
    error = newError;
  }

  @action
  Future<void> loadItens(String checkListId) async {
    setIsLoading(true);

    try {
      checklistItems.clear();
      List<CheckListItem> itemsFromDb =
          await _checklistItemDAO.getAll(checkListId);

      checklistItems.addAll(itemsFromDb);
    } on DatabaseException catch (e) {
      setError(e.toString());
      await _messageLogger.writeMessage(LogMessage(
          category: "Error",
          eventTime: DateTime.now(),
          message: e.toString(),
          user: "system"));
    }

    setIsLoading(false);
  }

  @action
  Future<void> addItem(CheckListItem checkListItem) async {
    setIsLoading(true);

    try {
      await _checklistItemDAO.insertItem(checkListItem);
      checklistItems.add(checkListItem);

      setAddingNewItem(false);
    } on CreateItemException catch (e) {
      setError(e.toString());
      await _messageLogger.writeMessage(LogMessage(
          category: "Error",
          eventTime: DateTime.now(),
          message: e.toString(),
          user: "system"));
    }

    setIsLoading(false);
  }

  @action
  Future<void> updateItem(CheckListItem checkListItem) async {
    setIsLoading(true);

    try {
      await _checklistItemDAO.updateItem(checkListItem);
    } on CreateItemException catch (e) {
      setError(e.toString());
      await _messageLogger.writeMessage(LogMessage(
          category: "Error",
          eventTime: DateTime.now(),
          message: e.toString(),
          user: "system"));
    }

    setIsLoading(false);
  }

  @action
  Future<void> deleteItem(CheckListItem checkListItem) async {
    setIsLoading(true);

    try {
      int result = await _checklistItemDAO.deleteItem(checkListItem);

      if (result == 1) {
        checklistItems.remove(checkListItem);
      }
    } on CreateItemException catch (e) {
      setError(e.toString());
      await _messageLogger.writeMessage(LogMessage(
          category: "Error",
          eventTime: DateTime.now(),
          message: e.toString(),
          user: "system"));
    }

    setIsLoading(false);
  }
}
