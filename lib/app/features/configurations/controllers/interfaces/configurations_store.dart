import 'package:checklist/app/features/configurations/models/configurations.dart';

abstract class ConfigurationsStore {
  Configurations config = Configurations.empty();

  bool isLoading = false;

  String error = "";

  Future<void> loadConfigs();

  void toggleDarkMode();
}
