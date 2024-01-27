import 'package:checklist/app/features/configurations/models/configurations.dart';
import 'package:checklist/app/shared/database/dao/checklist_dao.dart';
import 'package:checklist/app/shared/database/dao/checklist_item_dao.dart';
import 'package:checklist/app/shared/database/dao/configurations_dao.dart';
import 'package:sqflite/sqflite.dart';
import "package:path/path.dart";

class DatabaseHelper {
  static Future<String> get _databasePath async => await getDatabasesPath();
  static const String _databaseName = "checklist";
  static const int _databaseVersion = 3;
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
        db.execute(CheckListDao.createTableSql);
        db.execute(CheckListItemDao.createTableSql);
        db.execute(ConfigurationsDao.createTableSql);
        db.insert(ConfigurationsDao.tableName, configurationsObject.toJson());
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await deleteDatabase(databaseFullPath);
      },
    );
  }
}
