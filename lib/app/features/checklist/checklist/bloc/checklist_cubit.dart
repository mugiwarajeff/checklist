import 'package:checklist/app/features/checklist/checklist/bloc/checklist_state.dart';
import 'package:checklist/app/features/checklist/checklist/models/checklist.dart';
import 'package:checklist/app/shared/database/dao/checklist_dao.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckListCubit extends Cubit<CheckListState> {
  final List<CheckList> checklists = [];
  final CheckListDao checkListDao;
  CheckListCubit({required this.checkListDao}) : super(InitialCheckListState());

  Future<void> loadCheckList() async {
    emit(LoadingCheckListState());
    checklists.clear();
    checklists.addAll(await checkListDao.getAll());
    emit(LoadedCheckListState(checklist: checklists));
  }

  Future<void> addCheckList(CheckList checkList) async {
    emit(LoadingCheckListState());

    checklists.add(checkList);
    await checkListDao.insert(checkList);

    emit(LoadedCheckListState(checklist: checklists));
  }
}
