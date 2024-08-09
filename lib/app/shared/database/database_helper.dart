import 'package:checklist/app/features/configurations/models/configurations.dart';
import 'package:checklist/app/features/checklist/checklist/dao/checklist_dao_sqflite.dart';
import 'package:checklist/app/features/checklist/checklist_item/dao/checklist_item_dao_sqflite.dart';
import 'package:checklist/app/features/configurations/dao/configurations_dao_sqflite.dart';
import 'package:sqflite/sqflite.dart';
import "package:path/path.dart";

class DatabaseHelper {
  static Future<String> get _databasePath async => await getDatabasesPath();
  static const String _databaseName = "checklist_6";
  static const int _databaseVersion = 4;
  static Database? _instance;

  DatabaseHelper._();

  static Future<Database> get instance async {
    if (_instance == null) {
      await _initDatabase();
    }

    return _instance!;
  }

  static Future<void> _initDatabase() async {
    final String databaseFullPath = join(await _databasePath, _databaseName);
    final Configurations configurationsObject = Configurations(darkMode: false);
    _instance = await openDatabase(
      databaseFullPath,
      version: _databaseVersion,
      singleInstance: true,
      onCreate: (db, version) async {
        db.execute(CheckListDaoSqFlite.createTableSql);
        db.execute(CheckListItemDaoSqflite.createTableSql);
        db.execute(ConfigurationsDaoSqflite.createTableSql);
        db.insert(
            ConfigurationsDaoSqflite.tableName, configurationsObject.toJson());
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await deleteDatabase(databaseFullPath);
      },
    );
  }
}
