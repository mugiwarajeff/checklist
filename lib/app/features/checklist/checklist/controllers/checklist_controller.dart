import 'package:checklist/app/features/checklist/checklist/controllers/interfaces/checklist_store.dart';
import 'package:checklist/app/features/checklist/checklist/dao/checklist_dao.dart';
import 'package:checklist/app/features/checklist/checklist/models/checklist.dart';
import 'package:mobx/mobx.dart';
import 'package:sqflite/sqflite.dart';
part 'checklist_controller.g.dart';

class CheckListController = CheckListControllerBase with _$CheckListController;

abstract class CheckListControllerBase with Store implements CheckListStore {
  final ChecklistDAO _checkListDao;

  @override
  ObservableList<CheckList> checklists = ObservableList<CheckList>();

  @override
  @observable
  bool isLoading = false;

  @override
  @observable
  String error = "";

  CheckListControllerBase({required ChecklistDAO checkListDao})
      : _checkListDao = checkListDao;

  @action
  void setIsLoading(bool newState) {
    isLoading = newState;
  }

  @action
  void setError(String newError) {
    error = newError;
  }

  @override
  @action
  Future<void> loadCheckLists() async {
    setIsLoading(true);

    try {
      checklists.clear();
      List<CheckList> checklistsFromDb = await _checkListDao.getAll();
      checklists.addAll(checklistsFromDb);
    } on DatabaseException catch (e) {
      error = e.toString();

      //TODO fazer camada de log de erros
    }

    setIsLoading(false);
  }

  @override
  @action
  Future<void> addCheckList(CheckList checklist) async {
    setIsLoading(true);

    try {
      int result = await _checkListDao.insert(checklist);

      if (result != 0) {
        checklists.add(checklist);
      }
    } on DatabaseException catch (e) {
      error = e.toString();

      //TODO fazer camada de log de erros
    }

    setIsLoading(false);
  }
}
