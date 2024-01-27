import 'package:checklist/app/features/configurations/models/configurations.dart';

abstract class ConfigurationsState {}

class InitialConfigurationsState extends ConfigurationsState {}

class LoadingConfigurationsState extends ConfigurationsState {}

class LoadedConfigurationsState extends ConfigurationsState {
  final Configurations configObject;

  LoadedConfigurationsState({required this.configObject});
}

class ErrorConfigurationsState extends ConfigurationsState {}
