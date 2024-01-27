import 'package:checklist/app/features/checklist/checklist/models/checklist.dart';

abstract class CheckListState {}

class InitialCheckListState extends CheckListState {}

class LoadingCheckListState extends CheckListState {}

class LoadedCheckListState extends CheckListState {
  final List<CheckList> checklist;

  LoadedCheckListState({required this.checklist});
}

class ErrorCheckListState extends CheckListState {
  final String message;

  ErrorCheckListState({required this.message});
}
