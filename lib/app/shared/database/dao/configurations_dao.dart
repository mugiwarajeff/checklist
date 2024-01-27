import 'package:checklist/app/features/configurations/models/configurations.dart';
import 'package:checklist/app/shared/database/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class ConfigurationsDao {
  static const String _tableName = "configurations";
  static String get tableName => _tableName;

  static const String _darkMode = "dark_mode";

  static const String createTableSql = 'CREATE TABLE $_tableName('
      '$_darkMode INTEGER'
      ')';

  Future<int> updateConfigs(Configurations configurations) async {
    Database database = await DatabaseHelper.instance;
    int updatedIten =
        await database.update(_tableName, configurations.toJson());

    return updatedIten;
  }

  Future<Configurations> getConfig() async {
    Database database = await DatabaseHelper.instance;
    List<Map<String, Object?>> configMap = await database.query(_tableName);

    Configurations configObject = Configurations.fromJson(configMap.first);
    return configObject;
  }
}
