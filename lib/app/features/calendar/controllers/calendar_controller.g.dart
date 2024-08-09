// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CalendarController on CalendarControllerBase, Store {
  late final _$selectedDateAtom =
      Atom(name: 'CalendarControllerBase.selectedDate', context: context);

  @override
  DateTime get selectedDate {
    _$selectedDateAtom.reportRead();
    return super.selectedDate;
  }

  @override
  set selectedDate(DateTime value) {
    _$selectedDateAtom.reportWrite(value, super.selectedDate, () {
      super.selectedDate = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'CalendarControllerBase.isLoading', context: context);

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

  late final _$codeErrorAtom =
      Atom(name: 'CalendarControllerBase.codeError', context: context);

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

  late final _$loadEventsAsyncAction =
      AsyncAction('CalendarControllerBase.loadEvents', context: context);

  @override
  Future<void> loadEvents() {
    return _$loadEventsAsyncAction.run(() => super.loadEvents());
  }

  late final _$updateItemAsyncAction =
      AsyncAction('CalendarControllerBase.updateItem', context: context);

  @override
  Future<void> updateItem(CheckListItem checkListItem) {
    return _$updateItemAsyncAction.run(() => super.updateItem(checkListItem));
  }

  late final _$deleteItemAsyncAction =
      AsyncAction('CalendarControllerBase.deleteItem', context: context);

  @override
  Future<void> deleteItem(CheckListItem checkListItem) {
    return _$deleteItemAsyncAction.run(() => super.deleteItem(checkListItem));
  }

  late final _$CalendarControllerBaseActionController =
      ActionController(name: 'CalendarControllerBase', context: context);

  @override
  void setSelectedDate(DateTime newDate) {
    final _$actionInfo = _$CalendarControllerBaseActionController.startAction(
        name: 'CalendarControllerBase.setSelectedDate');
    try {
      return super.setSelectedDate(newDate);
    } finally {
      _$CalendarControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsLoading(bool newState) {
    final _$actionInfo = _$CalendarControllerBaseActionController.startAction(
        name: 'CalendarControllerBase.setIsLoading');
    try {
      return super.setIsLoading(newState);
    } finally {
      _$CalendarControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCodeErro(int error) {
    final _$actionInfo = _$CalendarControllerBaseActionController.startAction(
        name: 'CalendarControllerBase.setCodeErro');
    try {
      return super.setCodeErro(error);
    } finally {
      _$CalendarControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedDate: ${selectedDate},
isLoading: ${isLoading},
codeError: ${codeError}
    ''';
  }
}
