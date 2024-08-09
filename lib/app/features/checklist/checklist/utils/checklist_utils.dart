import 'package:checklist/app/features/checklist/checklist/enum/checklist_category.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChecklistUtils {
  static String translateCategory(
      ChecklistCategory category, AppLocalizations appLocalizations) {
    final String shoppingText = appLocalizations.shopping;
    final String houseText = appLocalizations.house;

    final String workText = appLocalizations.work;
    final String studyText = appLocalizations.study;
    final String othersText = appLocalizations.others;
    final String marketText = appLocalizations.market;

    switch (category) {
      case ChecklistCategory.shopping:
        return shoppingText;
      case ChecklistCategory.house:
        return houseText;
      case ChecklistCategory.work:
        return workText;
      case ChecklistCategory.study:
        return studyText;
      case ChecklistCategory.others:
        return othersText;
      case ChecklistCategory.market:
        return marketText;
    }
  }
}
