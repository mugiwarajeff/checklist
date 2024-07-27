import 'package:checklist/app/features/checklist/checklist/controllers/checklist_controller.dart';
import 'package:checklist/app/features/checklist/checklist/dao/checklist_dao.dart';
import 'package:checklist/app/features/checklist/checklist/models/checklist.dart';
import 'package:checklist/app/features/checklist/checklist/models/value_objects/checklist_title.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

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

  group("Test all operations of checklist controller", () {
    test("should load correctly the checklist in the database", () async {
      when(checklistDAO.getAll()).thenAnswer((_) async => checklistsTest);

      await checkListController.loadCheckLists();

      expect(
          checkListController.checklists.length, equals(checklistsTest.length));
      expect(checkListController.checklists, containsAll(checklistsTest));
    });
  });

  tearDown(() {});
}
