import 'package:bloc/bloc.dart';
import 'package:checklist/app/features/configurations/cubit/configurations_state.dart';
import 'package:checklist/app/features/configurations/models/configurations.dart';
import 'package:checklist/app/shared/database/dao/configurations_dao.dart';

class ConfigurationsCubit extends Cubit<ConfigurationsState> {
  final ConfigurationsDao configurationsDao;
  Configurations configObject = Configurations.empty();

  ConfigurationsCubit({required this.configurationsDao})
      : super(InitialConfigurationsState()) {
    _loadDarkMode();
  }

  Future<void> _loadDarkMode() async {
    emit(LoadingConfigurationsState());
    configObject = await configurationsDao.getConfig();
    emit(LoadedConfigurationsState(configObject: configObject));
  }

  void toggleDarkMode() {
    configObject.darkMode = !configObject.darkMode;
    configurationsDao.updateConfigs(configObject);

    emit(LoadedConfigurationsState(configObject: configObject));
  }
}
