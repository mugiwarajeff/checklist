import 'dart:io';

import 'package:checklist/app/features/checklist/checklist_item/controllers/checklist_item_controller.dart';
import 'package:checklist/app/features/checklist/checklist_item/dao/checklist_item_dao.dart';
import 'package:checklist/app/features/checklist/checklist_item/models/checklist_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<ChecklistItemDAO>()])
import 'checklist_controller_test.mocks.dart';

void main() {
  List<CheckListItem> itemsForTesting = [
    CheckListItem(
        checked: false, checklistId: "1", description: "teste", title: "Cafe"),
    CheckListItem(
        checked: false, checklistId: "1", description: "teste2", title: "arroz")
  ];
  late ChecklistItemDAO checklistItemDAO;
  late ChecklistItemController checklistItemController;

  setUp(() {
    checklistItemDAO = MockChecklistItemDAO();
    checklistItemController =
        ChecklistItemController(checkListItem: checklistItemDAO);
  });

  group("Test loadItens", () {
    test("Should load all itens of a checklist", () async {
      String checkListId = "1";

      when(checklistItemDAO.getAll(checkListId))
          .thenAnswer((_) async => itemsForTesting);

      await checklistItemController.loadItens(checkListId);

      expect(
          checklistItemController.checklistItems, containsAll(itemsForTesting));
      expect(checklistItemController.checklistItems.length,
          equals(itemsForTesting.length));
    });

    test("Should generate a error when loading itens", () async {
      String checkListId = "1";

      when(checklistItemDAO.getAll(checkListId)).thenThrow(HttpException);

      expect(checklistItemController.loadItens(checkListId),
          throwsA(HttpException));
    });

    group("Add Item method", () {
      test("Should add a new item", () async {
        CheckListItem newItem = CheckListItem.empty();

        when(checklistItemDAO.insertItem(newItem)).thenAnswer((_) async => 1);

        await checklistItemController.addItem(newItem);
        verify(checklistItemDAO.insertItem(newItem)).called(1);

        expect(checklistItemController.checklistItems, contains(newItem));
      });
    });
  });

  group("updateItem method", () {
    test("Should update an item", () async {
      CheckListItem checkListItem = CheckListItem(
          checked: false,
          checklistId: "3",
          description: "Teste2",
          title: "Olá");

      when(checklistItemDAO.updateItem(checkListItem))
          .thenAnswer((_) async => 1);

      await checklistItemController.updateItem(checkListItem);

      verify(checklistItemDAO.updateItem(checkListItem)).called(1);
    });
  });

  group("deleteItem Method", () {
    test("Should delete the item", () async {
      CheckListItem checkListItemToDelete = CheckListItem(
          checked: false,
          checklistId: "1",
          description: "teste2",
          title: "arroz");

      when(checklistItemDAO.deleteItem(checkListItemToDelete))
          .thenAnswer((_) async => 1);

      await checklistItemController.deleteItem(checkListItemToDelete);

      verify(checklistItemDAO.deleteItem(checkListItemToDelete)).called(1);

      expect(checklistItemController.checklistItems,
          contains(checkListItemToDelete));
    });
  });

  tearDown(() {});
}
