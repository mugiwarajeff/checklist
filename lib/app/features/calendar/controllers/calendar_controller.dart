import 'package:checklist/app/features/checklist/checklist_item/dao/checklist_item_dao.dart';
import 'package:checklist/app/features/checklist/checklist_item/models/checklist_item.dart';
import 'package:checklist/app/shared/logs/interfaces/message_logger.dart';
import 'package:checklist/app/shared/logs/models/log_message.dart';

import 'package:mobx/mobx.dart';
import 'package:sqflite/sqflite.dart';

part 'calendar_controller.g.dart';

class CalendarController = CalendarControllerBase with _$CalendarController;

abstract class CalendarControllerBase with Store {
  final ChecklistItemDAO _checklistItemDAO;
  final MessageLogger _messageLogger;

  CalendarControllerBase(
      {required ChecklistItemDAO checklistItemDAO,
      required MessageLogger messageLogger})
      : _checklistItemDAO = checklistItemDAO,
        _messageLogger = messageLogger;

  @observable
  DateTime selectedDate = DateTime.now();

  @observable
  bool isLoading = false;

  @observable
  int codeError = 0;

  ObservableList<CheckListItem> checklistItems = ObservableList();

  @action
  void setSelectedDate(DateTime newDate) {
    print(newDate);
    selectedDate = newDate;
  }

  @action
  void setIsLoading(bool newState) {
    isLoading = newState;
  }

  @action
  void setCodeErro(int error) {
    codeError = error;
  }

  @action
  Future<void> loadEvents() async {
    setIsLoading(true);
    try {
      checklistItems.clear();
      List<CheckListItem> eventsFromDb =
          await _checklistItemDAO.getItensWithDueDate();

      checklistItems.addAll(eventsFromDb);
    } on DatabaseException catch (e) {
      setCodeErro(e.getResultCode() ?? 0);

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

      setCodeErro(errorCode ?? 0);
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
      setCodeErro(e.getResultCode() ?? 0);
      await _messageLogger.writeMessage(LogMessage(
          category: "Error",
          eventTime: DateTime.now(),
          message: e.toString(),
          user: "system"));
    }

    setIsLoading(false);
  }
}
