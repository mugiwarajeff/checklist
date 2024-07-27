// Mocks generated by Mockito 5.4.4 from annotations
// in checklist/test/features/checklist/checklist_item/controllers/checklist_controller_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:checklist/app/features/checklist/checklist_item/dao/checklist_item_dao.dart'
    as _i2;
import 'package:checklist/app/features/checklist/checklist_item/models/checklist_item.dart'
    as _i4;
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
  _i3.Future<List<_i4.CheckListItem>> getAll(String? checklistId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAll,
          [checklistId],
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