// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_management_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CategoryManagementController
    on CategoryManagementControllerBase, Store {
  late final _$isLoadingAtom = Atom(
      name: 'CategoryManagementControllerBase.isLoading', context: context);

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

  late final _$codeErrorAtom = Atom(
      name: 'CategoryManagementControllerBase.codeError', context: context);

  @override
  int get codeError {
    _$codeErrorAtom.reportRead();
    return super.codeError;
  }

  @override
  set codeError(int value) {
    _$codeErrorAtom.reportWrite(value, super.codeError, () {
      super.codeError = value;
    });
  }

  late final _$loadCategoriesAsyncAction = AsyncAction(
      'CategoryManagementControllerBase.loadCategories',
      context: context);

  @override
  Future<void> loadCategories() {
    return _$loadCategoriesAsyncAction.run(() => super.loadCategories());
  }

  late final _$updateCategoryAsyncAction = AsyncAction(
      'CategoryManagementControllerBase.updateCategory',
      context: context);

  @override
  Future<void> updateCategory(Category category) {
    return _$updateCategoryAsyncAction
        .run(() => super.updateCategory(category));
  }

  late final _$deleteCategoryAsyncAction = AsyncAction(
      'CategoryManagementControllerBase.deleteCategory',
      context: context);

  @override
  Future<void> deleteCategory(Category category) {
    return _$deleteCategoryAsyncAction
        .run(() => super.deleteCategory(category));
  }

  late final _$addNewCategoryAsyncAction = AsyncAction(
      'CategoryManagementControllerBase.addNewCategory',
      context: context);

  @override
  Future<void> addNewCategory(Category category) {
    return _$addNewCategoryAsyncAction
        .run(() => super.addNewCategory(category));
  }

  late final _$CategoryManagementControllerBaseActionController =
      ActionController(
          name: 'CategoryManagementControllerBase', context: context);

  @override
  void setIsLoading(bool newState) {
    final _$actionInfo = _$CategoryManagementControllerBaseActionController
        .startAction(name: 'CategoryManagementControllerBase.setIsLoading');
    try {
      return super.setIsLoading(newState);
    } finally {
      _$CategoryManagementControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setCodeError(int newError) {
    final _$actionInfo = _$CategoryManagementControllerBaseActionController
        .startAction(name: 'CategoryManagementControllerBase.setCodeError');
    try {
      return super.setCodeError(newError);
    } finally {
      _$CategoryManagementControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
codeError: ${codeError}
    ''';
  }
}
