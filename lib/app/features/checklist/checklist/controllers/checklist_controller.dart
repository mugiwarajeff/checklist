import 'package:checklist/app/features/checklist/checklist/dao/checklist_dao.dart';
import 'package:checklist/app/features/checklist/checklist/models/checklist.dart';
import 'package:checklist/app/shared/logs/interfaces/message_logger.dart';
import 'package:checklist/app/shared/logs/models/log_message.dart';
import 'package:mobx/mobx.dart';
import 'package:sqflite/sqflite.dart';
part 'checklist_controller.g.dart';

class CheckListController = CheckListControllerBase with _$CheckListController;

abstract class CheckListControllerBase with Store {
  final ChecklistDAO _checkListDao;
  final MessageLogger _messageLogger;

  ObservableList<CheckList> checklists = ObservableList<CheckList>();

  @observable
  bool isLoading = false;

  @observable
  int errorCode = 0; //2067

  CheckListControllerBase(
      {required ChecklistDAO checkListDao,
      required MessageLogger messagelogger})
      : _checkListDao = checkListDao,
        _messageLogger = messagelogger;

  @action
  void setIsLoading(bool newState) {
    isLoading = newState;
  }

  @action
  void setError(int newError) {
    errorCode = newError;
  }

  @action
  Future<void> loadCheckLists() async {
    setIsLoading(true);

    try {
      checklists.clear();
      List<CheckList> checklistsFromDb = await _checkListDao.getAll();
      checklists.addAll(checklistsFromDb);
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
  Future<void> addCheckList(CheckList checklist) async {
    setIsLoading(true);

    try {
      int result = await _checkListDao.insert(checklist);

      if (result != 0) {
        checklists.add(checklist);
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

  @action
  Future<void> deleteCheckList(CheckList checklistToDelete) async {
    setIsLoading(true);

    try {
      int result = await _checkListDao.deleteCheckList(checklistToDelete);

      if (result > 0) {
        checklists
            .removeWhere((checklist) => checklist.id == checklistToDelete.id);
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

  @action
  Future<void> updateChecklist(CheckList checklistToUpdate) async {
    setIsLoading(true);

    try {
      int result = await _checkListDao.updateChecklist(checklistToUpdate);

      if (result > 0) {
        int index = checklists.indexWhere(
          (element) => element.id == checklistToUpdate.id,
        );

        checklists[index] = checklistToUpdate;
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
