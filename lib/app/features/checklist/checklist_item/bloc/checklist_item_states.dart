import 'package:checklist/app/features/checklist/checklist_item/models/checklist_item.dart';

abstract class CheckListItemState {}

class InitialCheckListItemState extends CheckListItemState {}

class LoadingCheckListItemState extends CheckListItemState {}

class LoadedCheckListItemState extends CheckListItemState {
  final List<CheckListItem> checkListItem;

  LoadedCheckListItemState({required this.checkListItem});
}

class ErrorCheckListItemState extends CheckListItemState {
  final String message;

  ErrorCheckListItemState({required this.message});
}
