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
import 'package:checklist/app/shared/logs/interfaces/message_logger.dart';
import 'package:checklist/app/shared/logs/message_logger_impl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    Provider<ChecklistDAO>(create: (context) => CheckListDaoSqFlite()),
    Provider<ChecklistItemDAO>(create: (context) => CheckListItemDaoSqflite()),
    Provider<MessageLogger>(
      create: (context) => MessageLoggerImpl(),
    ),
    ProxyProvider2<ChecklistDAO, MessageLogger, CheckListController>(
      update: (context, checkListDAO, messageLogger, previous) =>
          CheckListController(
              checkListDao: checkListDAO, messagelogger: messageLogger),
    ),
    ProxyProvider2<ChecklistItemDAO, MessageLogger, ChecklistItemController>(
      update: (context, checkListItemDAO, messageLogger, previous) =>
          ChecklistItemController(
              checkListItem: checkListItemDAO, messageLogger: messageLogger),
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
