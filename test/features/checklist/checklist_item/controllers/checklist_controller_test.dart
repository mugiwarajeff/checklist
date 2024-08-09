import 'dart:io';

import 'package:checklist/app/features/checklist/checklist_item/controllers/checklist_item_controller.dart';
import 'package:checklist/app/features/checklist/checklist_item/dao/checklist_item_dao.dart';
import 'package:checklist/app/features/checklist/checklist_item/enum/checklist_order.dart';
import 'package:checklist/app/features/checklist/checklist_item/models/checklist_item.dart';
import 'package:checklist/app/features/checklist/checklist_item/models/value_objects/checklist_title.dart';
import 'package:checklist/app/shared/cache_store/interface/cache_store.dart';
import 'package:checklist/app/shared/logs/interfaces/message_logger.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';

@GenerateNiceMocks([
  MockSpec<ChecklistItemDAO>(),
  MockSpec<MessageLogger>(),
  MockSpec<CacheStore>()
])
import 'checklist_controller_test.mocks.dart';

void main() {
  List<CheckListItem> itemsForTesting = [
    CheckListItem(
        checklistItemId: 1,
        checked: false,
        checklistId: "1",
        description: "teste",
        title: ChecklistItemTitle(value: "Cafe"),
        dueDate: null,
        createDate: DateTime.now()),
    CheckListItem(
        checklistItemId: 2,
        checked: false,
        checklistId: "1",
        description: "teste2",
        title: ChecklistItemTitle(value: "arroz"),
        dueDate: null,
        createDate: DateTime.now())
  ];
  late ChecklistItemDAO checklistItemDAO;
  late ChecklistItemController checklistItemController;
  late MessageLogger messageLogger;
  late CacheStore cacheStore;
  setUp(() {
    checklistItemDAO = MockChecklistItemDAO();
    messageLogger = MockMessageLogger();
    cacheStore = MockCacheStore();
    checklistItemController = ChecklistItemController(
        checkListItem: checklistItemDAO,
        messageLogger: messageLogger,
        cacheStore: cacheStore);
  });

  group("Test loadItens", () {
    test("Should load all itens of a checklist", () async {
      String checkListId = "1";

      when(checklistItemDAO.getAll(checkListId, ChecklistOrder.creation))
          .thenAnswer((_) async => itemsForTesting);

      await checklistItemController.loadItens(checkListId);

      expect(
          checklistItemController.checklistItems, containsAll(itemsForTesting));
      expect(checklistItemController.checklistItems.length,
          equals(itemsForTesting.length));
    });

    test("Should generate a error when loading itens", () async {
      String checkListId = "1";

      when(checklistItemDAO.getAll(checkListId, ChecklistOrder.creation))
          .thenThrow(HttpException);

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
          checklistItemId: 1,
          checked: false,
          checklistId: "3",
          description: "Teste2",
          title: ChecklistItemTitle(value: "olá"),
          dueDate: null,
          createDate: DateTime.now());

      when(checklistItemDAO.updateItem(checkListItem))
          .thenAnswer((_) async => 1);

      await checklistItemController.updateItem(checkListItem);

      verify(checklistItemDAO.updateItem(checkListItem)).called(1);
    });

    test("Should catch the erroCode when failed to update item", () async {
      CheckListItem checkListItem = CheckListItem(
          checklistItemId: 1,
          checked: false,
          checklistId: "3",
          description: "Teste2",
          title: ChecklistItemTitle(value: "olá"),
          dueDate: null,
          createDate: DateTime.now());

      when(checklistItemDAO.updateItem(checkListItem))
          .thenThrow(DatabaseException);

      //await checklistItemController.updateItem(checkListItem);

      expect(checklistItemController.updateItem(checkListItem),
          throwsA(DatabaseException));
    });
  });

  group("deleteItem Method", () {
    test("Should delete the item", () async {
      CheckListItem checkListItemToDelete = CheckListItem(
          checklistItemId: 1,
          checked: false,
          checklistId: "1",
          description: "teste2",
          title: ChecklistItemTitle(value: "arroz"),
          dueDate: null,
          createDate: DateTime.now());

      when(checklistItemDAO.deleteItem(checkListItemToDelete))
          .thenAnswer((_) async => 1);

      await checklistItemController.deleteItem(checkListItemToDelete);

      verify(checklistItemDAO.deleteItem(checkListItemToDelete)).called(1);

      expect(
          checklistItemController.checklistItems
              .contains(checkListItemToDelete),
          isFalse);
    });
  });

  tearDown(() {});
}
