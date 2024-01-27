import 'package:checklist/app/app.dart';
import 'package:checklist/app/features/checklist/checklist/bloc/checklist_cubit.dart';
import 'package:checklist/app/features/configurations/cubit/configurations_cubit.dart';
import 'package:checklist/app/shared/database/dao/checklist_dao.dart';
import 'package:checklist/app/shared/database/dao/configurations_dao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final ConfigurationsDao configurationsDao = ConfigurationsDao();
  final CheckListDao checkListDao = CheckListDao();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(
        create: (context) =>
            ConfigurationsCubit(configurationsDao: configurationsDao)),
    BlocProvider(
        create: (context) => CheckListCubit(checkListDao: checkListDao)),
  ], child: App()));
}
