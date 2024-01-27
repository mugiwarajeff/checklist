import 'package:checklist/app/features/checklist/checklist/models/checklist.dart';
import 'package:checklist/app/features/checklist/checklist_item/bloc/checklist_item_states.dart';
import 'package:checklist/app/features/checklist/checklist_item/models/checklist_item.dart';
import 'package:checklist/app/shared/database/dao/checklist_item_dao.dart';
import 'package:checklist/app/shared/exceptions/create_item_exception.dart';
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
    emit(LoadedCheckListItemState(checkListItem: itens));
  }

  Future<void> addItem(CheckListItem checkListItem) async {
    //emit(LoadingCheckListItemState());
    try {
      await checkListItemDao.insertItem(checkListItem);
      itens.add(checkListItem);
    } on CreateItemException catch (error) {
      emit(ErrorCheckListItemState(message: error.error));
    }
    emit(LoadedCheckListItemState(checkListItem: itens));
  }

  Future<void> updateItem(CheckListItem checkListItem) async {
    //emit(LoadingCheckListItemState());

    await checkListItemDao.updateItem(checkListItem);
    int index = itens.indexOf(checkListItem);
    itens[index] = checkListItem;
    emit(LoadedCheckListItemState(checkListItem: itens));
  }

  Future<void> deleteItem(CheckListItem checkListItem) async {
    //emit(LoadingCheckListItemState());

    await checkListItemDao.deleteItem(checkListItem);
    itens.remove(checkListItem);
    emit(LoadedCheckListItemState(checkListItem: itens));
  }

  Future<void> openAddField() async {
    emit(LoadedWithAddCheckListItemState(checkListItem: itens));
  }

  void closeAddField() async {
    emit(LoadedCheckListItemState(checkListItem: itens));
  }
}
