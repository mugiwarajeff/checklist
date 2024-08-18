import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChecklistUtils {
  static String translateCategory(
      String category, AppLocalizations appLocalizations) {
    final String shoppingText = appLocalizations.shopping;
    final String houseText = appLocalizations.house;

    final String workText = appLocalizations.work;
    final String studyText = appLocalizations.study;
    final String othersText = appLocalizations.others;
    final String marketText = appLocalizations.market;

    switch (category) {
      case "shopping":
        return shoppingText;
      case "house":
        return houseText;
      case "work":
        return workText;
      case "study":
        return studyText;
      case "others":
        return othersText;
      case "market":
        return marketText;
      default:
        return category;
    }
  }
}
