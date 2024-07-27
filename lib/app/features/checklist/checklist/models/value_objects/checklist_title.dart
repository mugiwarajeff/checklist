import 'package:checklist/app/shared/value_object/value_object.dart';

class CheckListTitle extends ValueObject {
  CheckListTitle({required super.value});

  @override
  String? validate(String? toValidate) {
    String? error;

    if (toValidate != null && toValidate.isEmpty) {
      error = "Valor está vazio";
    } else if (toValidate != null && toValidate.length < 4) {
      error = "Texto muito Pequeno";
    }

    return error;
  }
}
