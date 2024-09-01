import 'package:checklist/app/shared/value_object/value_object.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReferenceLink extends ValueObject<String> {
  ReferenceLink({required super.value});

  @override
  String? validate(String? toValidate, AppLocalizations? appLocalizations) {
    String? message;
    const String linkPathern =
        r"^(https?:\/\/)?(([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,})(\/[^\s]*)?$";

    RegExp linkExp = RegExp(linkPathern);

    bool validated = linkExp.hasMatch(toValidate ?? "");

    if (!validated) {
      message = "Este campo deve conter um Link valido";
    }

    if (message == null || message.isEmpty || message == "") {
      message = null;
    }

    return message;
  }
}
