// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configurations_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ConfigurationsController on ConfigurationsControllerBase, Store {
  late final _$configAtom =
      Atom(name: 'ConfigurationsControllerBase.config', context: context);

  @override
  Configurations get config {
    _$configAtom.reportRead();
    return super.config;
  }

  @override
  set config(Configurations value) {
    _$configAtom.reportWrite(value, super.config, () {
      super.config = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'ConfigurationsControllerBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$localeAtom =
      Atom(name: 'ConfigurationsControllerBase.locale', context: context);

  @override
  Locale get locale {
    _$localeAtom.reportRead();
    return super.locale;
  }

  @override
  set locale(Locale value) {
    _$localeAtom.reportWrite(value, super.locale, () {
      super.locale = value;
    });
  }

  late final _$errorAtom =
      Atom(name: 'ConfigurationsControllerBase.error', context: context);

  @override
  String get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$loadConfigsAsyncAction =
      AsyncAction('ConfigurationsControllerBase.loadConfigs', context: context);

  @override
  Future<void> loadConfigs() {
    return _$loadConfigsAsyncAction.run(() => super.loadConfigs());
  }

  late final _$toggleDarkModeAsyncAction = AsyncAction(
      'ConfigurationsControllerBase.toggleDarkMode',
      context: context);

  @override
  Future<void> toggleDarkMode() {
    return _$toggleDarkModeAsyncAction.run(() => super.toggleDarkMode());
  }

  late final _$ConfigurationsControllerBaseActionController =
      ActionController(name: 'ConfigurationsControllerBase', context: context);

  @override
  void setIsLoading(bool newState) {
    final _$actionInfo = _$ConfigurationsControllerBaseActionController
        .startAction(name: 'ConfigurationsControllerBase.setIsLoading');
    try {
      return super.setIsLoading(newState);
    } finally {
      _$ConfigurationsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String newError) {
    final _$actionInfo = _$ConfigurationsControllerBaseActionController
        .startAction(name: 'ConfigurationsControllerBase.setError');
    try {
      return super.setError(newError);
    } finally {
      _$ConfigurationsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
config: ${config},
isLoading: ${isLoading},
locale: ${locale},
error: ${error}
    ''';
  }
}
