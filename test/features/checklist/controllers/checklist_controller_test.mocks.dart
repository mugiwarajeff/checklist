// Mocks generated by Mockito 5.4.4 from annotations
// in checklist/test/features/checklist/controllers/checklist_controller_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:checklist/app/features/checklist/checklist/dao/checklist_dao.dart'
    as _i2;
import 'package:checklist/app/features/checklist/checklist/models/checklist.dart'
    as _i4;
import 'package:checklist/app/shared/logs/interfaces/message_logger.dart'
    as _i5;
import 'package:checklist/app/shared/logs/models/log_message.dart' as _i6;
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

/// A class which mocks [ChecklistDAO].
///
/// See the documentation for Mockito's code generation for more information.
class MockChecklistDAO extends _i1.Mock implements _i2.ChecklistDAO {
  @override
  _i3.Future<List<_i4.CheckList>> getAll() => (super.noSuchMethod(
        Invocation.method(
          #getAll,
          [],
        ),
        returnValue: _i3.Future<List<_i4.CheckList>>.value(<_i4.CheckList>[]),
        returnValueForMissingStub:
            _i3.Future<List<_i4.CheckList>>.value(<_i4.CheckList>[]),
      ) as _i3.Future<List<_i4.CheckList>>);

  @override
  _i3.Future<int> insert(_i4.CheckList? checkList) => (super.noSuchMethod(
        Invocation.method(
          #insert,
          [checkList],
        ),
        returnValue: _i3.Future<int>.value(0),
        returnValueForMissingStub: _i3.Future<int>.value(0),
      ) as _i3.Future<int>);

  @override
  _i3.Future<int> getCheckListCount() => (super.noSuchMethod(
        Invocation.method(
          #getCheckListCount,
          [],
        ),
        returnValue: _i3.Future<int>.value(0),
        returnValueForMissingStub: _i3.Future<int>.value(0),
      ) as _i3.Future<int>);

  @override
  _i3.Future<int> updateChecklist(_i4.CheckList? checklist) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateChecklist,
          [checklist],
        ),
        returnValue: _i3.Future<int>.value(0),
        returnValueForMissingStub: _i3.Future<int>.value(0),
      ) as _i3.Future<int>);

  @override
  _i3.Future<int> deleteCheckList(_i4.CheckList? checklist) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteCheckList,
          [checklist],
        ),
        returnValue: _i3.Future<int>.value(0),
        returnValueForMissingStub: _i3.Future<int>.value(0),
      ) as _i3.Future<int>);
}

/// A class which mocks [MessageLogger].
///
/// See the documentation for Mockito's code generation for more information.
class MockMessageLogger extends _i1.Mock implements _i5.MessageLogger {
  @override
  _i3.Future<bool> writeMessage(_i6.LogMessage? logMessage) =>
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
