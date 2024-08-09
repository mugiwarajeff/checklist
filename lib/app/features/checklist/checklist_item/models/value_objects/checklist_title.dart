import 'package:checklist/app/shared/value_object/value_object.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChecklistItemTitle extends ValueObject<String> {
  ChecklistItemTitle({required super.value});

  @override
  String? validate(String? toValidate, AppLocalizations? appLocalizations) {
    String? error;

    if (toValidate == null || toValidate == "") {
      error = appLocalizations!.emptyField;
    }

    return error;
  }
}
