// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checklist_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CheckListController on CheckListControllerBase, Store {
  late final _$checklistsAtom =
      Atom(name: 'CheckListControllerBase.checklists', context: context);

  @override
  ObservableList<CheckList> get checklists {
    _$checklistsAtom.reportRead();
    return super.checklists;
  }

  @override
  set checklists(ObservableList<CheckList> value) {
    _$checklistsAtom.reportWrite(value, super.checklists, () {
      super.checklists = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'CheckListControllerBase.isLoading', context: context);

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

  late final _$errorAtom =
      Atom(name: 'CheckListControllerBase.error', context: context);

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

  late final _$loadCheckListsAsyncAction =
      AsyncAction('CheckListControllerBase.loadCheckLists', context: context);

  @override
  Future<void> loadCheckLists() {
    return _$loadCheckListsAsyncAction.run(() => super.loadCheckLists());
  }

  late final _$addCheckListAsyncAction =
      AsyncAction('CheckListControllerBase.addCheckList', context: context);

  @override
  Future<void> addCheckList(CheckList checklist) {
    return _$addCheckListAsyncAction.run(() => super.addCheckList(checklist));
  }

  late final _$deleteCheckListAsyncAction =
      AsyncAction('CheckListControllerBase.deleteCheckList', context: context);

  @override
  Future<void> deleteCheckList(CheckList checklist) {
    return _$deleteCheckListAsyncAction
        .run(() => super.deleteCheckList(checklist));
  }

  late final _$CheckListControllerBaseActionController =
      ActionController(name: 'CheckListControllerBase', context: context);

  @override
  void setIsLoading(bool newState) {
    final _$actionInfo = _$CheckListControllerBaseActionController.startAction(
        name: 'CheckListControllerBase.setIsLoading');
    try {
      return super.setIsLoading(newState);
    } finally {
      _$CheckListControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String newError) {
    final _$actionInfo = _$CheckListControllerBaseActionController.startAction(
        name: 'CheckListControllerBase.setError');
    try {
      return super.setError(newError);
    } finally {
      _$CheckListControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
checklists: ${checklists},
isLoading: ${isLoading},
error: ${error}
    ''';
  }
}
