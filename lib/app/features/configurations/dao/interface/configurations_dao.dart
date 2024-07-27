import 'package:checklist/app/features/configurations/models/configurations.dart';

abstract class ConfigurationsDAO {
  Future<int> updateConfigs(Configurations configurations);

  Future<Configurations> getConfig();
}
