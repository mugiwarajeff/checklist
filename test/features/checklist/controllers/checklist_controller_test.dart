import 'package:checklist/app/features/checklist/checklist/controllers/checklist_controller.dart';
import 'package:checklist/app/features/checklist/checklist/dao/checklist_dao.dart';
import 'package:checklist/app/features/checklist/checklist/enum/checklist_category.dart';
import 'package:checklist/app/features/checklist/checklist/models/checklist.dart';
import 'package:checklist/app/features/checklist/checklist/models/value_objects/checklist_title.dart';
import 'package:checklist/app/shared/logs/interfaces/message_logger.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';

@GenerateNiceMocks([MockSpec<ChecklistDAO>(), MockSpec<MessageLogger>()])
import "checklist_controller_test.mocks.dart";

void main() {
  late ChecklistDAO checklistDAO;
  late MessageLogger messageLogger;
  late CheckListController checkListController;

  List<CheckList> checklistsTest = [
    CheckList(
        id: "1",
        title: CheckListTitle(value: "compras"),
        category: ChecklistCategory.others),
    CheckList(
        id: "2",
        title: CheckListTitle(value: "compras 2024"),
        category: ChecklistCategory.others)
  ];

  setUp(() {
    checklistDAO = MockChecklistDAO();
    messageLogger = MockMessageLogger();
    checkListController = CheckListController(
        checkListDao: checklistDAO, messagelogger: messageLogger);
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
          title: CheckListTitle(value: "Compras 2025"),
          category: ChecklistCategory.others);
      when(checklistDAO.insert(newChecklist)).thenAnswer((_) async => 1);

      await checkListController.addCheckList(newChecklist);

      expect(checkListController.checklists, contains(newChecklist));
    });

    test("should return DatabaseException on failing to insert", () async {
      CheckList newChecklist = CheckList(
          id: "3",
          title: CheckListTitle(value: "Compras 2025"),
          category: ChecklistCategory.others);
      when(checklistDAO.insert(newChecklist)).thenThrow(DatabaseException);

      expect(checkListController.addCheckList(newChecklist),
          throwsA(DatabaseException));
    });
  });

  group("Test remove checklist methods", () {
    test("Should remove a checklist", () async {
      CheckList checkList = CheckList(
          id: "1",
          title: CheckListTitle(value: "compras"),
          category: ChecklistCategory.others);

      when(checklistDAO.deleteCheckList(checkList)).thenAnswer((_) async => 1);

      await checkListController.deleteCheckList(checkList);

      expect(!checkListController.checklists.contains(checkList), isTrue);
    });
  });

  tearDown(() {});
}
