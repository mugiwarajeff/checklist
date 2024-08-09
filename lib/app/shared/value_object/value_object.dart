import "package:flutter_gen/gen_l10n/app_localizations.dart";

abstract class ValueObject<T> {
  final T value;

  ValueObject({required this.value});

  String? validate(String? toValidate, AppLocalizations? appLocalizations);
}
