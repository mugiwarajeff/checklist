// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checklist_item_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChecklistItemController on ChecklistItemControllerBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'ChecklistItemControllerBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$checklistOrderAtom = Atom(
      name: 'ChecklistItemControllerBase.checklistOrder', context: context);

  @override
  ChecklistOrder get checklistOrder {
    _$checklistOrderAtom.reportRead();
    return super.checklistOrder;
  }

  @override
  set checklistOrder(ChecklistOrder value) {
    _$checklistOrderAtom.reportWrite(value, super.checklistOrder, () {
      super.checklistOrder = value;
    });
  }

  late final _$errorAtom =
      Atom(name: 'ChecklistItemControllerBase.error', context: context);

  @override
  String get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$addingNewItemAtom =
      Atom(name: 'ChecklistItemControllerBase.addingNewItem', context: context);

  @override
  bool get addingNewItem {
    _$addingNewItemAtom.reportRead();
    return super.addingNewItem;
  }

  @override
  set addingNewItem(bool value) {
    _$addingNewItemAtom.reportWrite(value, super.addingNewItem, () {
      super.addingNewItem = value;
    });
  }

  late final _$loadItensAsyncAction =
      AsyncAction('ChecklistItemControllerBase.loadItens', context: context);

  @override
  Future<void> loadItens(String checkListId) {
    return _$loadItensAsyncAction.run(() => super.loadItens(checkListId));
  }

  late final _$addItemAsyncAction =
      AsyncAction('ChecklistItemControllerBase.addItem', context: context);

  @override
  Future<void> addItem(CheckListItem checkListItem) {
    return _$addItemAsyncAction.run(() => super.addItem(checkListItem));
  }

  late final _$updateItemAsyncAction =
      AsyncAction('ChecklistItemControllerBase.updateItem', context: context);

  @override
  Future<void> updateItem(CheckListItem checkListItem) {
    return _$updateItemAsyncAction.run(() => super.updateItem(checkListItem));
  }

  late final _$deleteItemAsyncAction =
      AsyncAction('ChecklistItemControllerBase.deleteItem', context: context);

  @override
  Future<void> deleteItem(CheckListItem checkListItem) {
    return _$deleteItemAsyncAction.run(() => super.deleteItem(checkListItem));
  }

  late final _$ChecklistItemControllerBaseActionController =
      ActionController(name: 'ChecklistItemControllerBase', context: context);

  @override
  void setAddingNewItem(bool newState) {
    final _$actionInfo = _$ChecklistItemControllerBaseActionController
        .startAction(name: 'ChecklistItemControllerBase.setAddingNewItem');
    try {
      return super.setAddingNewItem(newState);
    } finally {
      _$ChecklistItemControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setChecklistOrder(ChecklistOrder newOrder) {
    final _$actionInfo = _$ChecklistItemControllerBaseActionController
        .startAction(name: 'ChecklistItemControllerBase.setChecklistOrder');
    try {
      return super.setChecklistOrder(newOrder);
    } finally {
      _$ChecklistItemControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsLoading(bool newState) {
    final _$actionInfo = _$ChecklistItemControllerBaseActionController
        .startAction(name: 'ChecklistItemControllerBase.setIsLoading');
    try {
      return super.setIsLoading(newState);
    } finally {
      _$ChecklistItemControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String newError) {
    final _$actionInfo = _$ChecklistItemControllerBaseActionController
        .startAction(name: 'ChecklistItemControllerBase.setError');
    try {
      return super.setError(newError);
    } finally {
      _$ChecklistItemControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
checklistOrder: ${checklistOrder},
error: ${error},
addingNewItem: ${addingNewItem}
    ''';
  }
}
