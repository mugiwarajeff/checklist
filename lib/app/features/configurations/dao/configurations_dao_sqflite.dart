import 'package:checklist/app/features/configurations/dao/interface/configurations_dao.dart';
import 'package:checklist/app/features/configurations/models/configurations.dart';
import 'package:checklist/app/shared/database/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class ConfigurationsDaoSqflite implements ConfigurationsDAO {
  static const String _tableName = "configurations";
  static String get tableName => _tableName;

  static const String _darkMode = "dark_mode";

  static const String createTableSql = 'CREATE TABLE $_tableName('
      '$_darkMode INTEGER'
      ')';

  @override
  Future<int> updateConfigs(Configurations configurations) async {
    Database database = await DatabaseHelper.instance;
    int updatedIten =
        await database.update(_tableName, configurations.toJson());

    print(updatedIten);

    return updatedIten;
  }

  @override
  Future<Configurations> getConfig() async {
    Database database = await DatabaseHelper.instance;
    List<Map<String, Object?>> configMap = await database.query(_tableName);

    Configurations configObject = Configurations.fromJson(configMap.first);
    return configObject;
  }
}
