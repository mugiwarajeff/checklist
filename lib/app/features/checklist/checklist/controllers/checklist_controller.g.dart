// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checklist_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CheckListController on CheckListControllerBase, Store {
  late final _$searchTextAtom =
      Atom(name: 'CheckListControllerBase.searchText', context: context);

  @override
  String get searchText {
    _$searchTextAtom.reportRead();
    return super.searchText;
  }

  @override
  set searchText(String value) {
    _$searchTextAtom.reportWrite(value, super.searchText, () {
      super.searchText = value;
    });
  }

  late final _$checklistCategoryFilterAtom = Atom(
      name: 'CheckListControllerBase.checklistCategoryFilter',
      context: context);

  @override
  ChecklistCategory? get checklistCategoryFilter {
    _$checklistCategoryFilterAtom.reportRead();
    return super.checklistCategoryFilter;
  }

  @override
  set checklistCategoryFilter(ChecklistCategory? value) {
    _$checklistCategoryFilterAtom
        .reportWrite(value, super.checklistCategoryFilter, () {
      super.checklistCategoryFilter = value;
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

  late final _$errorCodeAtom =
      Atom(name: 'CheckListControllerBase.errorCode', context: context);

  @override
  int get errorCode {
    _$errorCodeAtom.reportRead();
    return super.errorCode;
  }

  @override
  set errorCode(int value) {
    _$errorCodeAtom.reportWrite(value, super.errorCode, () {
      super.errorCode = value;
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
  Future<void> deleteCheckList(CheckList checklistToDelete) {
    return _$deleteCheckListAsyncAction
        .run(() => super.deleteCheckList(checklistToDelete));
  }

  late final _$updateChecklistAsyncAction =
      AsyncAction('CheckListControllerBase.updateChecklist', context: context);

  @override
  Future<void> updateChecklist(CheckList checklistToUpdate) {
    return _$updateChecklistAsyncAction
        .run(() => super.updateChecklist(checklistToUpdate));
  }

  late final _$CheckListControllerBaseActionController =
      ActionController(name: 'CheckListControllerBase', context: context);

  @override
  void setChecklistCategoryFilter(ChecklistCategory? checklistCategory) {
    final _$actionInfo = _$CheckListControllerBaseActionController.startAction(
        name: 'CheckListControllerBase.setChecklistCategoryFilter');
    try {
      return super.setChecklistCategoryFilter(checklistCategory);
    } finally {
      _$CheckListControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSearchText(String searchText) {
    final _$actionInfo = _$CheckListControllerBaseActionController.startAction(
        name: 'CheckListControllerBase.setSearchText');
    try {
      return super.setSearchText(searchText);
    } finally {
      _$CheckListControllerBaseActionController.endAction(_$actionInfo);
    }
  }

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
  void setError(int newError) {
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
searchText: ${searchText},
checklistCategoryFilter: ${checklistCategoryFilter},
isLoading: ${isLoading},
errorCode: ${errorCode}
    ''';
  }
}
