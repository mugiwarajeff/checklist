import 'package:checklist/app/app.dart';
import 'package:checklist/app/features/checklist/checklist/controllers/checklist_controller.dart';
import 'package:checklist/app/features/checklist/checklist/dao/checklist_dao.dart';
import 'package:checklist/app/features/checklist/checklist_item/controllers/checklist_item_controller.dart';
import 'package:checklist/app/features/checklist/checklist_item/dao/checklist_item_dao.dart';
import 'package:checklist/app/features/checklist/checklist_item/dao/checklist_item_dao_sqflite.dart';
import 'package:checklist/app/features/configurations/controllers/configurations_controller.dart';
import 'package:checklist/app/features/checklist/checklist/dao/checklist_dao_sqflite.dart';
import 'package:checklist/app/features/configurations/dao/configurations_dao_sqflite.dart';
import 'package:checklist/app/features/configurations/dao/interface/configurations_dao.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    Provider<ChecklistDAO>(create: (context) => CheckListDaoSqFlite()),
    Provider<ChecklistItemDAO>(create: (context) => CheckListItemDaoSqflite()),
    ProxyProvider<ChecklistDAO, CheckListController>(
      update: (context, checkListDAO, previous) =>
          CheckListController(checkListDao: checkListDAO),
    ),
    ProxyProvider<ChecklistItemDAO, ChecklistItemController>(
      update: (context, checkListItemDAO, previous) =>
          ChecklistItemController(checkListItem: checkListItemDAO),
    ),
    Provider<ConfigurationsDAO>(
      create: (context) => ConfigurationsDaoSqflite(),
    ),
    ProxyProvider<ConfigurationsDAO, ConfigurationsController>(
      update: (context, configurationsDAO, previous) =>
          ConfigurationsController(configurationsDAO: configurationsDAO),
    )
  ], child: App()));
}
