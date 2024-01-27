import 'package:checklist/app/features/checklist/checklist/models/checklist.dart';
import 'package:checklist/app/features/checklist/checklist_item/bloc/checklist_item_states.dart';
import 'package:checklist/app/features/checklist/checklist_item/models/checklist_item.dart';
import 'package:checklist/app/shared/database/dao/checklist_item_dao.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckListItemCubit extends Cubit<CheckListItemState> {
  final CheckList checkList;
  final CheckListItemDao checkListItemDao;
  final List<CheckListItem> itens = [];

  CheckListItemCubit({required this.checkListItemDao, required this.checkList})
      : super(InitialCheckListItemState()) {
    _loadItens();
  }

  Future<void> _loadItens() async {
    emit(LoadingCheckListItemState());
    itens.clear();
    itens.addAll(await checkListItemDao.getAll(checkList.id));
    itens.add(CheckListItem(
        title: "batata",
        description: "",
        checked: false,
        checklistId: checkList.id));
    emit(LoadedCheckListItemState(checkListItem: itens));
  }
}
