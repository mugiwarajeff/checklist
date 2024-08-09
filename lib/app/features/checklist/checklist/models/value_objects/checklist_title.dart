import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:checklist/app/shared/value_object/value_object.dart';

class CheckListTitle extends ValueObject {
  CheckListTitle({required super.value});

  @override
  String? validate(String? toValidate, AppLocalizations? appLocalizations) {
    String? error;

    if (toValidate != null && toValidate.isEmpty) {
      error = appLocalizations!.emptyField;
    } else if (toValidate != null && toValidate.length < 4) {
      error = "Texto muito Pequeno";
    }

    return error;
  }
}
