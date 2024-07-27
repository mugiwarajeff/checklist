import 'package:checklist/app/features/checklist/checklist/controllers/checklist_controller.dart';
import 'package:checklist/app/features/checklist/checklist/dao/checklist_dao.dart';
import 'package:checklist/app/features/checklist/checklist/models/checklist.dart';
import 'package:checklist/app/features/checklist/checklist/models/value_objects/checklist_title.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';

@GenerateNiceMocks([MockSpec<ChecklistDAO>()])
import "checklist_controller_test.mocks.dart";

void main() {
  late ChecklistDAO checklistDAO;
  late CheckListController checkListController;

  List<CheckList> checklistsTest = [
    CheckList(
        id: "1", checkListItens: [], title: CheckListTitle(value: "compras")),
    CheckList(
        id: "2",
        checkListItens: [],
        title: CheckListTitle(value: "compras 2024"))
  ];

  setUp(() {
    checklistDAO = MockChecklistDAO();
    checkListController = CheckListController(checkListDao: checklistDAO);
  });

  group("Test loading operations", () {
    test("should load correctly the checklist in the database", () async {
      when(checklistDAO.getAll()).thenAnswer((_) async => checklistsTest);

      await checkListController.loadCheckLists();

      expect(
          checkListController.checklists.length, equals(checklistsTest.length));
      expect(checkListController.checklists, containsAll(checklistsTest));
    });

    test("should update a error when getting DatabaseException", () async {
      when(checklistDAO.getAll()).thenThrow(DatabaseException);

      expect(checkListController.loadCheckLists(), throwsA(DatabaseException));

      expect(checkListController.error, equals(""));
    });
  });

  group("Test adding checklist methods", () {
    test("Should add a new checklist item", () async {
      CheckList newChecklist = CheckList(
          id: "3",
          checkListItens: [],
          title: CheckListTitle(value: "Compras 2025"));
      when(checklistDAO.insert(newChecklist)).thenAnswer((_) async => 1);

      await checkListController.addCheckList(newChecklist);

      expect(checkListController.checklists, contains(newChecklist));
    });

    test("should return DatabaseException on failing to insert", () async {
      CheckList newChecklist = CheckList(
          id: "3",
          checkListItens: [],
          title: CheckListTitle(value: "Compras 2025"));
      when(checklistDAO.insert(newChecklist)).thenThrow(DatabaseException);

      expect(checkListController.addCheckList(newChecklist),
          throwsA(DatabaseException));
    });
  });

  tearDown(() {});
}
