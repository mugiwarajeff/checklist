// Mocks generated by Mockito 5.4.4 from annotations
// in checklist/test/features/checklist/checklist_item/controllers/checklist_controller_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:checklist/app/features/checklist/checklist_item/dao/checklist_item_dao.dart'
    as _i2;
import 'package:checklist/app/features/checklist/checklist_item/enum/checklist_order.dart'
    as _i5;
import 'package:checklist/app/features/checklist/checklist_item/models/checklist_item.dart'
    as _i4;
import 'package:checklist/app/shared/cache_store/interface/cache_store.dart'
    as _i8;
import 'package:checklist/app/shared/logs/interfaces/message_logger.dart'
    as _i6;
import 'package:checklist/app/shared/logs/models/log_message.dart' as _i7;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [ChecklistItemDAO].
///
/// See the documentation for Mockito's code generation for more information.
class MockChecklistItemDAO extends _i1.Mock implements _i2.ChecklistItemDAO {
  @override
  _i3.Future<int> insertItem(_i4.CheckListItem? checkListItem) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertItem,
          [checkListItem],
        ),
        returnValue: _i3.Future<int>.value(0),
        returnValueForMissingStub: _i3.Future<int>.value(0),
      ) as _i3.Future<int>);

  @override
  _i3.Future<List<_i4.CheckListItem>> getAll(
    int? checklistId,
    _i5.ChecklistOrder? checklistOrder,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAll,
          [
            checklistId,
            checklistOrder,
          ],
        ),
        returnValue:
            _i3.Future<List<_i4.CheckListItem>>.value(<_i4.CheckListItem>[]),
        returnValueForMissingStub:
            _i3.Future<List<_i4.CheckListItem>>.value(<_i4.CheckListItem>[]),
      ) as _i3.Future<List<_i4.CheckListItem>>);

  @override
  _i3.Future<List<_i4.CheckListItem>> getItensWithDueDate() =>
      (super.noSuchMethod(
        Invocation.method(
          #getItensWithDueDate,
          [],
        ),
        returnValue:
            _i3.Future<List<_i4.CheckListItem>>.value(<_i4.CheckListItem>[]),
        returnValueForMissingStub:
            _i3.Future<List<_i4.CheckListItem>>.value(<_i4.CheckListItem>[]),
      ) as _i3.Future<List<_i4.CheckListItem>>);

  @override
  _i3.Future<int> updateItem(_i4.CheckListItem? checkListItem) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateItem,
          [checkListItem],
        ),
        returnValue: _i3.Future<int>.value(0),
        returnValueForMissingStub: _i3.Future<int>.value(0),
      ) as _i3.Future<int>);

  @override
  _i3.Future<int> deleteItem(_i4.CheckListItem? checkListItem) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteItem,
          [checkListItem],
        ),
        returnValue: _i3.Future<int>.value(0),
        returnValueForMissingStub: _i3.Future<int>.value(0),
      ) as _i3.Future<int>);
}

/// A class which mocks [MessageLogger].
///
/// See the documentation for Mockito's code generation for more information.
class MockMessageLogger extends _i1.Mock implements _i6.MessageLogger {
  @override
  _i3.Future<bool> writeMessage(_i7.LogMessage? logMessage) =>
      (super.noSuchMethod(
        Invocation.method(
          #writeMessage,
          [logMessage],
        ),
        returnValue: _i3.Future<bool>.value(false),
        returnValueForMissingStub: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);

  @override
  _i3.Future<List<String>> readAllLogs() => (super.noSuchMethod(
        Invocation.method(
          #readAllLogs,
          [],
        ),
        returnValue: _i3.Future<List<String>>.value(<String>[]),
        returnValueForMissingStub: _i3.Future<List<String>>.value(<String>[]),
      ) as _i3.Future<List<String>>);

  @override
  _i3.Future<List<String>> readLogsBasedOnDateTime(
    DateTime? startDate,
    DateTime? endDate,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #readLogsBasedOnDateTime,
          [
            startDate,
            endDate,
          ],
        ),
        returnValue: _i3.Future<List<String>>.value(<String>[]),
        returnValueForMissingStub: _i3.Future<List<String>>.value(<String>[]),
      ) as _i3.Future<List<String>>);
}

/// A class which mocks [CacheStore].
///
/// See the documentation for Mockito's code generation for more information.
class MockCacheStore extends _i1.Mock implements _i8.CacheStore {
  @override
  _i3.Future<_i5.ChecklistOrder?> getLastChecklistOrder() =>
      (super.noSuchMethod(
        Invocation.method(
          #getLastChecklistOrder,
          [],
        ),
        returnValue: _i3.Future<_i5.ChecklistOrder?>.value(),
        returnValueForMissingStub: _i3.Future<_i5.ChecklistOrder?>.value(),
      ) as _i3.Future<_i5.ChecklistOrder?>);

  @override
  _i3.Future<void> saveLastChecklistOrder(_i5.ChecklistOrder? checklistOrder) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveLastChecklistOrder,
          [checklistOrder],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}
