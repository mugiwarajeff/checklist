import 'dart:ui';

import 'package:checklist/app/features/configurations/dao/interface/configurations_dao.dart';
import 'package:checklist/app/features/configurations/models/configurations.dart';
import 'package:mobx/mobx.dart';
import 'package:sqflite/sqflite.dart';
part 'configurations_controller.g.dart';

class ConfigurationsController = ConfigurationsControllerBase
    with _$ConfigurationsController;

abstract class ConfigurationsControllerBase with Store {
  final ConfigurationsDAO _configurationsDAO;

  @observable
  Configurations config = Configurations.empty();

  @observable
  bool isLoading = false;

  @observable
  Locale locale = const Locale("pt", "BR");

  @observable
  String error = "";

  ConfigurationsControllerBase({required ConfigurationsDAO configurationsDAO})
      : _configurationsDAO = configurationsDAO;

  @action
  void setIsLoading(bool newState) {
    isLoading = newState;
  }

  @action
  void setError(String newError) {
    error = newError;
  }

  @action
  Future<void> loadConfigs() async {
    setIsLoading(true);

    try {
      config = await _configurationsDAO.getConfig();
    } on DatabaseException catch (e) {
      setError(e.toString());
    }

    setIsLoading(false);
  }

  @action
  Future<void> toggleDarkMode() async {
    setIsLoading(true);
    try {
      config.darkMode = !config.darkMode;
      await _configurationsDAO.updateConfigs(config);
    } on DatabaseException catch (e) {
      setError(e.toString());
    }

    setIsLoading(false);
  }
}
