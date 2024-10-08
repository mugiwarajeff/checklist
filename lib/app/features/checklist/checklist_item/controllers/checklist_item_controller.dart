import 'package:checklist/app/features/checklist/checklist_item/dao/checklist_item_dao.dart';
import 'package:checklist/app/features/checklist/checklist_item/enum/checklist_order.dart';
import 'package:checklist/app/features/checklist/checklist_item/models/checklist_item.dart';
import 'package:checklist/app/shared/cache_store/interface/cache_store.dart';

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
  final CacheStore _cacheStore;

  ObservableList<CheckListItem> checklistItems =
      ObservableList<CheckListItem>();

  @observable
  bool isLoading = false;

  @observable
  ChecklistOrder checklistOrder = ChecklistOrder.creation;

  @observable
  int errorCode = 0;

  @observable
  bool addingNewItem = false;

  ChecklistItemControllerBase(
      {required ChecklistItemDAO checkListItem,
      required MessageLogger messageLogger,
      required CacheStore cacheStore})
      : _checklistItemDAO = checkListItem,
        _messageLogger = messageLogger,
        _cacheStore = cacheStore {
    _loadChecklistOrder();
  }

  Future<void> _loadChecklistOrder() async {
    ChecklistOrder? checklistOrder = await _cacheStore.getLastChecklistOrder();

    if (checklistOrder == null) {
      return;
    }

    this.checklistOrder = checklistOrder;
  }

  @action
  void setAddingNewItem(bool newState) {
    addingNewItem = newState;
  }

  @action
  void setChecklistOrder(ChecklistOrder newOrder) {
    checklistOrder = newOrder;
    _cacheStore.saveLastChecklistOrder(checklistOrder);
  }

  @action
  void setIsLoading(bool newState) {
    isLoading = newState;
  }

  @action
  void setError(int newError) {
    errorCode = newError;
  }

  @action
  Future<void> loadItens(int checkListId) async {
    setIsLoading(true);

    try {
      checklistItems.clear();

      List<CheckListItem> itemsFromDb =
          await _checklistItemDAO.getAll(checkListId, checklistOrder);

      checklistItems.addAll(itemsFromDb);
    } on DatabaseException catch (e) {
      setError(e.getResultCode() ?? 0);
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
    } on DatabaseException catch (e) {
      setError(e.getResultCode() ?? 0);
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
    } on DatabaseException catch (e) {
      int? errorCode = e.getResultCode();
      print(errorCode);

      setError(errorCode ?? 0);
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
    } on DatabaseException catch (e) {
      setError(e.getResultCode() ?? 0);
      await _messageLogger.writeMessage(LogMessage(
          category: "Error",
          eventTime: DateTime.now(),
          message: e.toString(),
          user: "system"));
    }

    setIsLoading(false);
  }
}
